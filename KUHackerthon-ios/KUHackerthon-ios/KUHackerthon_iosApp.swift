//
//  KUHackerthon_iosApp.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import SwiftUI

@main
struct KUHackerthon_iosApp: App {
  
  @StateObject var viewRouter = ViewRouter()
  var body: some Scene {
    WindowGroup {
      ContentView(viewRouter: viewRouter)
    }
  }
}
