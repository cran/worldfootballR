## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message=FALSE,
  warning=FALSE
)

## ----cran-installation, eval=FALSE--------------------------------------------
#  install.packages("worldfootballR")

## ----gh-installation, eval=FALSE----------------------------------------------
#  # install.packages("devtools")
#  devtools::install_github("JaseZiv/worldfootballR")

## ----load_libs, warning=FALSE, message=FALSE----------------------------------
library(worldfootballR)
library(dplyr)
library(tidyr)

## ----epl_team_xg_2021---------------------------------------------------------
epl_team_xg_2021 <- fotmob_get_season_stats(
  country = "ENG",
  league_name = "Premier League",
  season = "2020/2021",
  stat_type = "xg",
  team_or_player = "team"
)

epl_team_xg_2021 %>%
  dplyr::select(
    league_id = id,
    league_name = name,
    season_id,
    season_name,
    team_id,
    team_name = participant_name,
    matches_played,
    xg = stat_value,
    g = sub_stat_value
  ) %>%
  dplyr::glimpse()

## ----team_xg_conceded_2021----------------------------------------------------
team_xg_conceded_2021 <- fotmob_get_season_stats(
  country =     c("ITA",     "ESP"),
  league_name = c("Serie A", "LaLiga"),
  season = c("2020/2021", "2021/2022"),
  stat_type = "xg_conceded",
  team_or_player = "team"
)

## 2 leagues x 20 teams x 2 seasons = 80 records
team_xg_conceded_2021 %>% nrow()

## ----epl_player_xg_2021-------------------------------------------------------
epl_player_xg_2021 <- fotmob_get_season_stats(
  country = "ENG",
  league_name = "Premier League",
  season = "2020/2021",
  stat_type = "xg",
  team_or_player = "player"
)

epl_player_xg_2021 %>%
  dplyr::select(
    league_id = id,
    league_name = name,
    season_id,
    season_name,
    team_id,
    ## NOTE: particiant_id is a typo on behalf of fotmob! We leave it as is.
    player_id = particiant_id,
    player_name = participant_name,
    minutes_played,
    matches_played,
    xg = stat_value,
    g = sub_stat_value
  ) %>%
  dplyr::glimpse()

## ----fotmob_get_league_matches------------------------------------------------
league_matches <- fotmob_get_league_matches(
  country =     c("ENG",            "ESP"   ),
  league_name = c("Premier League", "LaLiga")
)

league_matches_unnested <- league_matches %>%
  dplyr::select(match_id = id, home, away) %>%
  tidyr::unnest_wider(c(home, away), names_sep = "_")
dplyr::glimpse(league_matches_unnested)

## ----fotmob_get_matches_by_date-----------------------------------------------
results <- fotmob_get_matches_by_date(date = c("20210925", "20210926"))
dplyr::glimpse(results)

## ----fotmob_match_ids---------------------------------------------------------
filtered_results <- results %>%
  dplyr::select(primary_id, ccode, league_name = name, matches) %>%
  dplyr::filter(league_name == "Premier League", ccode == "ENG")

# one way of getting data out of the results
unnested_results <- filtered_results %>% 
  tidyr::unnest_longer(matches)

match_ids <- unnested_results %>% 
  dplyr::pull(matches) %>% 
  dplyr::pull(id)
match_ids

## ----fotmob_unnested_results--------------------------------------------------
unnested_results %>% 
  dplyr::pull(matches) %>% 
  dplyr::glimpse()

## ----fotmob_get_league_tables-------------------------------------------------
league_tables <- fotmob_get_league_tables(
  country =     c("ENG",            "ESP"   ),
  league_name = c("Premier League", "LaLiga")
)
# or
# league_tables <- fotmob_get_league_tables(league_id = c(47, 87))

away_league_tables <- league_tables %>%
  dplyr::filter(table_type == "away")
dplyr::glimpse(away_league_tables)

## ----fotmob_match_details-----------------------------------------------------
fotmob_matches <- c(3609994, 3610132)
match_details <- fotmob_get_match_details(fotmob_matches)
dplyr::glimpse(match_details)

## ----fotmob_match_shots-------------------------------------------------------
match_shots <- match_details %>% 
  dplyr::select(
    match_id,
    shots
  ) %>% 
  tidyr::unnest(shots)
dplyr::glimpse(match_shots)

## ----on_goal_shots------------------------------------------------------------
match_shots %>%
  dplyr::select(on_goal_shot) %>%
  tidyr::unnest_wider(
    on_goal_shot
  )

## ----fotmob_players-----------------------------------------------------------
players <- fotmob_get_match_players(fotmob_matches)
dplyr::glimpse(players)

## ----salah_shotmap------------------------------------------------------------
salah <- players %>% dplyr::filter(id == "292462")
salah_shotmap <- salah %>% 
  dplyr::select(player_id = id, shotmap) %>% 
  tidyr::unnest(shotmap)
dplyr::glimpse(salah_shotmap)

## ----salah_stats--------------------------------------------------------------
salah_stats <- salah %>% 
  dplyr::select(stats) %>% 
  tidyr::unnest(stats)
dplyr::glimpse(salah_stats)

