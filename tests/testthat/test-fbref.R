#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
 #======================================= IMPORTANT: ======================================#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# as at 2022-07-08:
#
# As much as it pains me to do, I will need to suspend tests of FBref
# scraping functions as these tests are consistently throwing 403 errors
# and I have no idea why - rate limiting has been applied in all functions
# and I've gone over and above on pauses in page loads, to no avail.
#
# for anyone contributing, please ensure you're running each FBref scraping function
# locally (for some reason this doesn't throw a 403, only tests / devtools:check())
# and able to get the data as expected when running the function manually and locally.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#~

context("Testing FBref functions")


test_that("player_dictionary_mapping() works", {
  testthat::skip_on_cran()
  mapped_players <- player_dictionary_mapping()
  expect_type(mapped_players, "list")
  expect_equal(ncol(mapped_players), 4)
})

test_that("fb_league_urls() works", {
  testthat::skip_on_cran()
  league_urls <- fb_league_urls(country = "ENG", gender = "M", season_end_year = 2021, tier = '2nd')
  expect_type(league_urls, "character")
  # test that there is more than just the baseline URL
  expect_false(grepl("https://fbref.com/en/$", league_urls[1]))
})

Sys.sleep(3)
test_that("fb_team_urls() works", {
  testthat::skip_on_cran()
  team_urls <- fb_teams_urls("https://fbref.com/en/comps/9/Premier-League-Stats")
  expect_type(team_urls, "character")
  # test that there is more than just the baseline URL
  expect_false(grepl("https://fbref.com/en/$", team_urls[1]))
})

Sys.sleep(3)
test_that("fb_player_urls() works", {
  testthat::skip_on_cran()
  player_urls <- fb_player_urls("https://fbref.com/en/squads/fd962109/Fulham-Stats")
  expect_type(player_urls, "character")
  # test that there is more than just the baseline URL
  expect_false(grepl("https://fbref.com/en/$", player_urls[1]))
})

Sys.sleep(3)
test_that("fb_advanced_match_stats() works", {
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  # # test the functions returns the data for each stat_type
  # expect_type(fb_advanced_match_stats(match_url = "https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
  #                                      stat_type = "summary", team_or_player = "team", time_pause = 4), "list")
  # expect_type(fb_advanced_match_stats(match_url = "https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
  #                                      stat_type = "passing", team_or_player = "team", time_pause = 4), "list")
  # expect_type(fb_advanced_match_stats(match_url = "https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
  #                                      stat_type = "passing_types", team_or_player = "team", time_pause = 4), "list")
  # expect_type(fb_advanced_match_stats(match_url = "https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
  #                                      stat_type = "defense", team_or_player = "team", time_pause = 4), "list")
  # expect_type(fb_advanced_match_stats(match_url = "https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
  #                                      stat_type = "possession", team_or_player = "team", time_pause = 4), "list")
  # expect_type(fb_advanced_match_stats(match_url = "https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
  #                                      stat_type = "misc", team_or_player = "team", time_pause = 4), "list")
  # expect_type(fb_advanced_match_stats(match_url = "https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
  #                                      stat_type = "keeper", team_or_player = "team", time_pause = 4), "list")
  # expect_type(fb_advanced_match_stats(match_url = "https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
  #                                      stat_type = "keeper", team_or_player = "player", time_pause = 4), "list")

  # test that multiple match_url can be passed to the function
  test_urls <- c("https://fbref.com/en/matches/e0a84e7e/Southampton-Manchester-United-November-29-2020-Premier-League",
                 "https://fbref.com/en/matches/703db983/Paris-Saint-Germain-Toulouse-August-25-2019-Ligue-1")
  test_df <- fb_advanced_match_stats(match_url = test_urls, stat_type = "possession", team_or_player = "team", time_pause = 4)
  expect_type(test_df, "list")
  expect_equal(nrow(test_df), 4)

  # test that incorrect URL will error
  # expect_error(fb_advanced_match_stats(match_url = "aaa.aaa"))

  # test that an invalid stat_type will error
  expect_error(fb_advanced_match_stats(match_url = "https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
                                        stat_type = "test", team_or_player = "team", time_pause = 4))

})


