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
    switch condition {
      case .clear: return "☀️"
      case .mostlyClear: return "🌤️"
      case .partlyCloudy: return "⛅"
      case .mostlyCloudy: return "🌥️"
      case .cloudy, .blizzard: return "☁️"
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
    switch temperature.value {
      case ..<10 : return LinearGradient(colors: [.gray, Color(.systemGray6)], startPoint: .leading, endPoint: .trailing)
      case 10...30 : return LinearGradient(colors: [.blue, .cyan.opacity(0)], startPoint: .leading, endPoint: .trailing)
      case 30...40 : return LinearGradient(colors: [.yellow, .yellow.opacity(1)], startPoint: .leading, endPoint: .trailing)
      case 40... : return LinearGradient(colors: [.red, .red.opacity(0.75)], startPoint: .leading, endPoint: .trailing)
      default: return LinearGradient(colors: [.white, .white], startPoint: .leading, endPoint: .trailing)
    }
  }
  
  func getColorGradientFromTemperatureInVertical() -> LinearGradient {
    switch temperature.value {
      case ..<10 : return LinearGradient(colors: [.gray, Color(.systemGray6)], startPoint: .bottom, endPoint: .top)
      case 10...30 : return LinearGradient(colors: [.blue, .cyan.opacity(0)], startPoint: .bottom, endPoint: .top)
      case 30...40 : return LinearGradient(colors: [.yellow, .yellow.opacity(1)], startPoint: .bottom, endPoint: .top)
      case 40... : return LinearGradient(colors: [.red, .red.opacity(0.75)], startPoint: .bottom, endPoint: .top)
      default: return LinearGradient(colors: [.white, .white], startPoint: .bottom, endPoint: .top)
    }
  }
}
