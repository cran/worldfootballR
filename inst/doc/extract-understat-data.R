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

## ----team_urls, eval=FALSE----------------------------------------------------
#  team_urls <- understat_team_meta(team_name = c("Liverpool", "Manchester City"))

## ----understat_match_results, eval=FALSE--------------------------------------
#  # to get the EPL results:
#  epl_results <- understat_league_match_results(league = "EPL", season_start_year = 2020)

## ----season_shots, eval=FALSE-------------------------------------------------
#  ligue1_shot_location <- understat_league_season_shots(league = "Ligue 1", season_start_year = 2020)

## ----match_shots, eval=FALSE--------------------------------------------------
#  wba_liv_shots <- understat_match_shots(match_url = "https://understat.com/match/14789")

## ----team_shots, eval=FALSE---------------------------------------------------
#  # for one team:
#  man_city_shots <- understat_team_season_shots(team_url = "https://understat.com/team/Manchester_City/2020")

## ----team_breakdown, eval=FALSE-----------------------------------------------
#  team_urls <- c("https://understat.com/team/Liverpool/2020",
#                 "https://understat.com/team/Manchester_City/2020")
#  team_breakdown <- understat_team_stats_breakdown(urls = team_urls)

## ----player_bios, eval=FALSE--------------------------------------------------
#  raheem_sterling_shots <- understat_player_shots(player_url = "https://understat.com/player/618")

## ----team_players, eval=FALSE-------------------------------------------------
#  team_players <- understat_team_players_stats(team_url = c("https://understat.com/team/Liverpool/2020", "https://understat.com/team/Manchester_City/2020"))

