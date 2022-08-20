//
//  EditView.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import SwiftUI

enum DragState {
  case inactive
  case pressing
  case dragging(translation: CGSize)
  
  var translation: CGSize {
    switch self {
    case .inactive, .pressing:
      return .zero
    case .dragging(let translation):
      return translation
    }
  }
  
  var isPressing: Bool {
    switch self {
    case .pressing, .dragging:
      return true
    case .inactive:
      return false
    }
  }
}


struct EditView: View {
  
  @State private var editmode = false
  @State private var firstScreen = true
  @GestureState private var dragState = DragState.inactive
  @GestureState private var dragState2 = DragState.inactive
  @GestureState private var dragState3 = DragState.inactive
  @GestureState private var dragState4 = DragState.inactive
  @State private var position = CGSize.zero
  @State private var position2 = CGSize.zero
  @State private var position3 = CGSize.zero
  @State private var position4 = CGSize.zero
  @ObservedObject var tabbarManager = TabBarManager.shared
  
  
  var body: some View {
    ZStack{
      VStack(spacing: 0){
        HStack(alignment: .center){ //  상단 메뉴바
          Spacer()
            .frame(width: 40)
          Button {
            tabbarManager.showEdit = false
            tabbarManager.showTabBar = true
          } label: {
            HStack{
              Image(systemName: "chevron.left")
                .foregroundColor(Color(hex: "acacac"))
              Text("홈")
                .font(.system(size: 15))
                .foregroundColor(Color(hex: "acacac"))
            }
          }
          Spacer()
          Spacer()
          HStack(spacing: 34){
            Image(systemName: "backward.end.fill")
              .foregroundColor(Color(hex: "acacac"))
            Image(systemName: "play.fill")
              .foregroundColor(Color(hex: "43cad9"))
            Image(systemName: "forward.end.fill")
              .foregroundColor(Color(hex: "acacac"))
          }
          Spacer()
          Image(systemName: "metronome")
            .foregroundColor(Color(hex: "acacac"))
          Spacer()
        }//HStack
        .background(Color(hex: "393939"))
        .frame(height: 45)
        HStack{
          VStack(alignment: .center){
            Spacer()
              .frame(height: 5)
            Image("1")
              .resizable()
              .clipShape(Circle())
              .shadow(radius: 10)
              .overlay(Circle().stroke(Color.gray, lineWidth: 1))
              .frame(width: 36, height: 36)
            Spacer()
              .frame(height: 44)
            Image("2")
              .resizable()
              .clipShape(Circle())
              .shadow(radius: 10)
              .overlay(Circle().stroke(Color.gray, lineWidth: 1))
              .frame(width: 36, height: 36)
            Spacer()
              .frame(height: 44)
            Image("3")
              .resizable()
              .clipShape(Circle())
              .shadow(radius: 10)
              .overlay(Circle().stroke(Color.gray, lineWidth: 1))
              .frame(width: 36, height: 36)
            Spacer()
              .frame(height: 44)
            Image(systemName: "plus")
              .resizable()
              .foregroundColor(Color(hex: "43cad9"))
              .frame(width: 25, height: 25)
          }.padding(.horizontal, 20)
          ScrollView(.horizontal){
            HStack(spacing: 13){
              ForEach(1..<8, id: \.self){ num in
                Text("\(num)")
                  .foregroundColor(.gray)
                  .font(.system(size: 12))
                ForEach(0..<7, id: \.self){ i in
                  
                  if i < 3{
                    Divider().frame(height: 5)
                      .foregroundColor(.white)
                  }else if i == 3{
                    Divider().frame(height: 10)
                      .foregroundColor(.white)
                  }else{
                    Divider().frame(height: 5)
                      .foregroundColor(.white)
                  }
                }
              }
            }
            ForEach(0..<4, id: \.self){ num in
              if num == 0{
                HStack(spacing: 2){
                  Rectangle()
                    .frame(width: 180 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "ceeff2"))
                  ZStack{
                    Rectangle()
                      .frame(width: 140 , height: 70)
                      .cornerRadius(10)
                      .foregroundColor(Color(hex: "e8d6ff"))
                      .background(.thickMaterial)
                      .onLongPressGesture {
                        print("bi")
                      }
                    Rectangle()
                      .frame(width: 140 , height: 70)
                      .cornerRadius(10)
                      .foregroundColor(Color(hex: "e8d6ff"))
                      .background(.thickMaterial)
                      .onLongPressGesture {
                        print("bi")
                      }
                  }
                }.offset(x: -228 ,y: 0)
                
              }
              else if num == 1{
                HStack(spacing: 2){
                  Rectangle()
                    .frame(width: 180 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "43cad9"))
                  Rectangle()
                    .frame(width: 140 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "94e1f2"))
                }.offset(x: -228 ,y: 0)
                
              }
              else if num == 2{
                HStack(spacing: 2){
                  Rectangle()
                    .frame(width: 35 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "a865ff"))
                  Rectangle()
                    .frame(width: 50 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "43cad9")).opacity(0)
                  Rectangle()
                    .frame(width: 35 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "a865ff"))
                  Rectangle()
                    .frame(width: 50 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "43cad9")).opacity(0)
                  Rectangle()
                    .frame(width: 35 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "a865ff"))
                  Rectangle()
                    .frame(width: 50 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "43cad9")).opacity(0)
                  Rectangle()
                    .frame(width: 35 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "a865ff"))
                  Rectangle()
                    .frame(width: 50 , height: 70)
                    .cornerRadius(10)
                    .foregroundColor(Color(hex: "43cad9")).opacity(0)
                }.offset(x: -212 ,y: 0)
              }
              else if num == 3{
                Rectangle()
                  .frame(width: 70 , height: 80)
                  .opacity(0)
              }
            }
          }
          .background(Color(hex: "262626"))
        }//HStack
        .background(Color(hex: "393939"))
      }//VStack
      .background(Color(hex: "393939"))
      
      if editmode == false{
        Rectangle()
          .frame(width: Screen.maxHeight * 0.85, height: Screen.maxWidth * 0.85)
          .background(.ultraThickMaterial)
          .foregroundColor(Color.white.opacity(0.9))
          .cornerRadius(15)
          .overlay{
            if firstScreen{
              VStack(spacing: 40){
                Text("저장된 피스 & 믹스")
                  .foregroundColor(Color.black)
                  .font(.system(size: 21))
                HStack(spacing: 72){
                  VStack(spacing: 20){
                    Image("i1")
                      .frame(width: 80, height: 150)
                    Text("내 피스")
                      .foregroundColor(Color.black)
                      .font(.system(size: 15))
                      .bold()
                  }
                  VStack(spacing: 20){
                    Image("i2")
                      .frame(width: 80, height: 150)
                    Text("내 믹스")
                      .foregroundColor(Color.black)
                      .font(.system(size: 15))
                      .bold()
                    
                  }
                  .onTapGesture {
                    firstScreen = false
                  }
                  VStack(spacing: 20){
                    Image("i3")
                      .frame(width: 80, height: 150)
                    Text("다른 사람의 피스")
                      .foregroundColor(Color.black)
                      .font(.system(size: 15))
                      .bold()
                  }
                  VStack(spacing: 20){
                    Image("i4")
                      .frame(width: 80, height: 150)
                    Text("다른 사람의 믹스")
                      .foregroundColor(Color.black)
                      .font(.system(size: 15))
                      .bold()
                  }
                }
              }
              
            }else{
              
              VStack(spacing: 0){
                HStack{
                  Button {
                    print("뒤로가기")
                    firstScreen = true
                  } label: {
                    HStack{
                      Image("chevron.left")
                        .resizable()
                      Text("뒤로가기")
                        .font(.system(size: 19))
                    }.foregroundColor(Color(hex: "b2b2b2"))
                  }
                  Spacer()
                    .frame(width: 500)
                  Button {
                    print("추가")
                    editmode = true
                  } label: {
                    Text("추가")
                      .bold()
                      .font(.system(size: 19))
                      .foregroundColor(Color(hex: "43cad9"))
                  }
                  Spacer()
                    .frame(width: 30)
                }//HStack
                .frame(height: 50)
                ScrollView{
                  VStack{
                    HStack(spacing: 20){
                      VStack{
                        Image("screen1")
                          .resizable()
                          .frame(width: 150, height: 90, alignment: .center)
                          .cornerRadius(10)
                        Text("2022_08_21.mp3")
                          .foregroundColor(Color.black)
                      }
                      VStack{
                        Image("screen2")
                          .resizable()
                          .frame(width: 150, height: 90, alignment: .center)
                          .cornerRadius(10)
                        Text("2022_08_21.mp3").foregroundColor(Color.black)
                      }
                      VStack{
                        Image("screen1")
                          .resizable()
                          .frame(width: 150, height: 90, alignment: .center)
                          .cornerRadius(10)
                        Text("2022_08_21.mp3").foregroundColor(Color.black)
                      }
                    }
                    HStack(spacing: 20){
                      VStack{
                        Image("screen2")
                          .resizable()
                          .frame(width: 150, height: 90, alignment: .center)
                          .cornerRadius(10)
                        Text("2022_08_21.mp3").foregroundColor(Color.black)
                      }
                      VStack{
                        Image("screen1")
                          .resizable()
                          .frame(width: 150, height: 90, alignment: .center)
                          .cornerRadius(10)
                        Text("2022_08_21.mp3").foregroundColor(Color.black)
                      }
                      VStack{
                        Image("screen2")
                          .resizable()
                          .frame(width: 150, height: 90, alignment: .center)
                          .cornerRadius(10)
                        Text("2022_08_21.mp3").foregroundColor(Color.black)
                      }
                    }//HStack
                  }//VStack
                }
              }
            }
            
            
          }
      }
      
    }
    
    
    
    
  }
  
}

struct EditView_Previews: PreviewProvider {
  static var previews: some View {
    EditView()
      .previewInterfaceOrientation(.landscapeLeft)
    
  }
  
}
