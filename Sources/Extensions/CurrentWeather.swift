  //
  //  CurrentWeather.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 14/11/2024.
  //

import Foundation
import WeatherKit
import SwiftUI

extension CurrentWeather {
  func getIconFromCondition() -> String {
    switch self.condition {
      case .clear: return "☀️"
      case .mostlyClear: return "🌤️"
      case .partlyCloudy: return "⛅"
      case .cloudy, .blizzard, .mostlyCloudy: return "☁️"
      case .windy: return "💨"
      case .smoky, .haze: return "🌫️"
      case .drizzle: return "🌦️"
      case .rain, .heavyRain: return "🌧️"
      case .snow, .heavySnow: return "🌨️"
      case .freezingDrizzle, .freezingRain: return "❄️"
      case .tropicalStorm, .hurricane: return "🌪️"
      case .hot: return "🔥"
      default: return "❓"
    }
  }
  
  func getColorGradientFromTemperatureInHorizontal() -> LinearGradient {
    switch self.temperature.value {
      case ..<10 : return LinearGradient(colors: [.gray, .white], startPoint: .leading, endPoint: .trailing)
      case 10...30 : return LinearGradient(colors: [.blue, .white], startPoint: .leading, endPoint: .trailing)
      case 30...40 : return LinearGradient(colors: [.yellow, .white], startPoint: .leading, endPoint: .trailing)
      case 40... : return LinearGradient(colors: [.red, .white], startPoint: .leading, endPoint: .trailing)
      default: return LinearGradient(colors: [.white, .white], startPoint: .leading, endPoint: .trailing)
    }
  }
  
  func getColorGradientFromTemperatureInVertical() -> LinearGradient {
    switch self.temperature.value {
      case ..<10 : return LinearGradient(colors: [.gray, .white], startPoint: .bottom, endPoint: .top)
      case 10...30 : return LinearGradient(colors: [.blue, .white], startPoint: .bottom, endPoint: .top)
      case 30...40 : return LinearGradient(colors: [.yellow, .white], startPoint: .bottom, endPoint: .top)
      case 40... : return LinearGradient(colors: [.red, .white], startPoint: .bottom, endPoint: .top)
      default: return LinearGradient(colors: [.white, .white], startPoint: .bottom, endPoint: .top)
    }
  }
  
  func getFontColorFromTemperature() -> Color {
    switch self.temperature.value {
      case ..<10 : return .gray
      case 10...30 : return .blue
      case 30...40 : return .yellow
      case 40... : return .red
      default: return .black
    }
  }
  
  func getRoundedApparentTemperature() -> String {
    return String(format: "%.0f", self.apparentTemperature.value)
  }
  
  func getRoundedHumidityRate() -> String {
    return String(format: "%.0f", self.humidity)
  }
}
