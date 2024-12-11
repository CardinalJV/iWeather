  //
  //  WeatherDataListItem.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 20/11/2024.
  //

import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherDataListItem: View {
  
  @Environment(WeatherController.self) private var weatherController
  
  let data: DataModel
  
  @State var weather: Weather? = nil
  
  var body: some View {
    ZStack{
      if let weather = self.weather {
        HStack{
            Text(weather.currentWeather.getIconFromCondition())
              .font(.system(size: 60))
              .shadow(color: .black.opacity(0.5), radius: 10)
          Text(weather.currentWeather.getRoundedApparentTemperature() + "°")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .bold()
          Spacer()
          VStack(alignment: .trailing, spacing: 0){
            Text(self.data.city)
              .font(.title3)
              .bold()
              .foregroundStyle(.black)
              .frame(maxWidth: 125, alignment: .trailing)
            Text("\(weather.currentWeather.condition.description)")
              .foregroundStyle(.black)
              .shadow(color: .black.opacity(0.5), radius: 50)
            Text("Wind: \(weather.currentWeather.wind.getRoundedSpeed()) km/h")
              .font(.caption)
              .foregroundStyle(.black)
              .bold()
          }
        }
        .padding(10)
        .frame(width: 350, height: 75)
        .background(weather.currentWeather.getColorGradientFromTemperatureInHorizontal())
        .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }
    .task {
      self.weather = await weatherController.fetchWeather(to: CLLocation(latitude: self.data.latitude, longitude: self.data.longitude))
    }
  }
}

//#Preview {
//    WeatherDataListItem()
//}
