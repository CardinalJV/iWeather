  //
  //  WeatherItems.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 15/11/2024.
  //

import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherDataList: View {
  
  @Environment(DataController.self) private var dataController
  
  @Namespace private var namespace
  
  @State private var showAnimation = false
  
  var body: some View {
    VStack{
      if dataController.datas.isEmpty {
        Text("No data found in Storage")
          .foregroundStyle(.white)
          .font(.body)
          .bold()
      } else {
        VStack{
          ForEach(dataController.datas) { data in
            NavigationLink {
              WeatherView(data: data)
                .navigationTransition(.zoom(sourceID: "zoom", in: self.namespace))
            } label: {
              WeatherDataListItem(data: data)
                .shadow(color: .black.opacity(0.25), radius: 10)
            }
            .transition(.move(edge: .bottom))
          }
        }
        .animation(.bouncy, value: dataController.datas)
      }
    }
    .onAppear{
      dataController.fetchData()
    }
  }
}

  //#Preview {
  //    WeatherDataItems()
  //}
