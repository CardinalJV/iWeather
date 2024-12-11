  //
  //  SwiftUIView.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 15/11/2024.
  //

import SwiftUI

struct SearchAddressView: View {
    // MARK: - @Environment variables
  @Environment(MapController.self) private var mapController
  @Environment(\.dismiss) private var dismiss
    // MARK: - @State variables
  @State private var query: String = ""
    // MARK: - Body
  var body: some View {
    NavigationStack{
      VStack{
        Button {
          dismiss()
        } label: {
          RoundedRectangle(cornerRadius: 5)
            .frame(width: 50, height: 5)
            .foregroundStyle(.gray)
        }
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
