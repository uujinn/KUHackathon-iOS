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
  var hashtags = ["독창적인", "감미로운", ""]
  
  @StateObject var sourceVM = SourcesViewModel()
  @StateObject var voiceVM = VoiceViewModel()
  @State var audioPlayer: AVAudioPlayer!
  
  @State var song1 = false
  @StateObject private var soundManager = SoundManager()
  
  var body: some View {
    VStack(spacing: 0){
      VStack(spacing: 0){
        Spacer()
          .frame(height: 45)
        HStack{
          Image("Asset 1")
            .resizable()
            .frame(width: 150, height: 19, alignment: .center)
          Spacer()
          Image(systemName: "paperplane")
            .resizable()
            .frame(width: 19, height: 19, alignment: .center)
          Spacer()
            .frame(width: 35)
          Image(systemName: "bell")
            .resizable()
            .frame(width: 19, height: 19, alignment: .center)
            .overlay{
              Circle()
                .frame(width: 8, height: 8, alignment: .center)
                .offset(x: 10, y: -15)
                .foregroundColor(Color.pink)
            }
          Spacer()
            .frame(width: 35)
          Image(systemName: "gearshape")
            .resizable()
            .frame(width: 19, height: 19, alignment: .center)
        }//HStack NavigationView
        .padding(18)
        .background(Color(hex: "262626"))
      }
      ScrollView{
        VStack{
          HStack{
            Text("🔥Weekly Hot")
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
                      }
                    }
                  }//HStack
                }
              }//VStack
              Spacer()
                .frame(width: 60)
              VStack{
                ForEach(1..<5, id: \.self){ num in
                  HStack{
                    Text("\(num)")
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
                      }
                    }
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
            Text("#️⃣Hashtag")
              .bold()
              .font(.system(size: 30))
            Spacer()
            Text("더보기")
              .font(.system(size: 15))
            Spacer()
              .frame(width: 18)
          }
          ScrollView(.horizontal){
            ForEach(0..<8, id: \.self){ num in
              
            }
            HStack{
              Text("# 독창적인")
                .padding()
            }
            .background(.regularMaterial)
            .cornerRadius(4)
          }
        }
      }//VStack
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
