//
//  Forecast.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 22/11/2024.
//

import Foundation
import WeatherKit

extension DayWeather {
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
  
  func getDayFromForecast() -> Int {
    return Calendar.current.component(.day, from: self.date)
  }
}
