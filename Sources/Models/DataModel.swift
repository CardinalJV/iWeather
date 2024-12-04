//
//  LocationModel.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 19/11/2024.
//

import Foundation
import SwiftData
import CoreLocation

@Model
final class DataModel: Identifiable {
  var id: UUID = UUID()
  var city: String
  var latitude: Double
  var longitude: Double
  
  init(city: String, latitude: Double, longitude: Double) {
    self.city = city
    self.latitude = latitude
    self.longitude = longitude
  }
  
  func getLocation() -> CLLocation? {
    return CLLocation(latitude: self.latitude, longitude: self.longitude)
  }
}
