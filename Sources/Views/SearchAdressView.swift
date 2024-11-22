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
// MARK: - @Environment variables
  @Environment(LocationController.self) private var locationController
  @Environment(WeatherController.self) private var weatherController
  @Environment(MapController.self) private var mapController
// MARK: - @State variables
  @State private var query: String = ""
// MARK: - Body
  var body: some View {
    NavigationStack{
      VStack{
        RoundedRectangle(cornerRadius: 5)
          .frame(width: 50, height: 5)
        TextField("Search an adress", text: self.$query)
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 10)
              .stroke(.gray, lineWidth: 3)
          )
        ScrollView{
          ForEach(mapController.localSearchCompletions, id: \.title) { result in
            NavigationLink {
              WeatherView(completion: result)
            } label: {
              HStack{
                Text(result.title + " " + result.subtitle)
                  .foregroundStyle(.black)
                Spacer()
              }
              .padding()
              .multilineTextAlignment(.leading)
            }
            Divider()
              .foregroundStyle(.gray)
          }
        }
        Spacer()
      }
      .padding()
      .ignoresSafeArea()
      .onChange(of: self.query) {
        mapController.query = self.query
      }
    }
  }
}
