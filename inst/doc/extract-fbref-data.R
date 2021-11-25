## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message=FALSE,
  warning=FALSE
)

## ----gh-installation, eval=FALSE----------------------------------------------
#  # install.packages("devtools")
#  devtools::install_github("JaseZiv/worldfootballR")

## ----load_libs, warning=FALSE, message=FALSE----------------------------------
library(worldfootballR)

## ----mapped_players-----------------------------------------------------------
mapped_players <- player_dictionary_mapping()
dplyr::glimpse(mapped_players)

## ----get_league_urls, eval=FALSE----------------------------------------------
#  fb_league_urls(country = "ENG", gender = "M", season_end_year = 2021, tier = '2nd')

## ----get_team_urls, eval=FALSE------------------------------------------------
#  fb_teams_urls("https://fbref.com/en/comps/9/Premier-League-Stats")

## ---- eval=FALSE--------------------------------------------------------------
#  fb_player_urls("https://fbref.com/en/squads/fd962109/Fulham-Stats")

## ----match_urls, eval=FALSE---------------------------------------------------
#  epl_2021_urls <- get_match_urls(country = "ENG", gender = "M", season_end_year = 2021, tier="1st")

## ----get_season_team_stats, eval=FALSE----------------------------------------
#  # function to extract season teams stats
#  prem_2020_shooting <- get_season_team_stats(country = "ENG", gender = "M", season_end_year = "2020", tier = "1st", stat_type = "shooting")
#  # to get shooting stats for the English Championship:
#  championship_2020_shooting <- get_season_team_stats(country = "ENG", gender = "M", season_end_year = "2020", tier = "2nd", stat_type = "shooting")

## ----get_season_team_stats_multiple, eval=FALSE-------------------------------
#  big_5_2020_possessions <- get_season_team_stats(country = c("ENG", "ESP", "ITA", "GER", "FRA"),
#                                          gender = "M", season_end_year = 2020, tier = "1st", stat_type = "possession")

## ----big5_team, eval=FALSE----------------------------------------------------
#  big5_team_shooting <- fb_big5_advanced_season_stats(season_end_year= c(2019:2021), stat_type= "shooting", team_or_player= "team")

## ----get_match_results, eval=FALSE--------------------------------------------
#  # function to extract Serie A match results data
#  serieA_2020 <- get_match_results(country = "ITA", gender = "M", season_end_year = 2020, tier = "1st")

## ----get_int_match_results, eval=FALSE----------------------------------------
#  # for international friendlies:
#  get_match_results(country = "", gender = "M", season_end_year = 2018, tier = "", non_dom_league_url = "https://fbref.com/en/comps/218/history/Friendlies-M-Seasons")

## ----get_match_results_multiple, eval=FALSE-----------------------------------
#  big_5_2020_results <- get_match_results(country = c("ENG", "ESP", "ITA", "GER", "FRA"),
#                                          gender = "M", season_end_year = 2020, tier = "1st")

## ----get_match_report, eval=FALSE---------------------------------------------
#  # function to extract match report data
#  liv_mci_2020 <- get_match_report(match_url = "https://fbref.com/en/matches/47880eb7/Liverpool-Manchester-City-November-10-2019-Premier-League")

## ----get_match_summary, eval=FALSE--------------------------------------------
#  # function to extract match summary data
#  liv_mci_2020_summary <- get_match_summary(match_url = "https://fbref.com/en/matches/47880eb7/Liverpool-Manchester-City-November-10-2019-Premier-League")

## ----get_match_lineups, eval=FALSE--------------------------------------------
#  # function to extract match lineups
#  liv_mci_2020_lineups <- get_match_lineups(match_url = "https://fbref.com/en/matches/47880eb7/Liverpool-Manchester-City-November-10-2019-Premier-League")

## ----get_shot_and_creation, eval=FALSE----------------------------------------
#  shot_one_match <- get_match_shooting(match_url = "https://fbref.com/en/matches/a3eb7a37/Sheffield-United-Wolverhampton-Wanderers-September-14-2020-Premier-League")
#  
#  test_urls_multiple <- c("https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
#                          "https://fbref.com/en/matches/9cbccb37/Dijon-Angers-August-22-2020-Ligue-1",
#                          "https://fbref.com/en/matches/f96cd5a0/Lorient-Strasbourg-August-23-2020-Ligue-1")
#  shot_multiple_matches <- get_match_shooting(test_urls_multiple)

## ----get_advanced_match_stats, eval=FALSE-------------------------------------
#  test_urls_multiple <- c("https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
#                          "https://fbref.com/en/matches/9cbccb37/Dijon-Angers-August-22-2020-Ligue-1",
#                          "https://fbref.com/en/matches/f96cd5a0/Lorient-Strasbourg-August-23-2020-Ligue-1")
#  
#  advanced_match_stats <- get_advanced_match_stats(match_url = test_urls_multiple, stat_type = "possession", team_or_player = "player")

## ----get_advanced_match_stats_team, eval=FALSE--------------------------------
#  test_urls_multiple <- c("https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
#                          "https://fbref.com/en/matches/9cbccb37/Dijon-Angers-August-22-2020-Ligue-1",
#                          "https://fbref.com/en/matches/f96cd5a0/Lorient-Strasbourg-August-23-2020-Ligue-1")
#  
#  advanced_match_stats_team <- get_advanced_match_stats(match_url = test_urls_multiple, stat_type = "passing_types", team_or_player = "team")

## ----team_match_logs, eval=FALSE----------------------------------------------
#  # for single teams:
#  man_city_2021_url <- "https://fbref.com/en/squads/b8fd03ef/Manchester-City-Stats"
#  man_city_2021_results <- get_team_match_results(man_city_url)
#  # get all team URLs for a league
#  epl_2021_team_urls <- fb_teams_urls("https://fbref.com/en/comps/9/Premier-League-Stats")
#  epl_2021_team_results <- get_team_match_results(team_url = team_urls)

## ----get_player_scouting_report-----------------------------------------------
dplyr::glimpse(fb_player_scouting_report(player_url = "https://fbref.com/en/players/d70ce98e/Lionel-Messi", pos_versus = "primary"))
dplyr::glimpse(fb_player_scouting_report(player_url = "https://fbref.com/en/players/d70ce98e/Lionel-Messi", pos_versus = "secondary"))

## ----player_season_stats, eval=FALSE------------------------------------------
#  mo_shooting <- fb_player_season_stats("https://fbref.com/en/players/e342ad68/Mohamed-Salah", stat_type = 'shooting')
#  
#  multiple_playing_time <- fb_player_season_stats(player_url = c("https://fbref.com/en/players/d70ce98e/Lionel-Messi",
#                                                  "https://fbref.com/en/players/dea698d9/Cristiano-Ronaldo"),
#                                   stat_type = "playing_time")

## ----big5_player, eval=FALSE--------------------------------------------------
#  big5_player_possession <- fb_big5_advanced_season_stats(season_end_year= 2021, stat_type= "possession", team_or_player= "player")

## ----player_match_logs, eval=FALSE--------------------------------------------
#  ederson_summary <- fb_player_match_logs("https://fbref.com/en/players/3bb7b8b4/Ederson", season_end_year = 2021, stat_type = 'summary')

