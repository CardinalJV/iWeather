//
//  MapController.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 15/11/2024.
//

import MapKit

@Observable
final class MapController {
  
  @ObservationIgnored private var localSearchCompleter = MKLocalSearchCompleter()
  
  var query: String = "" {
    didSet{
      self.localSearchCompleter.queryFragment = query
      if self.localSearchCompleter.results != self.localSearchCompletions {
        self.localSearchCompletions = self.localSearchCompleter.results
      }
    }
  }
  
  var localSearchCompletions: [MKLocalSearchCompletion] = []
  
  init() {
    setupSearchCompleter()
  }
  
  private func setupSearchCompleter() {
    self.localSearchCompleter.resultTypes = .address
    self.localSearchCompleter.region = MKCoordinateRegion(.world)
  }
  
  func convertToCLLocation(_ completion: MKLocalSearchCompletion) async -> CLLocation? {
    let searchRequest = MKLocalSearch.Request(completion: completion)
    let search = MKLocalSearch(request: searchRequest)
    do {
      let response = try await search.start()
      if let coordinate = response.mapItems.first?.placemark.coordinate {
        return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
      }
    } catch {
      print("Error during search: \(error.localizedDescription)")
    }
    return nil
  }
  
  func convertToCLPlacemark(_ location: CLLocation) async -> CLPlacemark? {
    let geocoder = CLGeocoder()
    do {
      let localSearch = try await geocoder.reverseGeocodeLocation(location)
      let placemark = localSearch.first
      return placemark
    } catch {
      print("Error during convertions: \(error.localizedDescription)")
      return nil
    }
  }
}
