//
//  WeatherView.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 15/11/2024.
//

import SwiftUI
import CoreLocation
import WeatherKit
import MapKit

struct WeatherView: View {
  
  @Environment(LocationController.self) private var locationController
  @Environment(WeatherController.self) private var weatherController
  @Environment(MapController.self) private var mapController
  
  let completion: MKLocalSearchCompletion
  
  @State var location: CLLocation? = nil
  @State var weather: Weather? = nil
  
    var body: some View {
      ZStack{
        if self.weather != nil && self.location != nil {
          Rectangle()
            .fill(self.weather!.currentWeather.getColorGradientFromTemperatureInVertical())
            .ignoresSafeArea()
          VStack{
            WeatherLocation(weather: self.weather!, location: self.location!)
            Spacer()
          }
        } else {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
        }
      }
      .task {
        self.location = await mapController.convertToCLLocation(self.completion)
        if self.location != nil {
          self.weather = await weatherController.fetchWeather(to: self.location!)
        }
      }
    }
}

//#Preview {
//    WeatherView()
//}
