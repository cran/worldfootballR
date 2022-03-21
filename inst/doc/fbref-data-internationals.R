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

## ----match_urls_int, eval=FALSE-----------------------------------------------
#  wc_2018_urls <- get_match_urls(country = "", gender = "M", season_end_year = 2018, tier = "", non_dom_league_url = "https://fbref.com/en/comps/1/history/World-Cup-Seasons")
#  
#  friendly_int_2021_urls <- get_match_urls(country = "", gender = "M", season_end_year = 2021, tier = "", non_dom_league_url = "https://fbref.com/en/comps/218/history/Friendlies-M-Seasons")
#  
#  euro_2021_urls <- get_match_urls(country = "", gender = "M", season_end_year = 2021, tier = "", non_dom_league_url = "https://fbref.com/en/comps/676/history/European-Championship-Seasons")
#  
#  copa_2019_urls <- get_match_urls(country = "", gender = "M", season_end_year = 2019, tier = "", non_dom_league_url = "https://fbref.com/en/comps/685/history/Copa-America-Seasons")

## ----get_int_match_results_int, eval=FALSE------------------------------------
#  # euro 2016 results
#  euro_2016_results <- get_match_results(country = "", gender = "M", season_end_year = 2016, tier = "", non_dom_league_url = "https://fbref.com/en/comps/676/history/European-Championship-Seasons")
#  
#  # 2019 Copa America results:
#  copa_2019_results <- get_match_results(country = "", gender = "M", season_end_year = 2019, non_dom_league_url = "https://fbref.com/en/comps/685/history/Copa-America-Seasons")
#  
#  # for international friendlies:
#  international_results <- get_match_results(country = "", gender = "M", season_end_year = 2021, tier = "", non_dom_league_url = "https://fbref.com/en/comps/218/history/Friendlies-M-Seasons")

## ----get_match_report_int, eval=FALSE-----------------------------------------
#  # function to extract match report data for 2018 world cup
#  wc_2018_report <- get_match_report(match_url = wc_2018_urls)
#  # function to extract match report data for 2021 international friendlies
#  friendlies_report <- get_match_report(match_url = friendly_int_2021_urls)

## ----get_match_summary_int, eval=FALSE----------------------------------------
#  # first get the URLs for the 2016 Euros
#  euro_2016_match_urls <- get_match_urls(country = "", gender = "M", season_end_year = 2016, tier = "", non_dom_league_url = "https://fbref.com/en/comps/676/history/European-Championship-Seasons")
#  
#  # then pass these to the function to get match summaries:
#  euro_2016_events <- get_match_summary(euro_2016_match_urls)

## ----get_match_lineups_int, eval=FALSE----------------------------------------
#  # function to extract match lineups
#  copa_2019_lineups <- get_match_lineups(match_url = copa_2019_urls)

## ----get_shot_and_creation_int, eval=FALSE------------------------------------
#  shots_wc_2018 <- get_match_shooting(wc_2018_urls)

## ----get_advanced_match_stats_int, eval=FALSE---------------------------------
#  advanced_match_stats_player <- get_advanced_match_stats(match_url = wc_2018_urls, stat_type = "possession", team_or_player = "player")

## ----get_advanced_match_stats_team_int, eval=FALSE----------------------------
#  advanced_match_stats_team <- get_advanced_match_stats(match_url = wc_2018_urls, stat_type = "passing_types", team_or_player = "team")

