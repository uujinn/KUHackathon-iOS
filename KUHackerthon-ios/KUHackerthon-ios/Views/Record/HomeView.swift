//
//  HomeView.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import SwiftUI
import AVFoundation
import AVKit

struct HomeView: View {
  var hashtags = ["독창적인", "감미로운", "여유로운", "신이나는", "흥미로운", "엉덩이들썩", "클래식", "잔잔한"]
  
  @StateObject var sourceVM = SourcesViewModel()
  @StateObject var voiceVM = VoiceViewModel()
  @State var audioPlayer: AVAudioPlayer!
  
  @State var song1 = false
  @StateObject private var soundManager = SoundManager()
  
  @State var width = (Screen.maxWidth - 50)/2
  @State var height = (Screen.maxWidth - 50)/2
  
  @GestureState var press = false
  @State var completed = false
  
  var body: some View {
    VStack(spacing: 0){
      VStack(spacing: 0){
        Spacer()
          .frame(height: 45)
        HStack{
          Image("Asset 1")
            .resizable()
            .frame(width: 150, height: 19, alignment: .center)
            .foregroundColor(Color(hex: "b2b2b2"))
          Spacer()
          Image(systemName: "paperplane")
            .resizable()
            .frame(width: 19, height: 19, alignment: .center)
            .foregroundColor(Color(hex: "b2b2b2"))
          Spacer()
            .frame(width: 30)
          Image(systemName: "bell")
            .resizable()
            .frame(width: 19, height: 19, alignment: .center)
            .foregroundColor(Color(hex: "b2b2b2"))
            .overlay{
              Circle()
                .frame(width: 8, height: 8, alignment: .center)
                .offset(x: 10, y: -15)
                .foregroundColor(Color.pink)
            }
          Spacer()
            .frame(width: 30)
          Image(systemName: "gearshape")
            .resizable()
            .frame(width: 19, height: 19, alignment: .center)
            .foregroundColor(Color(hex: "b2b2b2"))
        }//HStack NavigationView
        .padding(18)
        .background(Color(hex: "262626"))
      }
      ScrollView{
        VStack{
          HStack{
            Text("🔥 Weekly Hot")
              .bold()
              .foregroundColor(Color(hex:"eaeaea"))
              .font(.system(size: 30))
              .padding()
            Spacer()
          }//HStack
          ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 0){
              Spacer()
                .frame(width: 18)
              VStack{
                ForEach(1..<5, id: \.self){ num in
                  HStack{
                    Text("\(num)")
                      .foregroundColor(Color(hex: "acacac"))
                      .font(.system(size: 15))
                    Spacer()
                      .frame(width: 9)
                    Image("create 2")
                      .resizable()
                      .frame(width: 55, height: 55, alignment: .center)
                      .shadow(radius: 12)
                    Spacer()
                      .frame(width: 20)
                    VStack(alignment: .leading){
                      Text("Title")
                        .foregroundColor(Color(hex: "eaeaea"))
                      Spacer()
                        .frame(height: 1)
                      HStack{
                        Image(systemName: "heart")
                        Text("42,563")
                        Spacer()
                          .frame(width: 15)
                        Image(systemName: "shuffle")
                        Text("12,429")
                      }.foregroundColor(Color(hex: "acacac"))
                    }
                  }//HStack
                }
              }//VStack
              Spacer()
                .frame(width: 60)
              VStack{
                ForEach(5..<9, id: \.self){ num in
                  HStack{
                    Text("\(num)")
                      .foregroundColor(Color(hex: "acacac"))
                    Image("create 2")
                      .resizable()
                      .frame(width: 55, height: 55, alignment: .center)
                    Spacer()
                      .frame(width: 20)
                    VStack(alignment: .leading){
                      Text("Title")
                      Spacer()
                        .frame(height: 1)
                      HStack{
                        Image(systemName: "heart")
                        Text("42,563")
                        Image(systemName: "shuffle")
                        Text("12,429")
                      }.foregroundColor(Color(hex: "acacac"))
                    }.foregroundColor(Color(hex: "acacac"))
                  }//HStack
                }
              }//VStack
              Spacer()
                .frame(width: 18)
            }//HStack
          }//ScrollView
        }//VStack Weekly Hot
        Spacer()
          .frame(height: 50)
        VStack{
          HStack(alignment: .bottom){
            Spacer()
              .frame(width: 18)
            Text("#️⃣ Hashtag")
              .bold()
              .font(.system(size: 30))
            Spacer()
            Text("더보기")
              .font(.system(size: 15))
              .foregroundColor(Color(hex: "acacac"))
            Spacer()
              .frame(width: 18)
          }
          ScrollView(.horizontal, showsIndicators: false){
            HStack{
              Spacer()
                .frame(width: 18)
              ForEach(0..<8, id: \.self){ num in
                Text("# \(hashtags[num])")
                  .padding()
                  .background(.regularMaterial)
                  .cornerRadius(15)
              }
              Spacer()
                .frame(width: 18)
            }
          }// Hashtag
        }// VStack Hashtag
        Spacer()
          .frame(height: 50)
        VStack{
          HStack(alignment: .bottom){
            Spacer()
              .frame(width: 18)
            Text("🔎 Discover")
              .bold()
              .font(.system(size: 30))
            Spacer()
            Text("더보기")
              .font(.system(size: 15))
              .foregroundColor(Color(hex: "acacac"))
            Spacer()
              .frame(width: 18)
          }
          ScrollView(.vertical, showsIndicators: false){
            ForEach(0..<8, id: \.self){ num in
              HStack(spacing: 5){
                Rectangle()
                  .frame(width: (Screen.maxWidth - 50)/2, height: (Screen.maxWidth - 50)/2, alignment: .center)
                  .cornerRadius(15)
                  .overlay{
                    Image("a")
                      .resizable()
                      .cornerRadius(15)
                    HStack(spacing: 5){
                      Text("# 신나는")
                        .font(.system(size: 15))
                        .padding(3)
                        .frame(width: 70, height: 25, alignment: .center)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                      Text("# 힙합")
                        .font(.system(size: 15))
                        .padding(3)
                        .frame(width: 70, height: 25, alignment: .center)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                    }.offset(x: -5, y: -60)
                    VStack(alignment: .leading, spacing: 5){
                      HStack{
                        Image(systemName: "heart")
                        Text("42,563")
                      }
                      HStack{
                        Image(systemName: "shuffle")
                        Text("12,429")
                      }
                    }.offset(x: -35, y: 50)
                  }
                  .modifier(TapAndLongPressModifier(tapAction: { print("tap") },
                                                    longPressAction: { print("long") }))
                Rectangle()
                  .frame(width: (Screen.maxWidth - 50)/2, height: (Screen.maxWidth - 50)/2, alignment: .center)
                  .cornerRadius(15)
                  .overlay{
                    Image("b")
                      .resizable()
                      .cornerRadius(15)
                    HStack(spacing: 5){
                      Text("# 발라드")
                        .font(.system(size: 15))
                        .padding(3)
                        .frame(width: 65, height: 25, alignment: .center)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                      Text("# 잔잔한")
                        .font(.system(size: 15))
                        .padding(3)
                        .frame(width: 65, height: 25, alignment: .center)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                    }.offset(x: -10, y: -60)
                    VStack(alignment: .leading, spacing: 5){
                      HStack{
                        Image(systemName: "heart")
                        Text("42,563")
                      }
                      HStack{
                        Image(systemName: "shuffle")
                        Text("12,429")
                      }
                    }.offset(x: -35, y: 50)
                  }
                  .modifier(TapAndLongPressModifier(tapAction: { print("tap") },
                                                    longPressAction: { print("long") }))
              }
            }
          }// Hashtag
        }// VStack
        Spacer()
          .frame(height: 150)
      }//ScrollView
      .background(Color(hex: "262626"))
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

class SoundManager : ObservableObject {
  var audioPlayer: AVPlayer?
  
  func playSound(sound: String){
    if let url = URL(string: sound) {
      self.audioPlayer = AVPlayer(url: url)
    }
  }
}

struct TapAndLongPressModifier: ViewModifier {
  @State private var isLongPressing = false
  let tapAction: (()->())
  let longPressAction: (()->())
  func body(content: Content) -> some View {
    content
      .scaleEffect(isLongPressing ? 1.5 : 1.0)
      .onLongPressGesture(minimumDuration: 10.0, pressing: { (isPressing) in
        withAnimation {
          isLongPressing = isPressing
          print(isPressing)
        }
      }, perform: {
        longPressAction()
      })
      .simultaneousGesture(
        TapGesture()
          .onEnded { _ in
            tapAction()
          }
      )
  }
}
