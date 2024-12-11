  //
  //  ContentView.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 13/11/2024.
  //

import SwiftUI
import WeatherKit

struct LandingView: View {
    // MARK: - @Environment variables
  @Environment(LocationController.self) private var locationController
  @Environment(WeatherController.self) private var weatherController
  @Environment(DataController.self) private var dataController
  @Environment(\.modelContext) private var context
    // MARK: - @State variables
  @State private var showSearchAddressView = false
  @State private var weather: Weather? = nil
  @State private var showAnimation = false
    // MARK: - Body
  var body: some View {
    NavigationStack{
      ZStack{
        if let weather = self.weather {
          /* Background */
          Rectangle()
            .fill(weather.currentWeather.getColorGradientFromTemperatureInVertical())
            .ignoresSafeArea()
          /* - */
          VStack(spacing: 20){
            /* Weather at user location */
            NavigationLink {
              WeatherView(weather: weather)
            } label: {
              if self.showAnimation {
                WeatherLocation(weather: weather)
                  .foregroundStyle(.black)
                  .transition(.scale)
              }
            }
            /* - */
            Spacer()
            /* Weather of local data */
            WeatherDataList()
            /* - */
            Spacer()
          }
          .onAppear{
            withAnimation(.smooth.delay(1)){
              self.showAnimation = true
            }
          }
          .frame(width: 375)
          .overlay(alignment: .bottom){
            Button {
              self.showSearchAddressView = true
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
      .sheet(isPresented: self.$showSearchAddressView, content: {
        SearchAddressView()
      })
        // Fetch local data and request user location
      .onAppear{
        locationController.requestLocation()
        dataController.context = self.context
      }
        // Request weather at user location
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
