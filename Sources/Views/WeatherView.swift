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
  
  let weatherController: WeatherController
  let mapController: MapController
  let completion: MKLocalSearchCompletion
  
  @State var location: CLLocation? = nil
  @State var weather: Weather? = nil
  
    var body: some View {
      VStack{
        if self.weather != nil {
          Text("\(self.weather!.currentWeather.apparentTemperature.value)")
        } else {
          Text("error")
        }
      }
      .task {
        self.location = await self.mapController.convertToCLLocation(self.completion)
        if self.location != nil {
          self.weather = await self.weatherController.fetchWeather(to: self.location!)
        }
      }
    }
}

//#Preview {
//    WeatherView()
//}
