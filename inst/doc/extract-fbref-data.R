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

## ----get_season_team_stats----------------------------------------------------
#----- function to extract season teams stats -----#
prem_2020_shooting <- get_season_team_stats(country = "ENG", gender = "M", season_end_year = "2020", tier = "1st", stat_type = "shooting")
dplyr::glimpse(prem_2020_shooting)

#----- to get shooting stats for the English Championship: -----#
# championship_2020_shooting <- get_season_team_stats(country = "ENG", gender = "M", season_end_year = "2020", tier = "2nd", stat_type = "shooting")

#----- Can also run this for multiple leagues at a time: -----#
# multiple_2020_shooting <- get_season_team_stats(country = c("USA", "NED"),
#                                                 gender = "M", season_end_year = 2020, 
#                                                 tier = "1st", stat_type = "shooting")

## ----big5_team----------------------------------------------------------------
#----- Get data for big five leagues for TEAMS -----#
big5_team_shooting <- fb_big5_advanced_season_stats(season_end_year= c(2019:2021), stat_type= "shooting", team_or_player= "team")
dplyr::glimpse(big5_team_shooting)

#----- Get data for big five leagues for PLAYERS -----#
big5_player_shooting <- fb_big5_advanced_season_stats(season_end_year= c(2019:2021), stat_type= "shooting", team_or_player= "team")
dplyr::glimpse(big5_player_shooting)

## ----get_match_results--------------------------------------------------------
# function to extract Serie A match results data
serieA_2020 <- get_match_results(country = "ITA", gender = "M", season_end_year = 2020, tier = "1st")
dplyr::glimpse(serieA_2020)

## ----get_int_match_results, eval=FALSE----------------------------------------
#  # for international friendlies:
#  get_match_results(country = "", gender = "M", season_end_year = 2018, tier = "", non_dom_league_url = "https://fbref.com/en/comps/218/history/Friendlies-M-Seasons")

## ----get_match_results_multiple, eval=FALSE-----------------------------------
#  big_5_2020_results <- get_match_results(country = c("ENG", "ESP", "ITA", "GER", "FRA"),
#                                          gender = "M", season_end_year = 2020, tier = "1st")

## ----get_match_report---------------------------------------------------------
# function to extract match report data
liv_mci_2020 <- get_match_report(match_url = "https://fbref.com/en/matches/47880eb7/Liverpool-Manchester-City-November-10-2019-Premier-League")
dplyr::glimpse(liv_mci_2020)

## ----get_match_summary--------------------------------------------------------
# function to extract match summary data
liv_mci_2020_summary <- get_match_summary(match_url = "https://fbref.com/en/matches/47880eb7/Liverpool-Manchester-City-November-10-2019-Premier-League")
dplyr::glimpse(liv_mci_2020_summary)

## ----get_match_lineups--------------------------------------------------------
# function to extract match lineups
liv_mci_2020_lineups <- get_match_lineups(match_url = "https://fbref.com/en/matches/47880eb7/Liverpool-Manchester-City-November-10-2019-Premier-League")
dplyr::glimpse(liv_mci_2020_lineups)

## ----get_shot_and_creation----------------------------------------------------
#----- Get shots data for a single match played: -----#
shot_one_match <- get_match_shooting(match_url = "https://fbref.com/en/matches/a3eb7a37/Sheffield-United-Wolverhampton-Wanderers-September-14-2020-Premier-League")

#----- Can also extract for multiple matches at a time: -----#
# test_urls_multiple <- c("https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
#                         "https://fbref.com/en/matches/9cbccb37/Dijon-Angers-August-22-2020-Ligue-1",
#                         "https://fbref.com/en/matches/f96cd5a0/Lorient-Strasbourg-August-23-2020-Ligue-1")
# shot_multiple_matches <- get_match_shooting(test_urls_multiple)

## ----get_advanced_match_stats-------------------------------------------------
test_urls_multiple <- c("https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
                        "https://fbref.com/en/matches/9cbccb37/Dijon-Angers-August-22-2020-Ligue-1")