Sys.sleep(3)
test_that("fb_match_lineups() works", {
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  test_df <- fb_match_lineups(match_url = "https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1")
  # test the functions returns the data
  expect_type(test_df, "list")
  # test that the correct number of columns returned
  expect_equal(ncol(test_df), 17)
  # # test that incorrect URL will return empty data frame
  # error_lineups <- fb_match_lineups("aaa.aaa")
  # expect_equal(nrow(error_lineups), 0)


})

Sys.sleep(3)
test_that("fb_match_report() works", {
  testthat::skip_on_cran()
  testthat::skip_if_offline()

  # test that multiple match_url can be passed to the function
  test_urls <- c("https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
                 "https://fbref.com/en/matches/9cbccb37/Dijon-Angers-August-22-2020-Ligue-1")
  test_df <- fb_match_report(match_url = test_urls, time_pause = 4)
  expect_type(test_df, "list")

  # test that the correct number of columns returned
  expect_equal(ncol(test_df), 18)

  # # test that incorrect URL will error
  # expect_error(fb_match_report("aaa.aaa"))


})

Sys.sleep(3)
test_that("fb_match_results() works", {
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  # test that multiple countries can be passed to the function
  test_df <- fb_match_results(country = c("ENG", "AUS"), gender = "F", season_end_year = 2021, tier="1st")
  expect_type(test_df, "list")

  # # test that incorrect Country will error
  # expect_error(fb_match_results(country = "BBB", gender = "F", season_end_year = 2021))

})

Sys.sleep(3)
test_that("fb_match_summary() works", {
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  # test that multiple match_url can be passed to the function
  test_urls <- c("https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
                 "https://fbref.com/en/matches/9cbccb37/Dijon-Angers-August-22-2020-Ligue-1")
  test_df <- fb_match_summary(match_url = test_urls, time_pause = 4)
  expect_type(test_df, "list")

  # # test that incorrect url will error
  # expect_error(fb_match_summary(match_url = "aaa.aaa"))

})


Sys.sleep(3)
test_that("fb_match_url() works", {
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  test_urls <- fb_match_urls(country = "AUS", gender = "F", season_end_year = 2020, tier="1st", time_pause = 4)
  # test the functions returns the data
  expect_type(test_urls, "character")
  # also test if it's a correct url:
  expect_equal(grepl("https://", test_urls[1]), TRUE)

  # # test that incorrect url will error
  # expect_equal(length(fb_match_urls(country = "BBB", gender = "M", season_end_year = 2021, tier="1st", time_pause = 4)), 0)

  # friendly_int_2021_urls <- fb_match_urls(country = "", gender = "M", season_end_year = 2021, tier = "", non_dom_league_url = "https://fbref.com/en/comps/218/history/Friendlies-M-Seasons")
  # expect_type(friendly_int_2021_urls, "character")

})



Sys.sleep(3)
test_that("fb_season_team_stats() works", {
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  # test the functions returns the data
  # expect_type(fb_season_team_stats(country = "AUS", gender = "F", season_end_year = 2021, tier="1st", stat_type = "league_table_home_away", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "AUS", gender = "F", season_end_year = 2021, tier="1st", stat_type = "standard", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "ENG", gender = "M", season_end_year = 2021, tier="1st", stat_type = "keeper", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "ENG", gender = "M", season_end_year = 2021, tier="1st", stat_type = "keeper_adv", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "ENG", gender = "M", season_end_year = 2021, tier="1st", stat_type = "shooting", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "ENG", gender = "M", season_end_year = 2021, tier="1st", stat_type = "passing", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "ENG", gender = "M", season_end_year = 2021, tier="1st", stat_type = "passing_types", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "ENG", gender = "M", season_end_year = 2021, tier="1st", stat_type = "goal_shot_creation", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "ENG", gender = "M", season_end_year = 2021, tier="1st", stat_type = "defense", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "ENG", gender = "M", season_end_year = 2021, tier="1st", stat_type = "possession", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "ENG", gender = "M", season_end_year = 2021, tier="1st", stat_type = "playing_time", time_pause = 4), "list")
  # expect_type(fb_season_team_stats(country = "ENG", gender = "M", season_end_year = 2021, tier="1st", stat_type = "misc", time_pause = 4), "list")

  # test that multiple genders can be passed to the function
  expect_type(fb_season_team_stats(country = "AUS", gender = c("M", "F"), season_end_year = 2021, tier="1st", stat_type = "league_table", time_pause = 4), "list")

  # test that incorrect URL will error
  # expect_equal(length(fb_season_team_stats(country = "AUS", gender = "F", season_end_year = 2021, tier="1st", stat_type = "possession", time_pause = 4)), 0)
  #
  # # test that an invalid stat_type will error
  # expect_error(fb_season_team_stats(country = "AUS", gender = "F", season_end_year = 2021, tier="1st", stat_type = "test", time_pause = 4))

  # test that MLS league table returns a new column for conference
  mls_table <- fb_season_team_stats(country = "USA", gender = "M", season_end_year = 2021, tier="1st", stat_type = "league_table", time_pause = 4)
  expect_type(mls_table, "list")
  expect_true(any(grepl("Conference", names(mls_table))))

})


