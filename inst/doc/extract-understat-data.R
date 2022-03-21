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

## ----team_urls, eval=FALSE----------------------------------------------------
#  team_urls <- understat_team_meta(team_name = c("Liverpool", "Manchester City"))

## ----understat_match_results--------------------------------------------------
# to get the EPL results:
epl_results <- understat_league_match_results(league = "EPL", season_start_year = 2020)
dplyr::glimpse(epl_results)

## ----season_shots, eval=FALSE-------------------------------------------------
#  ligue1_shot_location <- understat_league_season_shots(league = "Ligue 1", season_start_year = 2020)

## ----match_shots--------------------------------------------------------------
wba_liv_shots <- understat_match_shots(match_url = "https://understat.com/match/14789")
dplyr::glimpse(wba_liv_shots)

## ----team_shots---------------------------------------------------------------
# for one team:
man_city_shots <- understat_team_season_shots(team_url = "https://understat.com/team/Manchester_City/2020")
dplyr::glimpse(man_city_shots)

## ----team_breakdown-----------------------------------------------------------
#----- Can get data for single teams at a time: -----#
team_breakdown <- understat_team_stats_breakdown(team_urls = "https://understat.com/team/Liverpool/2020")
dplyr::glimpse(team_breakdown)

#----- Or for multiple teams: -----#
# team_urls <- c("https://understat.com/team/Liverpool/2020",
#                "https://understat.com/team/Manchester_City/2020")
# team_breakdown <- understat_team_stats_breakdown(team_urls = team_urls)

## ----player_shots-------------------------------------------------------------
raheem_sterling_shots <- understat_player_shots(player_url = "https://understat.com/player/618")
dplyr::glimpse(raheem_sterling_shots)

## ----team_players-------------------------------------------------------------
team_players <- understat_team_players_stats(team_url = c("https://understat.com/team/Liverpool/2020", "https://understat.com/team/Manchester_City/2020"))
dplyr::glimpse(team_players)

