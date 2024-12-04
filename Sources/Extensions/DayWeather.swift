//
//  Forecast.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 22/11/2024.
//

import Foundation
import WeatherKit

extension DayWeather {
  func getDayFromForecast() -> Int {
    return Calendar.current.component(.day, from: self.date)
  }
  
  func getRoundedLowTemperature() -> String {
    return "\(String(format: "%.0f", self.lowTemperature.value))°"
  }
  
  func getRoundedHighTemperature() -> String {
    return "\(String(format: "%.0f", self.highTemperature.value))°"
  }
}
