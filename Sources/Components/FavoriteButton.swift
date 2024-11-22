  //
  //  FavoriteButton.swift
  //  iWeather
  //
  //  Created by Jessy Viranaiken on 19/11/2024.
  //

import SwiftUI

struct FavoriteButton: View {
  
  @Environment(DataController.self) private var dataController
  
  let data: DataModel
  
  func image(_ image: Image, show: Bool) -> some View {
    image
      .scaleEffect(show ? 1 : 0)
      .tint(.black)
      .bold()
      .animation(.bouncy(duration: 0.5), value: show)
  }
  
  var body: some View {
    Button(action: {
        dataController.isInFavorites(data: self.data) ?
        dataController.delete(this: self.data) :
        dataController.add(this: self.data)
    }, label: {
      ZStack{
        image(Image(systemName: "heart.fill"), show: dataController.isInFavorites(data: self.data))
        image(Image(systemName: "heart"), show: !dataController.isInFavorites(data: self.data))
      }
    })
  }
}

  //#Preview {
  //    FavoriteButton()
  //}
