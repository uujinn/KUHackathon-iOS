//
//  RecordView.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//

import SwiftUI
import Combine

class timerViewModel: ObservableObject{
  @Published var timerCount : Timer?
  @Published var countSec = 4
  
  func setTimer(num: Int){
    timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (value) in
      self.countSec -= 1
    })
  }
}

struct RecordView: View {
  
  @ObservedObject var timerVM = timerViewModel()
  @State var showTimer = false
  @State var control: Bool = false
  @State var timerText = ""
  
  var body: some View {
    Circle()
      .frame(width: 662, height: 662, alignment: .center)
      .offset(y: -Screen.maxHeight / 2.8)
      .overlay{
        VStack{
          if showTimer{
            Text("\(timerText)")
              .foregroundColor(Color(hex: "ceeff2"))
              .font(.system(size: 60))
              .bold()
              .onChange(of: timerVM.countSec) { newValue in
                timerText = String(timerVM.countSec)
                if newValue < 1{
                  showTimer = false
                }
              }
            Spacer()
          }
          else{
            Text("녹음 중 입니다")
              .font(.system(size: 35))
              .foregroundColor(Color(hex: "ceeff2"))
            Text("00:01")
              .font(.system(size: 20))
              .foregroundColor(Color(hex: "ceeff2"))
            // Lottie View
            WaveView(filename: "SoundWave")
              .offset(y: -200)
            HStack(spacing: 70){
              Button {
                print("저장")
                // 저장을 누르면 > 생김
                // 시간은 위로 올라감
              } label: {
                VStack{
                  Image("okbutton")
                  Text("저장")
                }
              }
              Button {
                print("취소")
              } label: {
                VStack{
                  Image("cancelbutton")
                  Text("취소")
                }
              }
            }//HStack
            .offset(y: -350)
            Spacer()
          }
          Spacer()
        }//VStack
        .onAppear{
          timerVM.setTimer(num: 4)
          showTimer = true
        }
        
      }
    
  }
}

struct RecordView_Previews: PreviewProvider {
  static var previews: some View {
    RecordView()
  }
}
