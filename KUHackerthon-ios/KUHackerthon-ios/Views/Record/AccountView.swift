//
//  AccountView.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import SwiftUI
import AVFoundation
import AVKit
import Refresher

struct AccountView: View {
  @StateObject var vm = SourcesViewModel()
  @State var selected: [Int] = []
  @State var audioPlayer: AVAudioPlayer!
  @State var song1 = false
  @StateObject private var soundManager = SoundManager()
  @State var showAlert = false
  @State var refreshed = 0
  
  
  var body: some View {
    VStack{
      Spacer()
        .frame(height: 60)
      HStack{
        Spacer()
        Image(systemName: "metronome")
          .resizable()
          .frame(width: 30, height: 30, alignment: .bottom)
          .onTapGesture {
            // EditViewModel
            showAlert = true
          }
          .alert(isPresented: $showAlert) {
            Alert(title: Text("Mixing"), message: Text("총 \(selected.count)개의 소스를 믹싱하시겠습니까?"),     primaryButton: .cancel(Text("취소"), action: {
              
            }),
                  secondaryButton: .default(Text("네"), action: {
              vm.postEdit(ids: selected, filename: "New File")
              selected.removeAll()
            }))
            
          }
        Spacer()
      }
      ScrollView{
        ForEach(Array(zip(vm.sources.indices, vm.sources)), id: \.0){ index, element in
          HStack{
            HStack{
              Button {
                soundManager.playSound(sound: "\(vm.sources[index].link ?? "")")
                
                if song1 == false{
                  soundManager.audioPlayer?.play()
                  song1 = true
                }else{
                  soundManager.audioPlayer?.pause()
                  song1 = false
                }
              
                print(vm.sources[index].link ?? "")
                
              } label: {
                HStack{
                  Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(hex: "eaeaea"))
                }
              }
              Spacer()
              Text("\(vm.sources[index].title ?? "")")
              Spacer()
              Button {
                print("\(index)가 선택되었습니다")
                selected.append(vm.sources[index].id)
              } label: {
                Image(systemName: "checkmark.square")
                  .resizable()
                  .frame(width: 30, height: 30)
                  .foregroundColor(containArr(n: vm.sources[index].id) ? Color(hex: "43cad9") : Color(hex: "eaeaea"))
              }
              
            }//HStack
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
          }//HStack
          .frame(height: 80)
        }
      }//ScrollView
      .refresher(refreshView: EmojiRefreshView.init) { done in // Called when pulled to refresh
        vm.getSources()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
          refreshed += 1
          done() // Stops the refresh view (can be called on a background thread)
        }
      }
      .background(Color(hex: "262626"))
      Spacer()
        .frame(height: 110)
    }.background(Color(hex: "262626"))
    
  }
  
  func containArr(n: Int) -> Bool{
    if selected.contains(n){
      return true
    }else{
      return false
    }
  }
}

struct AccountView_Previews: PreviewProvider {
  static var previews: some View {
    AccountView()
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
extension String {
    func stringFromDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: now)
    }
}

public struct EmojiRefreshView: View {
  @Binding var state: RefresherState
  @State private var angle: Double = 0.0
  @State private var isAnimating = false
  
  var foreverAnimation: Animation {
    Animation.linear(duration: 1.0)
      .repeatForever(autoreverses: false)
  }
  
  public var body: some View {
    VStack {
      switch state.mode {
      case .notRefreshing:
        VStack{
          Text("🤪")
            .onAppear {
              isAnimating = false
            }
        }
        .frame(width: Screen.maxWidth)
        .background(Color(hex: "262626"))
        
      case .pulling:
        VStack{
          Text("😯")
            .rotationEffect(.degrees(360 * state.dragPosition))
        }
        .frame(width: Screen.maxWidth)
        .background(Color(hex: "262626"))
      case .refreshing:
        VStack{
          Text("😂")
            .rotationEffect(.degrees(self.isAnimating ? 360.0 : 0.0))
            .onAppear {
              withAnimation(foreverAnimation) {
                isAnimating = true
              }
            }
        }
        .frame(width: Screen.maxWidth)
        .background(Color(hex: "262626"))
      }
    }
    .scaleEffect(2)
  }
}