Sys.sleep(3)
test_that("fb_big5_advanced_season_stats() works", {
  testthat::skip_on_cran()
  big5_team_shooting_multiple <- fb_big5_advanced_season_stats(season_end_year= c(2022:2023), stat_type= "shooting", team_or_player= "team", time_pause = 4)
  expect_type(big5_team_shooting_multiple, "list")
  expect_false(nrow(big5_team_shooting_multiple) == 0)

  # big5_player_shooting <- fb_big5_advanced_season_stats(season_end_year= c(2022), stat_type= "shooting", team_or_player= "player", time_pause = 4)
  # expect_type(big5_player_shooting, "list")
  # expect_false(nrow(big5_player_shooting) == 0)
})


Sys.sleep(3)
test_that("fb_match_shooting() works", {
  testthat::skip_on_cran()
  test_urls_multiple <- c("https://fbref.com/en/matches/c0996cac/Bordeaux-Nantes-August-21-2020-Ligue-1",
                          "https://fbref.com/en/matches/9cbccb37/Dijon-Angers-August-22-2020-Ligue-1")
  shot_multiple_matches <- fb_match_shooting(test_urls_multiple, time_pause = 4)
  expect_type(shot_multiple_matches, "list")
  expect_false(nrow(shot_multiple_matches) == 0)
})


Sys.sleep(3)
test_that("fb_team_match_results() works", {
  testthat::skip_on_cran()
  # get all team URLs for a league
  epl_2021_team_urls <- fb_teams_urls("https://fbref.com/en/comps/9/Premier-League-Stats", time_pause = 4)
  epl_2021_team_results <- fb_team_match_results(team_url = epl_2021_team_urls[1:3], time_pause = 4)
  expect_type(epl_2021_team_results, "list")
  expect_false(nrow(epl_2021_team_results) == 0)
})


# Sys.sleep(3)
# test_that("fb_player_scouting_report() works", {
#   testthat::skip_on_cran()
#   # scout <- fb_player_scouting_report(player_url = "https://fbref.com/en/players/d70ce98e/Lionel-Messi",
#   #                                    pos_versus = "primary", time_pause = 4)
#   # expect_type(scout, "list")
#   # expect_false(nrow(scout) == 0)
#
#   scout_secondary <- fb_player_scouting_report(player_url = "https://fbref.com/en/players/d70ce98e/Lionel-Messi",
#                                      pos_versus = "secondary", time_pause = 4)
#   expect_type(scout, "list")
#   expect_false(nrow(scout) == 0)
# })


Sys.sleep(3)
test_that("fb_player_season_stats() works", {
  testthat::skip_on_cran()
  multiple_playing_time <- fb_player_season_stats(player_url = c("https://fbref.com/en/players/d70ce98e/Lionel-Messi",
                                                                 "https://fbref.com/en/players/dea698d9/Cristiano-Ronaldo"),
                                                  stat_type = "playing_time", time_pause = 4)
  expect_type(multiple_playing_time, "list")
  expect_false(nrow(multiple_playing_time) == 0)
})


