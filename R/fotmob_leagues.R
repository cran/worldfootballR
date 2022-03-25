
## TODO: Cache this.
.fotmob_load_csv <- function(suffix) {
  read.csv(
    sprintf("https://raw.githubusercontent.com/JaseZiv/worldfootballR_data/master/raw-data/%s", suffix),
    stringsAsFactors = FALSE
  )
}

#' @importFrom purrr transpose map_dfr
#' @importFrom dplyr filter
.fotmob_get_league_or_season_urls <- function(
  leagues,
  league_id = NULL,
  country = NULL,
  league_name = NULL
) {
  has_country <- !is.null(country)
  has_league_name <- !is.null(league_name)
  has_league_id <- !is.null(league_id)
  is_league_ids <- !any(names(leagues) == "season_id")
  if(!has_league_id & !(has_country & has_league_name)) {
    stop(
      "Must provide `league_id` or both of `country` and `league_name`."
    )
  }

  has_country_and_league_name <- has_country & has_league_name
  urls <- if(has_country_and_league_name) {
    n_country <- length(country)
    n_league_name <- length(league_name)
    if(n_country != n_league_name) {
      stop(
        sprintf(
          "If providing `country` and `league_name`, length of each must be the same (%s != %s).",
          n_country,
          n_league_name
        )
      )
    }

    pairs <- list(
      country = country,
      league_name = league_name
    ) %>%
      purrr::transpose()

    purrr::map_dfr(
      pairs,
      ~dplyr::filter(
        leagues,
        .data$ccode == .x$country, .data$name == .x$league_name
      )
    )
  } else {
    leagues %>%
      dplyr::filter(.data$id %in% league_id)
  }

  n_urls <- nrow(urls)
  if(n_urls == 0) {
    stop(
      "Could not find any leagues matching specified parameters."
    )
  }

  n_params <- ifelse(
    has_country_and_league_name,
    n_country,
    length(league_id)
  )

  if(is_league_ids & (n_urls < n_params)) {
    warning(
      sprintf(
        "Found less leagues than specified (%s < %s).",
        n_urls,
        n_params
      )
    )
  } else if (is_league_ids & (n_urls > n_params)) {
    warning(
      sprintf(
        "Found more leagues than specified (%s > %s).",
        n_urls,
        n_params
      )
    )
  }
  urls
}


#' Get fotmob league ids
#'
#' Returns a dataframe of the league ids available on fotmob
#'
#' @param cached Whether to load the dataframe from the \href{https://github.com/JaseZiv/worldfootballR_data/blob/master/raw-data/fotmob-leagues/all_leagues.csv}{data CSV}. This is faster and most likely what you want to do, unless you identify a league that's being tracked by fotmob that's not in this pre-saved CSV.
#'
#' @importFrom rvest read_html html_elements html_text
#' @importFrom purrr keep map_dfr
#' @importFrom stringr str_extract
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble
#' @importFrom dplyr rename
#' @importFrom tidyr unnest
#' @importFrom janitor clean_names
#' @export
fotmob_get_league_ids <- function(cached = TRUE) {
  if(cached) {
    return(.fotmob_load_csv("fotmob-leagues/all_leagues.csv"))
  }

  page <- "https://www.fotmob.com/" %>%
    rvest::read_html()

  league_element <- page %>%
    rvest::html_elements("script") %>%
    rvest::html_text(trim = TRUE) %>%
    purrr::keep(stringr::str_detect, "lsLeague")

  .extract_leagues <- function(rgx) {
    league_element %>%
      stringr::str_extract(rgx) %>%
      jsonlite::fromJSON() %>%
      tibble::as_tibble() %>%
      dplyr::rename(
        country = .data$name
      ) %>%
      tidyr::unnest(.data$leagues) %>%
      janitor::clean_names()
  }

  purrr::map_dfr(
    c(
      '(?<=\\"international\\"[:]).*(?=\\,\\"countries\\")',
      '(?<=\\"countries\\"[:]).*(?=\\,\\"userSettings\\":null[}]\\,\\"userSettings\\")'
    ),
    .extract_leagues
  )
}


.fotmob_get_league_ids <- function(cached = TRUE, ...) {
  leagues <- fotmob_get_league_ids(cached = cached)
  .fotmob_get_league_or_season_urls(
    leagues = leagues,
    ...
  )
}

#' @importFrom jsonlite fromJSON
.fotmob_get_league_resp <- function(league_id) {
  url <- sprintf("https://www.fotmob.com/leagues?id=%s", league_id)
  jsonlite::fromJSON(url)
}

