  //
  //  WeatherLocation.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 14/11/2024.
  //

import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherLocation: View {
  
  @Environment(MapController.self) private var mapController
  
  let weather: Weather?
  
  @State var placemark: CLPlacemark? = nil
  
  var body: some View {
    ZStack{
      if let weather = self.weather {
        VStack{
          if let locality = self.placemark?.locality {
            Text(locality)
              .font(.title)
              .bold()
          }
          Text("\(weather.currentWeather.getIconFromCondition())")
            .font(.system(size: 125))
            .shadow(color: .black.opacity(0.5), radius: 25)
          Text(weather.currentWeather.getRoundedApparentTemperature() + "°")
            .font(.title2)
            .bold()
          HStack{
            Text(weather.currentWeather.condition.description)
              .font(.title2)
            Divider()
              .padding(1)
              .background(.black)
              .frame(height: 30)
              .clipShape(RoundedRectangle(cornerRadius: 10))
            Image(systemName: weather.currentWeather.isDaylight ? "sun.max.fill" : "moon.fill")
              .font(.title2)
          }
        }
        .task {
          if let location = self.weather?.currentWeather.metadata.location {
            self.placemark = await mapController.convertToCLPlacemark(location)
          } 
        }
      } else {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle())
      }
    }
    .frame(minHeight: 200)
  }
}

  //#Preview {
  //    WeatherLocation()
  //}
