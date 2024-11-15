//
//  WeatherLocation.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 14/11/2024.
//

import SwiftUI
import WeatherKit

struct WeatherLocation: View {
  
  let weather: Weather?
  
    var body: some View {
      if weather != nil {
        VStack{
          Text("Soual")
            .font(.largeTitle)
            .bold()
          Text("\(self.weather!.currentWeather.getIconFromCondition())")
            .font(.system(size: 125))
            .shadow(color: .black.opacity(0.5), radius: 50)
          Text("\(String(format: "%.0f", self.weather!.currentWeather.apparentTemperature.value))°")
            .font(.title)
            .bold()
          Text(self.weather!.currentWeather.condition.description)
            .font(.title)
        }
        .frame(width: 375)
      } else {
        
      }
    }
}

//#Preview {
//    WeatherLocation()
//}
