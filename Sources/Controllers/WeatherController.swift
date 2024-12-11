//
//  WeatherController.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 14/11/2024.
//

import WeatherKit
import CoreLocation

@Observable
final class WeatherController {
  
  @ObservationIgnored private let weatherService = WeatherService()
  
  func fetchWeather(to location: CLLocation) async -> Weather? {
    do {
      return try await self.weatherService.weather(for: location)
    } catch {
      return nil
    }
  }
}