advanced_match_stats <- get_advanced_match_stats(match_url = test_urls_multiple, stat_type = "possession", team_or_player = "player")
dplyr::glimpse(advanced_match_stats)

## ----get_advanced_match_stats_team--------------------------------------------
test_urls_multiple <- c("https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
                        "https://fbref.com/en/matches/9cbccb37/Dijon-Angers-August-22-2020-Ligue-1")

advanced_match_stats_team <- get_advanced_match_stats(match_url = test_urls_multiple, stat_type = "passing_types", team_or_player = "team")
dplyr::glimpse(advanced_match_stats_team)

## ----team_match_logs----------------------------------------------------------
#----- for single teams: -----#
man_city_2021_url <- "https://fbref.com/en/squads/b8fd03ef/Manchester-City-Stats"
man_city_2021_results <- get_team_match_results(man_city_2021_url)
dplyr::glimpse(man_city_2021_results)

#----- get all team URLs for a league: -----#
# epl_2021_team_urls <- fb_teams_urls("https://fbref.com/en/comps/9/Premier-League-Stats")
# epl_2021_team_results <- get_team_match_results(team_url = team_urls)

## ----team_stat_match_logs, eval=FALSE-----------------------------------------
#  # can do it for one team:
#  man_city_url <- "https://fbref.com/en/squads/b8fd03ef/Manchester-City-Stats"
#  man_city_logs <- fb_team_match_log_stats(team_urls = man_city_url, stat_tyoe = "passing")
#  
#  dplyr::glimpse(man_city_logs)
#  
#  # or multiple teams:
#  urls <- c("https://fbref.com/en/squads/822bd0ba/Liverpool-Stats",
#            "https://fbref.com/en/squads/b8fd03ef/Manchester-City-Stats")
#  
#  shooting_logs <- fb_team_match_log_stats(team_urls = urls, stat_type = "shooting")

## ----get_player_scouting_report-----------------------------------------------
#----- Get scouting report for the players primary position (first position listed in fbref): -----#
messi_primary <- fb_player_scouting_report(player_url = "https://fbref.com/en/players/d70ce98e/Lionel-Messi", pos_versus = "primary")
dplyr::glimpse(messi_primary)

#----- Get scouting report for the players secondary position (second position listed in fbref): -----#
messi_secondary <- fb_player_scouting_report(player_url = "https://fbref.com/en/players/d70ce98e/Lionel-Messi", pos_versus = "secondary")
dplyr::glimpse(messi_secondary)

## ----player_season_stats------------------------------------------------------
#----- can use for a single player: -----#
mo_shooting <- fb_player_season_stats("https://fbref.com/en/players/e342ad68/Mohamed-Salah", stat_type = 'shooting')
dplyr::glimpse(mo_shooting)

#----- Or for multiple players at a time: -----#
# multiple_playing_time <- fb_player_season_stats(player_url = c("https://fbref.com/en/players/d70ce98e/Lionel-Messi",
#                                                 "https://fbref.com/en/players/dea698d9/Cristiano-Ronaldo"),
#                                  stat_type = "playing_time")

## ----big5_player--------------------------------------------------------------
big5_player_possession <- fb_big5_advanced_season_stats(season_end_year= 2021, stat_type= "possession", team_or_player= "player")
dplyr::glimpse(big5_player_possession)

## ----team_player_season_stats-------------------------------------------------
#----- to get stats for just a single team: -----#
fleetwood_standard_stats <- fb_team_player_stats(team_urls= "https://fbref.com/en/squads/d6a369a2/Fleetwood-Town-Stats", stat_type= 'standard')
dplyr::glimpse(fleetwood_standard_stats)

#----- Can even get stats for a series of teams: -----#
# league_url <- fb_league_urls(country = "ENG", gender = "M",
# teams <- fb_teams_urls(league_url)
# 
# multiple_playing_time <- fb_team_player_stats(team_urls= teams, stat_type= "playing_time")

## ----player_match_logs--------------------------------------------------------
ederson_summary <- fb_player_match_logs("https://fbref.com/en/players/3bb7b8b4/Ederson", season_end_year = 2021, stat_type = 'summary')
dplyr::glimpse(ederson_summary)

