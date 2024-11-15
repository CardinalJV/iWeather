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
  
  @State var mapController = MapController()
  let locationController = LocationController()
  let weatherController = WeatherController()
  
  @State private var showAddNewWeatherItemView = false
  
  @State private var weather: Weather? = nil
  
  let mockLocation = CLLocation(latitude: 43.554442, longitude: 2.115245)
  
  var body: some View {
    ZStack{
        // Background
      Rectangle()
        .fill(LinearGradient(colors: [.blue, .cyan.opacity(0)], startPoint: .bottom, endPoint: .top))
        .ignoresSafeArea()
        //
      if self.weather != nil {
        VStack {
          WeatherLocation(weather: self.weather!)
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
      SearchAdressView(weatherController: self.weatherController, mapController: self.$mapController)
    })
    .onAppear{
      self.locationController.requestLocation()
    }
    .onChange(of: self.locationController.userLocation) {
      Task {
        if let userLocation = self.locationController.userLocation {
          self.weather = await weatherController.fetchWeather(to: userLocation)
        } else {
          print("User location not found")
        }
      }
    }
  }
}

#Preview {
  LandingView()
}
