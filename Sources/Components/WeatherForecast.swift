  //
  //  WeatherForecast.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 22/11/2024.
  //

import SwiftUI
import WeatherKit

struct WeatherForecast: View {
  
  let weather: Weather
  
  @State private var wind: Wind? = nil
  
  var body: some View {
    VStack(spacing: 25){
      /* Weather forecast by hours */
      VStack{
        Text("Weather forecast by hours")
          .bold()
        Divider()
        ScrollView(.horizontal){
          LazyHGrid(rows: [GridItem(.flexible(), spacing: 10)]){
            ForEach(self.weather.hourlyForecast.forecast.filter{ $0.date >= Date() }.prefix(24), id: \.date) { hour in
              VStack{
                Text("\(hour.getHourFromForecast())h")
                Spacer()
                Image(systemName: hour.symbolName)
                  .font(.title3)
                Spacer()
                Text(hour.getRoundedApparentTemperature() + "°")
              }
              .frame(maxHeight: 90)
            }
          }
        }
        .scrollIndicators(.hidden)
        .frame(height: 80)
      }
      .frame(width: 350)
      /* - */
      /* Weather forecast for next days */
      VStack{
        Text("Weather forecast for next days")
          .bold()
        Divider()
        ForEach(self.weather.dailyForecast.forecast.prefix(7), id: \.date) { daily in
          let day = daily.date.formatted(.dateTime.weekday(.wide))
          HStack{
            Text(day == Date.now.formatted(.dateTime.weekday(.wide)) ? "Today" : day)
              .font(.title3)
              .frame(minWidth: 125, alignment: .leading)
            Spacer()
            Image(systemName: daily.symbolName)
              .font(.title3)
            Spacer()
            Text("\(daily.getRoundedLowTemperature()) - \(daily.getRoundedHighTemperature())")
              .font(.title3)
              .frame(minWidth: 100, alignment: .trailing)
          }
        }
      }
      .frame(width: 350)
      /* - */
      /* Air quality */
        //      VStack{
        //        Text("Air quality")
        //        Divider()
        //          //        Text(self.weather)
        //      }
        //      .frame(width: 350)
      /* - */
      /* Wind */
      if let wind = self.wind {
        VStack{
          Text("Wind")
            .bold()
          Divider()
          HStack{
            VStack(alignment: .leading){
              HStack{
                Text("Wind Speed:")
                Text(wind.getRoundedSpeed())
              }
              
              HStack{
                Text("Wind Direction:")
                Text(wind.compassDirection.abbreviation)
              }
              
              HStack{
                Text("Degrees:")
                Text(wind.getRoundedDegree() + "°")
              }
            }
            Spacer()
            Compass(direction: wind.direction.value)
          }
        }
        .frame(width: 350)
      }
      /* - */
    }
    .onAppear {
      self.wind = self.weather.currentWeather.wind
    }
  }
}

  //#Preview {
  //    WeatherForecast()
  //}

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
