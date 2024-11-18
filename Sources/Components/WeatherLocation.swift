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
    VStack{
      if self.weather != nil {
        if self.placemark != nil {
          Text(self.placemark!.locality!)
            .font(.title)
            .bold()
        }
        Text("\(self.weather!.currentWeather.getIconFromCondition())")
          .font(.system(size: 125))
          .shadow(color: .black.opacity(0.5), radius: 50)
        Text("\(String(format: "%.0f", self.weather!.currentWeather.apparentTemperature.value))°")
          .font(.title2)
          .bold()
        Text(self.weather!.currentWeather.condition.description)
          .font(.title2)
          .frame(width: 375)
          .task {
            if self.location != nil {
              self.placemark = await mapController.convertToCLPlacemark(self.location!)
            }
          }
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
