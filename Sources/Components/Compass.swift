  //
  //  Compass.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 02/12/2024.
  //

import SwiftUI
import WeatherKit

struct Compass: View {
  
  let direction: Double
  let roundedRectangleOffset: Double = 45
  let textOffset: CGFloat = 40
  
  var body: some View {
    ZStack{
      Circle()
        .stroke(lineWidth: 2)
        .foregroundStyle(.black)
        .frame(width: 100)
      Circle()
        .frame(width: 5)
      Text("N")
        .offset(y: -self.textOffset)
        .bold()
        .font(.subheadline)
      Text("E")
        .offset(x: self.textOffset)
        .bold()
        .font(.subheadline)
      Text("S")
        .offset(y: self.textOffset)
        .bold()
        .font(.subheadline)
      Text("W")
        .offset(x: -self.textOffset)
        .bold()
        .font(.subheadline)
      RoundedRectangle(cornerRadius: 5)
        .frame(width: 10, height: 2)
        .offset(x: self.roundedRectangleOffset)
        .rotationEffect(.degrees(-45))
      RoundedRectangle(cornerRadius: 5)
        .frame(width: 10, height: 2)
        .offset(x: self.roundedRectangleOffset)
        .rotationEffect(.degrees(45))
      RoundedRectangle(cornerRadius: 5)
        .frame(width: 10, height: 2)
        .offset(x: self.roundedRectangleOffset)
        .rotationEffect(.degrees(-135))
      RoundedRectangle(cornerRadius: 5)
        .frame(width: 10, height: 2)
        .offset(x: self.roundedRectangleOffset)
        .rotationEffect(.degrees(135))
      ZStack{
        RoundedRectangle(cornerRadius: 5)
          .frame(width: 20, height: 2)
        Image(systemName: "chevron.right")
          .font(.subheadline)
          .offset(x: 7.5)
      }
      .offset(x: 15)
      .rotationEffect(.degrees(270 + self.direction))
    }
  }
}

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

//#Preview {
//  CustomArrow(direction: 135)
//}


