//
//  PlayView.swift
//  KUhackerthon-Sandbox
//
//  Created by 양유진 on 2022/08/20.
//

import SwiftUI
import AVFoundation
import AVKit

struct PlayView: View {
  
  var sounds = ["sample-12s", "sample-15s", "sample1"]
  
  @State var audioPlayer: AVAudioPlayer!
  @State var audioPlayer2: AVAudioPlayer!
  @State var audioPlayer3: AVAudioPlayer!
  @State var audioPlayers: [AVAudioPlayer] = []
  var body: some View {
    ZStack {
      VStack {
        Text("Play").font(.system(size: 45)).font(.largeTitle)
        HStack {
          Spacer()
          Button(action: {
            DispatchQueue.global(qos: .background).async {
              for audioPlayer in audioPlayers{
                audioPlayer.play()
              }
              
              DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
              }
            }
          }) {
            Image(systemName: "play.circle.fill").resizable()
              .frame(width: 50, height: 50)
              .aspectRatio(contentMode: .fit)
          }
          Spacer()
          Button(action: {
            for audioPlayer in audioPlayers{
              audioPlayer.pause()
            }
          }) {
            Image(systemName: "pause.circle.fill").resizable()
              .frame(width: 50, height: 50)
              .aspectRatio(contentMode: .fit)
          }
          Spacer()
        }
      }
    }
    .onAppear {
      for name in sounds{
        let sound = Bundle.main.path(forResource: name, ofType: "mp3")
        let audioplayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayers.append(audioplayer)
      }
      //      let sound = Bundle.main.path(forResource: "sample-12s", ofType: "mp3")
      //      audioPlayers.append(AVAudioPlayer())
      //      self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
      //      let sound2 = Bundle.main.path(forResource: "sample-15s", ofType: "mp3")
      //      self.audioPlayer2 = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2!))
      //      let sound3 = Bundle.main.path(forResource: "sample1", ofType: "mp3")
      //      self.audioPlayer3 = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound3!))
      //      print(self.audioPlayer.url)
      
    }
  }
}

//struct PlayView_Previews: PreviewProvider {
//  static var previews: some View {
//    PlayView()
//  }
//}