Sys.sleep(3)
test_that("fb_player_match_logs() works", {
  testthat::skip_on_cran()
  ederson_summary <- fb_player_match_logs("https://fbref.com/en/players/3bb7b8b4/Ederson", season_end_year = 2021, stat_type = 'summary', time_pause = 4)
  expect_type(ederson_summary, "list")
  expect_false(nrow(ederson_summary) == 0)
})


Sys.sleep(3)
test_that("fb_team_player_stats() works", {
  testthat::skip_on_cran()
  fleetwood_standard_stats <- fb_team_player_stats(team_urls= "https://fbref.com/en/squads/d6a369a2/Fleetwood-Town-Stats", stat_type= 'standard', time_pause = 4)
  expect_type(fleetwood_standard_stats, "list")
  expect_false(nrow(fleetwood_standard_stats) == 0)

  # this should error because the stat type isn't available
  expect_error(fb_team_player_stats(team_urls= "https://fbref.com/en/squads/d6a369a2/Fleetwood-Town-Stats", stat_type= 'keeper_adv', time_pause = 4))
  # # this should error because the spelling of the stat type is incorrect
  # expect_error(fb_team_player_stats(team_urls= "https://fbref.com/en/squads/d6a369a2/Fleetwood-Town-Stats", stat_type= 'stangard', time_pause = 4))

})


Sys.sleep(3)
test_that("fb_team_match_log_stats() works", {
  testthat::skip_on_cran()
  liv_keeper_log <- fb_team_match_log_stats(team_url= "https://fbref.com/en/squads/822bd0ba/Liverpool-Stats", stat_type= 'keeper', time_pause = 4)
  expect_type(liv_keeper_log, "list")
  expect_false(nrow(liv_keeper_log) == 0)

  # this should error because the stat type isn't available
  expect_error(fb_team_match_log_stats(team_url = "https://fbref.com/en/squads/d6a369a2/Fleetwood-Town-Stats", stat_type= 'keeper_adv', time_pause = 4))
  # # this should error because the spelling of the stat type is incorrect
  # expect_error(fb_team_player_stats(team_urls= "https://fbref.com/en/squads/d6a369a2/Fleetwood-Town-Stats", stat_type= 'shooooooting', time_pause = 4))

})



Sys.sleep(3)
test_that("fb_squad_wages() works", {
  testthat::skip_on_cran()
  liv_wages <- fb_squad_wages(team_url= "https://fbref.com/en/squads/822bd0ba/Liverpool-Stats", time_pause = 4)
  expect_type(liv_wages, "list")
  expect_false(nrow(liv_wages) == 0)
})

Sys.sleep(3)
test_that("fb_team_goal_logs() works", {
  testthat::skip_on_cran()
  mc_goal_log <- fb_team_goal_logs(team_url = "https://fbref.com/en/squads/b8fd03ef/2021-2022/Manchester-City-Stats", time_pause = 4, for_or_against = "for")
  granada_goal_log <- fb_team_goal_logs(team_url = "https://fbref.com/en/squads/a0435291/2022-2023/Granada-Stats", time_pause = 4, for_or_against = "for")
  expect_type(mc_goal_log, "list")
  expect_type(granada_goal_log, "list")
  expect_false(nrow(mc_goal_log) == 0)
  expect_false(nrow(granada_goal_log) == 0)
})

Sys.sleep(3)
test_that("fb_player_goal_logs() works", {
  testthat::skip_on_cran()
  jwp_goal_log <- fb_player_goal_logs(player_url = "https://fbref.com/en/players/3515d404/James-Ward-Prowse", time_pause = 4, goals_or_assists = "goals")
  gnahoua_goal_log <- fb_player_goal_logs(player_urls = "https://fbref.com/en/players/7440346f/Arthur-Gnahoua", time_pause = 4, goals_or_assists = "both") # works
  expect_type(jwp_goal_log, "list")
  expect_type(gnahoua_goal_log, "list")
  expect_false(nrow(jwp_goal_log) == 0)
  expect_false(nrow(gnahoua_goal_log) == 0)
})
