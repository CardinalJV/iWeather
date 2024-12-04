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
    // MARK: - @Environment variables
  @Environment(LocationController.self) private var locationController
  @Environment(WeatherController.self) private var weatherController
  @Environment(MapController.self) private var mapController
  @Environment(DataController.self) private var dataController
  @Environment(\.dismiss) private var dismiss
    // MARK: - @State variables
  @State var completion: MKLocalSearchCompletion? = nil
  @State var data: DataModel? = nil
  @State var weather: Weather? = nil
    // MARK: - Body
  var body: some View {
    ZStack{
      if let weather = self.weather {
        Rectangle()
          .fill(weather.currentWeather.getColorGradientFromTemperatureInVertical())
          .ignoresSafeArea()
      }
      VStack{
        if let weather = self.weather {
          /* Toolbar custom */
          HStack{
            Button(action: {
              dismiss()
            }) {
              Text("Back")
                .foregroundStyle(.black)
                .font(.title3)
                .bold()
            }
            Spacer()
            if let data = self.data {
              Button {
                dataController.add(this: data)
              } label: {
                FavoriteButton(data: data)
                  .font(.title2)
              }
            }
          }
          .padding()
          .background(.clear)
          /* - */
          ScrollView{
            VStack(spacing: 25){
              WeatherLocation(weather: weather)
              WeatherForecast(weather: weather)
              Spacer()
            }
          }
          .scrollIndicators(.hidden)
        } else {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle() )
        }
      }
    }
    .task {
        // Completion provided by SearchAdressView
      if let completion = self.completion {
        if let location = await mapController.convertToCLLocation(completion) {
          self.weather = await weatherController.fetchWeather(to: location)
          if let placemark = await mapController.convertToCLPlacemark(location), let locality = placemark.locality {
            self.data = DataModel(city: locality, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
          }
        }
      }
        // Data provided by SwiftData
      if let data = self.data, let location = data.getLocation() {
        self.weather = await weatherController.fetchWeather(to: location)
      }
    }
    .navigationBarBackButtonHidden(true)
  }
}

  //#Preview {
  //    WeatherView()
  //}
