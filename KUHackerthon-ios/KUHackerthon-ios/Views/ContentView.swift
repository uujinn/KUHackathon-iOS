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
      
      ZStack() {
        Spacer()
        switch viewRouter.currentPage {
        case .home:
          ZStack{
            Color(hex: "262626")
            HomeView() // 홈뷰
            if showPopUp{
              Color.black.opacity(0.4)
                .onTapGesture {
                  showPopUp = false
                }
            }
            
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
            if showPopUp{
              Color.black.opacity(0.4)
                .onTapGesture {
                  showPopUp = false
                }
            }
            if tabbarManager.showRecord{
              Color.black.opacity(0.4)
              RecordView(isShowing: $tabbarManager.showRecord)
                .frame(width: 331, height: 331)
                .transition(.move(edge: .top))
                .animation(.easeOut(duration: 0.1))
                
            }
          }
        }
//        Spacer()
        if tabbarManager.showTabBar{
          ZStack{
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
              .frame(width: geometry.size.width, height: geometry.size.height/5)
              .cornerRadius(16)
            if showPopUp {
              PlusMenu(viewRouter: viewRouter, widthAndHeight: geometry.size.width/7)
                .offset(y: -geometry.size.height/6)
            }
            HStack {
              TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "house.fill", tabName: "홈")
              Spacer()
                .frame(width: 50)
              ZStack {
                Circle()
                  .foregroundColor(.white)
                  .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                  .shadow(radius: 4)
                Image("create 2")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: geometry.size.width/5-6 , height: geometry.size.width/5-6)
                  .foregroundColor(Color.black)
                  .shadow(radius: 10)
              }
              .offset(y: -geometry.size.height/8/1.5)
              .onTapGesture {
                withAnimation {
                  showPopUp.toggle()
                }
              }
              Spacer()
                .frame(width: 50)
              TabBarIcon(viewRouter: viewRouter, assignedPage: .user, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "person", tabName: "나의 코드")
            }
            .frame(width: geometry.size.width, height: geometry.size.height/5)
//            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
          }//ZStack
          .offset(y: geometry.size.height / 2)
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
          .frame(width: widthAndHeight + 10, height: widthAndHeight + 10)
        Image("record")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: widthAndHeight + 10, height: widthAndHeight + 10)
          .foregroundColor(.white)
      }
      .onTapGesture {
        // 녹음 화면으로 이동
        tabbarManager.showRecord = true
        tabbarManager.showTabBar = false
      }
      .offset(x: 15, y: 10)
      ZStack {
        Circle()
          .foregroundColor(Color.black)
          .frame(width: widthAndHeight + 10, height: widthAndHeight + 10)
        Image("vir")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: widthAndHeight + 10, height: widthAndHeight + 10)
          .foregroundColor(.white)
      }
      .offset(x: 0, y: -40)
      ZStack {
        Circle()
          .foregroundColor(Color.black)
          .frame(width: widthAndHeight + 10, height: widthAndHeight + 10)
        Image("new")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: widthAndHeight + 10, height: widthAndHeight + 10)
          .foregroundColor(.white)
      }
      .offset(x: -15, y: 10)
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
        .foregroundColor(Color(hex: "eaeaea"))
      Text(tabName)
        .foregroundColor(Color(hex: "eaeaea"))
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

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
