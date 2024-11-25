//
//  WeatherForecast.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 22/11/2024.
//

import SwiftUI
import WeatherKit

struct WeatherForecast: View {
  
  let weather: Weather
  
    var body: some View {
      VStack{
        VStack{
          Text("Forecast weather by hours")
          Divider()
          ScrollView(.horizontal){
            LazyHGrid(rows: [GridItem(.flexible(), spacing: 10)]){
              ForEach(self.weather.hourlyForecast.forecast.prefix(24), id: \.date) { hour in
                VStack{
                  Text("\(hour.getHourFromForecast())")
                  Spacer()
                  Image(systemName: hour.getIconFromCondition())
                    .foregroundStyle(.black)
                  Spacer()
                }
              }
            }
          }
        }
        .frame(width: 350, height: 175)
      }
    }
}

//#Preview {
//    WeatherForecast()
//}
