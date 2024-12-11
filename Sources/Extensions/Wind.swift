//
//  Wind.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 04/12/2024.
//

import WeatherKit

extension Wind {
  func getRoundedSpeed() -> String {
    return String(format: "%.0f", self.speed.value)
  }
  
  func getRoundedDegree() -> String {
    return String(format: "%.0f", self.direction.value)
  }
}
