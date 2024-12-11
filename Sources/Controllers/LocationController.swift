//
//  LocationController.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 15/11/2024.
//

import CoreLocation

@Observable
final class LocationController: NSObject, CLLocationManagerDelegate {
  
  @ObservationIgnored private let locationManager = CLLocationManager()
  
  var userLocation: CLLocation?
  
  @ObservationIgnored private var permissionDenied: Bool = false
  
  override init() {
    super.init()
    setupLocationManager()
  }
  
  private func setupLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func requestLocation() {
    switch locationManager.authorizationStatus {
      case .notDetermined:
        locationManager.requestWhenInUseAuthorization()
      case .authorizedWhenInUse, .authorizedAlways:
        locationManager.startUpdatingLocation()
      case .denied, .restricted:
        permissionDenied = true
      @unknown default:
        break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    DispatchQueue.main.async {
      self.userLocation = location
    }
    manager.stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error during fetching location: \(error.localizedDescription)")
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
      case .authorizedWhenInUse, .authorizedAlways:
        manager.startUpdatingLocation()
      case .denied:
        permissionDenied = true
      default:
        break
    }
  }
}
