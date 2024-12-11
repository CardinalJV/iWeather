  //
  //  DataController.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 19/11/2024.
  //

import SwiftData
import SwiftUI

@Observable
final class DataController {
  
  var datas: [DataModel] = []
  var context: ModelContext? = nil
  
  init() {
    fetchData()
  }
//  Create
  func add(this data: DataModel) {
    guard let context = self.context else {
      return
    }
    do {
      context.insert(data)
      try context.save()
      print("Data adding")
      fetchData()
    } catch {
      print("Error during add new data: \(error.localizedDescription)")
    }
  }
//  Read
  func fetchData() {
    guard let context = self.context else {
      return
    }
    let request = FetchDescriptor<DataModel>()
    do {
        self.datas = try context.fetch(request)
    } catch {
      print("Error during fetching data: \(error.localizedDescription)")
    }
  }
//  Update
  func updateData() {
    guard let context = self.context else {
      return
    }
    do {
      try context.save()
      fetchData()
    } catch {
      print("Error during updating data: \(error.localizedDescription)")
    }
  }
//  Delete
  func delete(this data: DataModel) {
    guard let context = self.context else {
      return
    }
    context.delete(data)
    fetchData()
  }
  
  func isInFavorites(data: DataModel) -> Bool {
    return self.datas.contains(where: { $0.city.lowercased() == data.city.lowercased() })
  }
}
