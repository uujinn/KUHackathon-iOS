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
  @StateObject var sourceVM = SourcesViewModel()
  @StateObject var voiceVM = VoiceViewModel()
  @State var audioPlayer: AVAudioPlayer!
  
  @State var song1 = false
  @StateObject private var soundManager = SoundManager()
  
  var body: some View {
    VStack{
      ScrollView{
        VStack{
          ForEach(0..<10, id: \.self){ num in
            Rectangle()
              .frame(width: 200, height: 200)
              .foregroundColor(Color.white)
          }
        }
      }
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