#' Get fotmob match results by league
#'
#' Returns match results for all matches played on the selected date from fotmob.com.
#'
#' @param country Three character country code. Can be one or multiple. If provided, `league_name` must also be provided (of the same length)
#' @param league_name League names. If provided, `country` must also be provided (of the same length)
#' @param league_id Fotmob ID for the league. Only used if `country` and `league_name` are not specified.
#' @inheritParams fotmob_get_league_ids
#'
#' @return returns a dataframe of league matches
#'
#' @importFrom purrr possibly map_dfr
#' @importFrom tibble tibble
#' @importFrom rlang maybe_missing
#'
#' @export
#'
#' @examples
#' \dontrun{
#' library(dplyr)
#' library(tidyr)
#'
#' # one league
#' fotmob_get_league_matches(
#'   country = "ENG",
#'   league_name = "Premier League"
#' )
#'
#' # one league, by id
#' fotmob_get_league_matches(
#'   league_id = 47
#' )
#'
#' # multiple leagues (could also use ids)
#' league_matches <- fotmob_get_league_matches(
#'   country =     c("ENG",            "ESP"   ),
#'   league_name = c("Premier League", "LaLiga")
#' )
#'
#' # probably the data that you care about
#' league_matches %>%
#'   dplyr::select(match_id = id, home, away) %>%
#'   tidyr::unnest_wider(c(home, away), names_sep = "_")
#' }
fotmob_get_league_matches <- function(country, league_name, league_id, cached = TRUE) {

  urls <- .fotmob_get_league_ids(
    cached = cached,
    country = rlang::maybe_missing(country, NULL),
    league_name = rlang::maybe_missing(league_name, NULL),
    league_id = rlang::maybe_missing(league_id, NULL)
  )

  fp <- purrr::possibly(
    .fotmob_get_league_matches,
    quiet = FALSE,
    otherwise = tibble::tibble()
  )
  purrr::map_dfr(
    urls$id,
    .fotmob_get_league_matches
  )
}

#' @importFrom janitor clean_names
#' @importFrom tibble as_tibble
.fotmob_get_league_matches <- function(league_id) {
  resp <- .fotmob_get_league_resp(league_id)
  resp$fixtures %>%
    janitor::clean_names() %>%
    tibble::as_tibble()
}

#' Get standings from fotmob
#'
#' Returns league standings from fotmob.com. 3 types are returned: all, home, away
#'
#' @inheritParams fotmob_get_league_matches
#'
#' @return returns a dataframe of league standings
#'
#' @importFrom purrr possibly map_dfr
#' @importFrom tibble tibble
#' @importFrom rlang maybe_missing
#'
#' @export
#'
#' @examples
#' \dontrun{
#' library(dplyr)
#' library(tidyr)
#'
#' # one league
#' fotmob_get_league_tables(
#'   country = "ENG",
#'   league_name = "Premier League"
#' )
#'
#' # one league, by id
#' fotmob_get_league_tables(
#'   league_id = 47
#' )
#'
#' # multiple leagues (could also use ids)
#' league_tables <- fotmob_get_league_tables(
#'   country =     c("ENG",            "ESP"   ),
#'   league_name = c("Premier League", "LaLiga")
#' )
#'
#' # look at tables if only away matches are considered
#' league_tables %>%
#'   dplyr::filter(table_type == "away")
#' }
fotmob_get_league_tables <- function(country, league_name, league_id, cached = TRUE) {

  urls <- .fotmob_get_league_ids(
    cached = cached,
    country = rlang::maybe_missing(country, NULL),
    league_name = rlang::maybe_missing(league_name, NULL),
    league_id = rlang::maybe_missing(league_id, NULL)
  )

  fp <- purrr::possibly(
    .fotmob_get_league_tables,
    quiet = FALSE,
    otherwise = tibble::tibble()
  )
  purrr::map_dfr(
    urls$id,
    fp
  )
}

#' @importFrom janitor clean_names
#' @importFrom tibble as_tibble
#' @importFrom rlang .data
#' @importFrom tidyr pivot_longer unnest_longer unnest
.fotmob_get_league_tables <- function(league_id) {
  resp <- .fotmob_get_league_resp(league_id)
  table <- resp$tableData$table %>%
    janitor::clean_names() %>%
    tibble::as_tibble()
  table %>%
    tidyr::pivot_longer(
      colnames(table),
      names_to = "table_type",
      values_to = "table"
    ) %>%
    tidyr::unnest_longer(
      .data$table
    ) %>%
    tidyr::unnest(
      .data$table
    ) %>%
    janitor::clean_names() %>%
    tibble::as_tibble()
}