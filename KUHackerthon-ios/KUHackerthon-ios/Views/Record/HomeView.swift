//
//  HomeView.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import SwiftUI

struct HomeView: View {
  @StateObject var sourceVM = SourcesViewModel()
  
  var body: some View {
    VStack{
      Text("hi")
      Text("hoho")
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
