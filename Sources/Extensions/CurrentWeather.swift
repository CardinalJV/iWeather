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
      case .blowingDust: return "⛈️"
      case .clear, .smoky: return "☀️"
      case .cloudy, .foggy, .haze: return "☁️"
      case .mostlyClear: return "🌤️"
      case .mostlyCloudy: return "⛅️"
      case .partlyCloudy: return "🌥️"
      default: return "?"
    }
  }
  
  func getColorGradientFromTemperature() -> LinearGradient {
    switch temperature.value {
      case ..<20 : return LinearGradient(colors: [.gray, Color(.systemGray6)], startPoint: .leading, endPoint: .trailing)
      case 20...30 : return LinearGradient(colors: [.blue, .cyan.opacity(0)], startPoint: .leading, endPoint: .trailing)
      case 30...40 : return LinearGradient(colors: [.yellow, .yellow.opacity(1)], startPoint: .leading, endPoint: .trailing)
      case 40... : return LinearGradient(colors: [.red, .red.opacity(0.75)], startPoint: .leading, endPoint: .trailing)
      default: return LinearGradient(colors: [.white, .white], startPoint: .leading, endPoint: .trailing)
    }
  }
}
