//
//  HourlyWeather.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 25/11/2024.
//

import Foundation
import WeatherKit

extension HourWeather {
  func getIconFromCondition() -> String {
    switch condition {
      case .clear: return "sun.max.fill"
      case .mostlyClear, .partlyCloudy: return "cloud.sun.fill"
      case .cloudy, .blizzard, .mostlyCloudy: return "cloud.fill"
      case .windy: return "wind"
      case .smoky, .haze: return "smoke.fill"
      case .drizzle: return "cloud.sun.rain.fill"
      case .rain, .heavyRain: return "cloud.heavyrain.fill"
      case .snow, .heavySnow: return "cloud.snow.fill"
      case .freezingDrizzle, .freezingRain: return "snowflake"
      case .tropicalStorm, .hurricane, .thunderstorms: return "tornado"
      case .hot: return "thermometer.high"
      default: return "❓"
    }
  }
  
  func getHourFromForecast() -> Int {
    return Calendar.current.component(.hour, from: self.date)
  }
}