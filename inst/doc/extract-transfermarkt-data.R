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

## ----tm_team_urls, eval=FALSE-------------------------------------------------
#  team_urls <- tm_league_team_urls(country_name = "England", start_year = 2020)
#  # if it's not a league in the stored leagues data in worldfootballR_data repo:
#  league_one_teams <- tm_league_team_urls(start_year = 2020, league_url = "https://www.transfermarkt.com/league-one/startseite/wettbewerb/GB3")

## ----tm_player_urls, eval=FALSE-----------------------------------------------
#  tm_team_player_urls(team_url = "https://www.transfermarkt.com/fc-burnley/startseite/verein/1132/saison_id/2020")

## ----matchday_league_table, eval=FALSE----------------------------------------
#  # to get the EPL table after matchday 1 of the 20/21 season:
#  epl_matchday_1_table <- tm_matchday_table(country_name="England", start_year="2020", matchday=1)
#  
#  # to get the EPL table after each matchdays from matchday 1 to matchday 35 of the 20/21 season:
#  epl_matchday_1to35_table <- tm_matchday_table(country_name="England", start_year="2020", matchday=c(1:35))
#  
#  # to get the EPL table after each matchdays from matchday 1 to matchday 35 of the 20/21 season:
#  league_one_matchday_1_table <- tm_matchday_table(start_year="2020", matchday=1, league_url="https://www.transfermarkt.com/league-one/startseite/wettbewerb/GB3")

## ----team_transfers, eval=FALSE-----------------------------------------------
#  # for one team:
#  bayern <- tm_team_transfers(team_url = "https://www.transfermarkt.com/fc-bayern-munchen/startseite/verein/27/saison_id/2020", transfer_window = "all")
#  
#  # or for multiple teams:
#  team_urls <- tm_league_team_urls(country_name = "England", start_year = 2020)
#  epl_xfers_2020 <- tm_team_transfers(team_url = team_urls, transfer_window = "all")

## ----squad_stats, eval=FALSE--------------------------------------------------
#  # for one team:
#  bayern <- tm_squad_stats(team_url = "https://www.transfermarkt.com/fc-bayern-munchen/startseite/verein/27/saison_id/2020")
#  
#  # or for multiple teams:
#  team_urls <- tm_league_team_urls(country_name = "England", start_year = 2020)
#  epl_team_players_2020 <- tm_squad_stats(team_url = team_urls)

## ---- player_vals, eval=FALSE-------------------------------------------------
#  big_5_valuations <- get_player_market_values(country_name = c("England", "Spain", "France", "Italy", "Germany"),
#                                         start_year = 2021)

## ----player_bios, eval=FALSE--------------------------------------------------
#  # for a single player
#  hazard_bio <- tm_player_bio(player_url = "https://www.transfermarkt.com/eden-hazard/profil/spieler/50202")
#  
#  # for multiple players:
#  # can make use of a tm helper function:
#  burnley_player_urls <- tm_team_player_urls(team_url = "https://www.transfermarkt.com/fc-burnley/startseite/verein/1132/saison_id/2020")
#  # then pass all those URLs to the tm_player_bio
#  burnley_bios <- tm_player_bio(player_urls = burnley_player_urls)

