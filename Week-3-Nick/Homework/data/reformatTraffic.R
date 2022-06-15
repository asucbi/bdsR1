library(tidyverse)
library(stringr)
library(lubridate)
library(hms)

us_accidents <- read_csv("US_Accidents_Dec21_updated.csv")

ariz = filter(us_accidents, State == "AZ")
phoenix = filter(us_accidents, State == "AZ" & City == "Phoenix")


phoenix <- phoenix %>% mutate(
  # whether the accident occurred on a highway or street  
  highway = case_when(
    str_detect(phoenix$Street, 'AZ-|US-|Highway|Fwy|I-|Hwy|Loop 101|State Route|Expy|Pkwy|Purple Heart Trail') ~ 'highway',
    TRUE ~ 'Street'
  ),
  # Weather condition at the time of accident:  Fine, Raining, Snowing, Fog or smoke or dust, Other, Unknown
  weather = case_when(
    `Precipitation(in)` > 0 & str_detect(Weather_Condition, 'Rain|Drizzle|Showers|Thunder|T-Storm|Thunderstorm|Squalls|Precipitation|Overcast') ~ 'Raining',
    str_detect(Weather_Condition, 'Snow|Wintry') ~ 'Snowing',
    str_detect(Weather_Condition, 'Fog|Dust|Haze|Smoke') ~ 'Fog or smoke or dust',
    str_detect(Weather_Condition, 'Clear|Cloudy|Clouds|Fair') ~ 'Fair',
    is.na(Weather_Condition) ~ 'Unknown',
    TRUE ~ 'Other'
  ),
  # High winds (greater than 26 mph): Windy or undetermined
  wind = case_when(
    `Wind_Speed(mph)`  >= 26 | str_detect(Weather_Condition, 'Windy') ~ 'Windy',
    is.na(`Wind_Speed(mph)`) ~ 'Unknown',
    TRUE ~ 'Other'
    ),
  # Light condition at the time of accident: Daylight, Darkness - artificial lights lit, Darkness - artificial lights unlit, Undetermined
  light = case_when(
    Sunrise_Sunset == "Day" & Civil_Twilight == "Day" ~ 'Daylight',
    Sunrise_Sunset == "Night" & Civil_Twilight == "Night" ~ 'Darkness_Lights_Lit',
    Sunrise_Sunset == "Night" & Civil_Twilight == "Day" ~ 'Darkness_Lights_Unlit',
    TRUE ~ 'Other',
  ),
  # special condition that was recorded for the accident: Occurred at a traffic light/stopsign, pedestrian crossing, road/highway junction  
  special_cond = case_when(
    Traffic_Signal==TRUE | Stop==TRUE ~ 'Signal_StopSign',
    Crossing==TRUE & Traffic_Signal==FALSE & Stop==FALSE ~ 'Pedestrian_Crossing',
    Crossing==FALSE & Traffic_Signal==FALSE & Stop==FALSE & Junction==TRUE ~ 'RoadHighwayJunction',
    if_all(Amenity:Turning_Loop, ~ . == FALSE) ~ 'Unknown',
    TRUE ~ 'Other',
  ),
  severity = if_else(Severity %in% c(1, 2), 'Minor/Slight', if_else(Severity == 3, 'Moderate', 'Severe')
  )
)

timeinfo <- with_tz(ymd_hms(phoenix$Start_Time),"US/Arizona")
phoenix <- phoenix %>% mutate(
  dateof = date(timeinfo),
  day_of_week = wday(timeinfo, label = TRUE),
  month_of_year = month(timeinfo),
  week_of_year = week(timeinfo),
  time = as_hms(timeinfo)
)

# last thing to do is organize the variables. either drop or rearrange at this point. 

phoenix_new <- phoenix %>% select(ID, Start_Lat, Start_Lng, severity, `Distance(mi)`, dateof, day_of_week, month_of_year, week_of_year, 
                   time, Zipcode, highway, Street, Side, special_cond, light,
                   weather, wind, `Wind_Speed(mph)`, `Precipitation(in)`, `Visibility(mi)`)

# phoenix_new$Severity = recode(phoenix_new$Severity, "1" = "Slight Delay", "2" = "Somewhat Delay", "3" = "Moderate Delay", "4" = "Extreme Delay")

## could have used the janitor package and and the clean_names() 
phoenix_new2 <- phoenix_new %>% rename(wind_speed = `Wind_Speed(mph)`, precipitation = `Precipitation(in)`, visibility = `Visibility(mi)`, road_length = `Distance(mi)`,
                                 id = ID, latitude = Start_Lat, longitude = Start_Lng, zipcode = Zipcode, 
                                 street = Street, side = Side)

write_csv(phoenix_new2, "phoenix_accidents.csv")















