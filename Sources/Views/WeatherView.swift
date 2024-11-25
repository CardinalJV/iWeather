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
  @State var location: CLLocation? = nil
  @State var weather: Weather? = nil
  @State var data: DataModel? = nil
  @State var placemark: CLPlacemark? = nil
// MARK: - Body
  var body: some View {
    ZStack{
      if let weather = self.weather, let location = self.location {
        Rectangle()
          .fill(weather.currentWeather.getColorGradientFromTemperatureInVertical())
          .ignoresSafeArea()
        VStack{
          HStack{
            Button(action: {
              dismiss()
            }) {
              HStack {
                Image(systemName: "chevron.left")
                Text("Back")
              }
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
          ScrollView{
            WeatherLocation(weather: weather, location: location)
            WeatherForecast(weather: weather)
            Spacer()
          }
        }
      } else {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle() )
      }
    }
    .task {
      if let completion = self.completion {
        self.location = await mapController.convertToCLLocation(completion)
      }
      if let location = self.location  {
        self.weather = await weatherController.fetchWeather(to: location)
        self.placemark = await mapController.convertToCLPlacemark(location)
        self.data = DataModel(city: self.placemark!.locality!, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
      } else {
        if let data = self.data {
          self.location = CLLocation(latitude: data.latitude, longitude: data.longitude)
          self.weather = await weatherController.fetchWeather(to: CLLocation(latitude: data.latitude, longitude: data.longitude))
        }
      }
    }
    .navigationBarBackButtonHidden(true)
  }
}

  //#Preview {
  //    WeatherView()
  //}
