  //
  //  iWeatherApp.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 13/11/2024.
  //

import SwiftUI

@main
struct iWeatherApp: App {
  
  @State private var weatherController = WeatherController()
  @State private var locationController = LocationController()
  @State private var mapController = MapController()
  
  var body: some Scene {
    WindowGroup {
      LandingView()
        .environment(weatherController)
        .environment(locationController)
        .environment(mapController)
    }
  }
}
