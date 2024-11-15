//
//  MapController.swift
//  iWeather
//
//  Created by Jessy Viranaiken on 15/11/2024.
//

import Foundation
import MapKit
import SwiftUI

@Observable
final class MapController {
  @ObservationIgnored private let localSearchCompleter = MKLocalSearchCompleter()
  
  var query: String = "" {
    didSet {
      self.localSearchCompleter.queryFragment = query
    }
  }
  
  var localSearchCompletion: [MKLocalSearchCompletion] = []
  
  init() {
    setupSearchCompleter()
  }
  
  private func setupSearchCompleter() {
      // Configure the searchCompleter
    self.localSearchCompleter.resultTypes = .address
    self.localSearchCompleter.region = MKCoordinateRegion(.world)
    
      // Periodically check for changes in `searchCompleter.results`
    DispatchQueue.main.async {
      self.observeResults()
    }
  }
  
  private func observeResults() {
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
      if self.localSearchCompleter.results != self.localSearchCompletion {
        self.localSearchCompletion = self.localSearchCompleter.results
      }
    }
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
}
