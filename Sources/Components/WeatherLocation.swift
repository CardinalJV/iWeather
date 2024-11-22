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
  
  @Environment(LocationController.self) private var locationController
  @Environment(MapController.self) private var mapController
  
  let weather: Weather?
  let location: CLLocation?
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
          Text(weather.currentWeather.getRoundedApparentTemperature())
            .font(.title2)
            .bold()
          Text(weather.currentWeather.condition.description)
            .font(.title2)
            .frame(width: 375)
            .task {
              if let location = self.location {
                self.placemark = await mapController.convertToCLPlacemark(location)
              }
            }
        }
        .animation(.bouncy, value: self.weather)
      } else {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle())
      }
    }
  }
}

  //#Preview {
  //    WeatherLocation()
  //}
