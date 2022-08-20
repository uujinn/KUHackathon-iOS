//
//  ContentView.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import SwiftUI

class TabBarManager: ObservableObject {
  @Published var showTabBar: Bool = true
  @Published var showRecord = false
  
  static let shared = TabBarManager()
}

class ViewRouter: ObservableObject {
  
  @Published var currentPage: Page = .home
  
}

enum Page {
  case home
  case user
}


struct ContentView: View {
  @StateObject var viewRouter: ViewRouter
  @ObservedObject var tabbarManager = TabBarManager.shared
  
  @State var showPopUp = false
  
  var body: some View {
    GeometryReader { geometry in
      VStack(alignment: .center, spacing: 0) {
        Spacer()
        switch viewRouter.currentPage {
        case .home:
          ZStack{
            Color.blue.opacity(0.2)
            HomeView() // 홈뷰
            if tabbarManager.showRecord{
              Color.black.opacity(0.4)
              RecordView(isShowing: $tabbarManager.showRecord)
                .frame(width: 331, height: 331)
                .transition(.move(edge: .top))
                .animation(.easeOut(duration: 0.1))
                
            }
          }
          
        case .user:
          ZStack{
            AccountView()
            Spacer()
          }
        }
//        Spacer()
        if tabbarManager.showTabBar{
          ZStack{
            if showPopUp {
              PlusMenu(viewRouter: viewRouter, widthAndHeight: geometry.size.width/7)
                .offset(y: -geometry.size.height/6)
            }
            HStack {
              TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "homekit", tabName: "Home")
              Spacer()
                .frame(width: 50)
              ZStack {
                Circle()
                  .foregroundColor(.white)
                  .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                  .shadow(radius: 4)
                Image(systemName: "plus.circle.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: geometry.size.width/5-6 , height: geometry.size.width/5-6)
                  .foregroundColor(Color.black)
                  .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
              }
              .offset(y: -geometry.size.height/8/2)
              .onTapGesture {
                withAnimation {
                  showPopUp.toggle()
                }
              }
              Spacer()
                .frame(width: 50)
              TabBarIcon(viewRouter: viewRouter, assignedPage: .user, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person.crop.circle", tabName: "Account")
            }
            .frame(width: geometry.size.width, height: geometry.size.height/8)
            .background(Color.black.shadow(radius: 2))
          }//ZStack
        }else{
          
        }
      }
      .edgesIgnoringSafeArea([.bottom, .top])
      .ignoresSafeArea()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewRouter: ViewRouter())
      .preferredColorScheme(.light)
      .previewInterfaceOrientation(.portrait)
  }
}

struct PlusMenu: View {
  @ObservedObject var tabbarManager = TabBarManager.shared
  @StateObject var viewRouter: ViewRouter
  let widthAndHeight: CGFloat
  
  var body: some View {
    HStack(spacing: 50) {
      ZStack {
        Circle()
          .foregroundColor(Color.black)
          .frame(width: widthAndHeight, height: widthAndHeight)
        Image(systemName: "record.circle")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(15)
          .frame(width: widthAndHeight, height: widthAndHeight)
          .foregroundColor(.white)
      }
      .onTapGesture {
        // 녹음 화면으로 이동
        tabbarManager.showRecord = true
        tabbarManager.showTabBar = false
      }
      .offset(x: 15, y: 20)
      ZStack {
        Circle()
          .foregroundColor(Color.black)
          .frame(width: widthAndHeight, height: widthAndHeight)
        Image(systemName: "pianokeys")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(15)
          .frame(width: widthAndHeight, height: widthAndHeight)
          .foregroundColor(.white)
      }
      ZStack {
        Circle()
          .foregroundColor(Color.black)
          .frame(width: widthAndHeight, height: widthAndHeight)
        Image(systemName: "folder")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(15)
          .frame(width: widthAndHeight, height: widthAndHeight)
          .foregroundColor(.white)
      }
      .offset(x: -15, y: 20)
    }
    .transition(.scale)
  }
}

struct TabBarIcon: View {
  
  @StateObject var viewRouter: ViewRouter
  let assignedPage: Page
  
  let width, height: CGFloat
  let systemIconName, tabName: String
  
  var body: some View {
    VStack {
      Image(systemName: systemIconName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: width, height: height)
        .padding(.top, 10)
      Text(tabName)
        .font(.footnote)
      Spacer()
    }
    .padding(.horizontal, -4)
    .onTapGesture {
      viewRouter.currentPage = assignedPage
    }
    .foregroundColor(viewRouter.currentPage == assignedPage ? Color.white : .white)
  }
}
