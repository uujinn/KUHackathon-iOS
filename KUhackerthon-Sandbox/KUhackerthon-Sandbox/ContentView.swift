//
//  ContentView.swift
//  KUhackerthon-Sandbox
//
//  Created by 양유진 on 2022/08/20.
//

import SwiftUI
import AVFoundation
import Combine

struct ContentView: View {
  var body: some View {
    VStack{
      Button {
        print("recording")
      } label: {
        Image(systemName: "airplane")
      }

    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
