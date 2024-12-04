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
// MARK: - @Environment variables
  @Environment(LocationController.self) private var locationController
  @Environment(WeatherController.self) private var weatherController
  @Environment(MapController.self) private var mapController
  @Environment(DataController.self) private var dataController
  @Environment(\.modelContext) private var context
// MARK: - @State variables
  @State private var showSearchAdressView = false
  @State private var weather: Weather? = nil
  @State private var showAnimation = false
// MARK: - Body
  var body: some View {
    NavigationStack{
      ZStack{
        if self.showAnimation, let weather = self.weather {
          Rectangle()
            .fill(weather.currentWeather.getColorGradientFromTemperatureInVertical())
            .ignoresSafeArea()
          VStack {
            NavigationLink {
              WeatherView(weather: weather)
            } label: {
              WeatherLocation(weather: weather)
                .foregroundStyle(.black)
            }
            .transition(.scale)
            Spacer()
            WeatherDataList()
            Spacer()
          }
          .frame(width: 375)
          .overlay(alignment: .bottom){
            Button {
              self.showSearchAdressView = true
            } label: {
              Image(systemName: "plus")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
            }
          }
        }
      }
      .fontDesign(.rounded)
      .sheet(isPresented: self.$showSearchAdressView, content: {
        SearchAdressView()
      })
      .onAppear{
        withAnimation(.smooth.delay(1)){
          self.showAnimation = true
        }
        locationController.requestLocation()
        dataController.context = self.context
        dataController.fetchData()
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
}
// MARK: - Preview
#Preview {
  @Previewable @State var locationController = LocationController()
  @Previewable @State var mapController = MapController()
  @Previewable @State var weatherController = WeatherController()
  @Previewable @State var dataController = DataController()
  LandingView()
    .modelContainer(for: DataModel.self)
    .environment(locationController)
    .environment(mapController)
    .environment(weatherController)
    .environment(dataController)
}
