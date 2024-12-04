//
//  HourlyWeather.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 25/11/2024.
//

import Foundation
import WeatherKit

extension HourWeather {
  func getHourFromForecast() -> Int {
    return Calendar.current.component(.hour, from: self.date)
  }
  
  func getRoundedApparentTemperature() -> String {
    return String(format: "%.0f", self.apparentTemperature.value)
  }
}