# library(dsbox)
# skim(accidents)
# 
# paste(hour(timeinfo[1]),minute(timeinfo)[1], sep=":")
# 
# class(format(timeinfo[1], format = "%H:%M:%S"))
# class(timeinfo[1])
# 
# library(hms)
# as_hms(timeinfo[1])
# 
# class(accidents$time[1])
# 
# timeinfo2 <- with_tz(hms(phoenix$Start_Time),"US/Arizona")
# 
# # Date of the accident
# dateof <- date(timeinfo); dateof
# 
# # Day of the week of the accident
# day_of_week <- wday(timeinfo, label = FALSE); day_of_week
# 
# # Month of the year of the accident 
# month_of_year <- month(timeinfo); month_of_year
# 
# # Week of the year of the accident 
# week_of_year <- week(timeinfo); week_of_year
# 
# # Time of the accident on the 24h clock
# time <- paste(hour(timeinfo),minute(timeinfo), sep=":"); time




# raining <- filter(ariz, `Precipitation(in)` > 0 & str_detect(Weather_Condition, 'Rain|Drizzle|Showers|Thunder|T-Storm|Thunderstorm|Squalls|Precipitation|Overcast'))
# snowing <- ariz %>%
#   filter(str_detect(Weather_Condition, 'Snow|Wintry'))
# fog_smoke_dust <- filter(ariz, str_detect(Weather_Condition, 'Fog|Dust|Haze|Smoke'))
# fine <- filter(ariz, str_detect(Weather_Condition, 'Clear|Cloudy|Clouds|Fair'))
# cannotfind = filter(ariz, is.na(Weather_Condition))
# # other = everything left over

# wind <- filter(ariz, `Wind_Speed(mph)`  >= 26 | str_detect(Weather_Condition, 'Windy'))

# daylight <- filter(ariz, Sunrise_Sunset == "Day" & Civil_Twilight == "Day")
# darkness_lights_on <- filter(ariz, Sunrise_Sunset == "Night" & Civil_Twilight == "Night")
# darkness_lights_off <- filter(ariz, Sunrise_Sunset == "Night" & Civil_Twilight == "Day")

# library(skimr)
# 
# # how many cases have no special conditions (all false)
# ariz %>% filter(if_all(Amenity:Turning_Loop, ~ . == FALSE)) %>% nrow()
# 
# # how many cases have at least one special condition 
# test0 <- ariz %>% filter(if_any(Amenity:Turning_Loop, ~ . == TRUE)); nrow(test0)
# 
# test0 %>% select(Amenity:Turning_Loop) %>% skim()
# # Frequent
# # Traffic_Signal (does this necessarily occur with junction?) *
# # Crossing (involves pedestrians?) * (most of these are traffic signals and stop signs)
# # Stop (is this primarily stop signs?) **
# # Junction (specific to highways?) **
# # Station (this one is weird, what is it?!) **
# 
# # best attempt to break down unique scenarios, accounts for 94% of the data, nothing else is really jumping out as unique within each of these categories
# 
# ## signal or stop sign w/ pedestrian crossing: 
# # filter(test0, Crossing==TRUE & (Traffic_Signal==TRUE | Stop==FALSE)) %>% nrow()/22376*100
# # filter(test0, Crossing==TRUE & (Traffic_Signal==TRUE | Stop==TRUE)) %>% skim()
# # 
# ## signal or stop sign w/no pedestrian crossing
# # filter(test0, Crossing==FALSE & (Traffic_Signal==TRUE | Stop==TRUE)) %>% nrow()/22376*100
# # filter(test0, Crossing==FALSE & (Traffic_Signal==TRUE | Stop==TRUE)) %>% skim()
# 
# # signal/stop sign
# filter(test0, Traffic_Signal==TRUE | Stop==TRUE) %>% nrow()/22376*100
# # filter(test0, Traffic_Signal==TRUE | Stop==TRUE) %>% skim()
# 
# ## absent signal/stop sign, then tends to be a crossing (1772) or a junction (3545)
# # filter(test0, Traffic_Signal==FALSE & Stop==FALSE) %>% nrow()/22376*100
# # filter(test0, Traffic_Signal==FALSE & Stop==FALSE) %>% skim()
# 
# # pedestrian crossing
# filter(test0, Crossing==TRUE & Traffic_Signal==FALSE & Stop==FALSE) %>% nrow()/22376*100
# # filter(test0, Crossing==TRUE & Traffic_Signal==FALSE & Stop==FALSE) %>% skim()
# 
# # road/highway junction
# filter(test0, Crossing==FALSE & Traffic_Signal==FALSE & Stop==FALSE & Junction==TRUE) %>% nrow()/22376*100
# # filter(test0, Crossing==FALSE & Traffic_Signal==FALSE & Stop==FALSE & Junction==TRUE) %>% skim()

# other
# undetermined

# ariz <- ariz %>% mutate(
#   special_condition = case_when(
#     Traffic_Signal==TRUE | Stop==TRUE ~ 'Signal_StopSign',
#     Crossing==TRUE & Traffic_Signal==FALSE & Stop==FALSE ~ 'Pedestrian_Crossing',
#     Crossing==FALSE & Traffic_Signal==FALSE & Stop==FALSE & Junction==TRUE ~ 'RoadHighwayJunction',
#     if_all(Amenity:Turning_Loop, ~ . == FALSE) ~ 'Undetermined',
#     TRUE ~ 'Other'
#   )
# )


