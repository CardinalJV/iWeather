  //  //
  //  //  WeatherItems.swift
  //  //  iWeather
  //  //
  //  //  Created by Jessy Viranaiken on 15/11/2024.
  //  //
  //
  //import SwiftUI
  //
  //struct WeatherDataList: View {
  //
  //  @Environment(DataController.self) private var dataController
  //
  //  @Namespace private var namespace
  //
  //  @State private var showAnimation = false
  //  @State private var dataRef: [DataModel] = []
  //
  //  var body: some View {
  //    VStack{
  //      if dataController.datas.isEmpty {
  //        Text("No data found in Storage")
  //          .foregroundStyle(.white)
  //          .font(.body)
  //          .bold()
  //      } else {
  //        VStack{
  //            //          ForEach(dataController.datas) { data in
  //            //            NavigationLink {
  //            //              WeatherView(data: data)
  //            //                .navigationTransition(.zoom(sourceID: "zoom", in: self.namespace))
  //            //            } label: {
  //            //              if self.showAnimation {
  //            //                WeatherDataListItem(data: data)
  //            //                  .shadow(color: .black.opacity(0.25), radius: 10)
  //            //              }
  //            //            }
  //            //            .transition(.slide)
  //            //          }
  //          ForEach(dataRef, id: \.id) { data in
  //              //            withAnimation(.bouncy.delay(3)) {
  //            NavigationLink {
  //              WeatherView(data: data)
  //                .navigationTransition(.zoom(sourceID: "zoom", in: self.namespace))
  //            } label: {
  //                //              if self.showAnimation {
  //              WeatherDataListItem(data: data)
  //                .shadow(color: .black.opacity(0.25), radius: 10)
  //                //              }
  //            }
  //            .transition(.move(edge: .leading))
  //              //            }
  //          }
  //        }
  //        .animation(.bouncy.delay(5), value: self.dataRef)
  //        .onAppear{
  //          self.dataRef.removeAll()
  //          for data in dataController.datas {
  //            if !self.dataRef.contains(data){
  //                //            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
  ////              withAnimation(.bouncy.delay(3)) {
  //                self.dataRef.append(data)
  ////              }
  //                //            }
  //            }
  //          }
  //        }
  //          //        .onAppear{
  //          //          withAnimation(.bouncy.delay(1)){
  //          //            self.showAnimation = true
  //          //          }
  //          //        }
  //          //        .animation(.bouncy, value: dataController.datas)
  //      }
  //    }
  //    .onAppear{
  //      dataController.fetchData()
  //    }
  //  }
  //
  //
  //}

import SwiftUI

struct WeatherDataList: View {
  
  @Environment(DataController.self) private var dataController
  
  @Namespace private var namespace
  
  @State private var showAnimation = false
  
  var body: some View {
    VStack {
      if dataController.datas.isEmpty {
        Text("No data found in Storage")
          .foregroundStyle(.white)
          .font(.body)
          .bold()
      } else {
        ScrollView{
          VStack{
            ForEach(dataController.datas, id: \.id) { data in
              NavigationLink {
                WeatherView(data: data)
                  .navigationTransition(.zoom(sourceID: "zoom", in: self.namespace))
              } label: {
                WeatherDataListItem(data: data)
                  .shadow(color: .black.opacity(0.25), radius: 10)
              }
              .scaleEffect(self.showAnimation ? 1 : 0)
              .opacity(self.showAnimation ? 1 : 0)
              .animation(.smooth.delay(1), value: self.showAnimation)
            }
          }
          .onAppear{
            self.showAnimation = true
          }
        }
        .frame(maxHeight: 350)
        .scrollClipDisabled()
      }
    }
    .onAppear {
      dataController.fetchData()
    }
  }
}

  //#Preview {
  //    WeatherDataItems()
  //}
