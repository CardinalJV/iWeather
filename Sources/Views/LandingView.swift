  //
  //  ContentView.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 13/11/2024.
  //

import SwiftUI
import WeatherKit
import CoreLocation

struct LandingView: View {
  
  @Environment(LocationController.self) private var locationController
  @Environment(WeatherController.self) private var weatherController
  @Environment(MapController.self) private var mapController
  
  @State private var showAddNewWeatherItemView = false
  
  @State private var weather: Weather? = nil
  
  let mockLocation = CLLocation(latitude: 43.554442, longitude: 2.115245)
  
  var body: some View {
    ZStack{
      Rectangle()
        .fill(LinearGradient(colors: [.blue, .cyan.opacity(0)], startPoint: .bottom, endPoint: .top))
        .ignoresSafeArea()
      if self.weather != nil && locationController.userLocation != nil {
        VStack {
          WeatherLocation(weather: self.weather!, location: locationController.userLocation!)
          Spacer()
        }
        .frame(width: 375)
        .overlay(alignment: .bottom){
          Button {
            self.showAddNewWeatherItemView = true
          } label: {
            Image(systemName: "plus")
              .font(.largeTitle)
              .bold()
              .foregroundStyle(.white)
          }
        }
      }
    }
    .sheet(isPresented: self.$showAddNewWeatherItemView, content: {
      SearchAdressView()
    })
    .onAppear{
      locationController.requestLocation()
    }
    .onChange(of: locationController.userLocation) {
      Task {
        if let userLocation = locationController.userLocation {
          self.weather = await weatherController.fetchWeather(to: userLocation)
        } else {
          print("User location not found")
        }
      }
    }
  }
}

#Preview {
  @Previewable @State var locationController = LocationController()
  @Previewable @State var mapController = MapController()
  @Previewable @State var weatherController = WeatherController()
  LandingView()
    .environment(locationController)
    .environment(mapController)
    .environment(weatherController)
}
