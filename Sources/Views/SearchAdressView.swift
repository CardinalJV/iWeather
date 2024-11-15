  //
  //  SwiftUIView.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 15/11/2024.
  //

import SwiftUI
import CoreLocation
import WeatherKit
import MapKit

struct SearchAdressView: View {
  
  let weatherController: WeatherController
  @Binding var mapController: MapController
  
  var body: some View {
    NavigationStack{
      VStack{
        TextField("Search an adress", text: self.$mapController.query)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 10)
              .stroke(.gray, lineWidth: 3)
          )
        ScrollView{
          ForEach(self.mapController.localSearchCompletion, id: \.title) { result in
            NavigationLink {
              WeatherView(weatherController: self.weatherController,mapController: self.mapController, completion: result)
            } label: {
              HStack{
                Text(result.title + " " + result.subtitle)
                Spacer()
              }
              .padding()
              Divider()
                .foregroundStyle(.gray)
            }
          }
        }
        Spacer()
      }
      .padding()
    }
  }
}
