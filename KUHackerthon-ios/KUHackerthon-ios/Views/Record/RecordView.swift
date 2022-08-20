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
  @State var pressedOK = false
  @State var isPause = true
  @State var mode = ""
  
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
            if pressedOK == false{
              Text("녹음 중 입니다")
                .font(.system(size: 35))
                .foregroundColor(Color(hex: "43cad9"))
                .bold()
              Text("00:01")
                .font(.system(size: 20))
                .foregroundColor(Color(hex: "ceeff2"))
            }else{
              Text("00:01")
                .font(.system(size: 25))
                .bold()
                .foregroundColor(Color(hex: "ceeff2"))
              Image(isPause ? "5" : "4")
                .resizable()
                .frame(width: 42, height: 49, alignment: .center)
                .onTapGesture {
                  // pause로 바뀜
                  print("isPause: \(isPause)")
                  if isPause {
                    self.isPause = false
                  }else{
                    self.isPause = true
                  }
                  
                }
            }
            // Lottie View
            ZStack{
              Image("13")
                .offset(y: -200)
                .opacity(isPause ? 0 : 1)
              WaveView(filename: "SoundWave", mode: $mode)
                .opacity(isPause ? 1 : 0)
                .offset(y: -185)
                .onTapGesture {
                  // pause로 바뀜
                  print("isPause: \(isPause)")
                  if isPause {
                    self.isPause = false
                    self.mode = "loop"
                  }else{
                    self.isPause = true
                    self.mode = ""
                  }
                  
                }
            }
            HStack(spacing: 70){
              Button {
                print("저장")
                // 저장을 누르면 > 생김
                // 시간은 위로 올라감
                withAnimation {
                  pressedOK = true
                  isPause = true
                }
              } label: {
                VStack{
                  Image("okbutton")
                  Text("저장")
                    .font(.system(size: 25))
                    .bold()
                    .foregroundColor(Color(hex: "43cad9"))
                }
              }
              if pressedOK{
                
              }else{
                Button {
                  print("취소")
                  // 위로 다시 올라감
                } label: {
                  VStack{
                    Image("cancelbutton")
                    Text("취소")
                      .font(.system(size: 25))
                      .bold()
                      .foregroundColor(Color(hex: "ceeff2"))
                  }
                }
              }
            }//HStack
            .offset(y: -350)
            Spacer()
          }
          Spacer()
        }//VStack
        .onAppear{
          showTimer = true
          timerVM.setTimer(num: 4)
          
        }
        
      }
    
  }
}

struct RecordView_Previews: PreviewProvider {
  static var previews: some View {
    RecordView()
  }
}
