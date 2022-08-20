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
  @State var vm = VoiceViewModel()
  @StateObject var audiouploadViewModel = AudioUploadViewModel()
  @ObservedObject var timerVM = timerViewModel()
  @State var showTimer = false
  @State var control: Bool = false
  @State var timerText = ""
  @State var pressedOK = false
  @State var isPause = false
  @State var mode = ""
  @State var presentAlert = false
  @State var count = 0
  @State private var title: String = ""
  @Binding var isShowing: Bool // 외부 View에서 녹음창 띄울 때 사용
  @ObservedObject var tabbarManager = TabBarManager.shared
  var body: some View {
    ZStack{
      VStack {
        Color.black
          .opacity(0)
      }
      .contentShape(Rectangle())
      .onTapGesture {
        self.isShowing = false
        tabbarManager.showTabBar = true
      }
      Circle()
        .foregroundColor(.white)
        .frame(width: 662, height: 662, alignment: .center)
        .offset(y: -Screen.maxHeight / 2.8)
        .overlay{
          VStack(spacing: 0){
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
                Text("\(vm.timer)")
                  .font(.system(size: 20))
                  .foregroundColor(Color(hex: "ceeff2"))
              }else{
                Text("\(vm.timer)")
                  .font(.system(size: 25))
                  .bold()
                  .foregroundColor(Color(hex: "ceeff2"))
                  .offset(y: -5)
                Image(isPause ? "5" : "4")
                  .resizable()
                  .frame(width: 42, height: 49, alignment: .center)
                  .onTapGesture {
                    // pause로 바뀜
                    print("isPause: \(isPause)")
                    if isPause {
                      self.isPause = false
                      vm.startPlaying(url: vm.urlToShare!)
                      print("startPlaying")
                      print(vm.audioRecorder.url)
                    }else{
                      self.isPause = true
                      vm.stopPlaying(url: vm.urlToShare!)
                      self.isPause = true
                      self.mode = ""
                      print("stopPlaying")
                    }
                    
                  }
                  .offset(y: -5)
              }
              // Lottie View
              ZStack{
                Image("13")
                  .offset(y: -190)
                  .opacity(isPause ? 1 : 0)
                WaveView(filename: "SoundWave", mode: $mode)
                  .opacity(isPause ? 0 : 1)
                  .offset(y: -185)
                  .onTapGesture {
                    // pause로 바뀜
                    print("isPause: \(isPause)")
                    if isPause {
                      self.isPause = false
                      self.mode = "loop"
                      vm.startPlaying(url: vm.urlToShare!)
                      print("startPlaying")
                      print(vm.audioRecorder.url)
                    }else{
                      vm.stopPlaying(url: vm.urlToShare!)
                      self.isPause = true
                      self.mode = ""
                      print("stopPlaying")
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
                    count += 1
                    vm.stopRecording()
                    print("stopRecording")
                  }
                  if count > 1{
                    presentAlert = true
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
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
              // 4초 후 실행될 부분
              vm.startRecording()
            }
            
          }
          .textFieldAlert(isPresented: $presentAlert, title: "곡 이름 설정", text: $title, placeholder: "Placeholder", action: { text in
            print(text)
            audiouploadViewModel.uploadfiles(audio: vm.audioRecorder.url, filename: "\(text)")
            print(vm.audioRecorder.url)
            self.isShowing = false
            tabbarManager.showTabBar = true
            tabbarManager.showRecord = false
          })
          .padding()
          
        }
        .edgesIgnoringSafeArea([.bottom])
    }
    
    
  }
}

//struct RecordView_Previews: PreviewProvider {
//  static var previews: some View {
//    RecordView()
//  }
//}

struct TextFieldAlert: ViewModifier {
  @Binding var isPresented: Bool
  let title: String
  @Binding var text: String
  let placeholder: String
  let action: (String) -> Void
  func body(content: Content) -> some View {
    ZStack(alignment: .center) {
      content
        .disabled(isPresented)
      if isPresented {
        VStack {
          Spacer()
            .frame(height: 10)
          Text(title).font(.headline).padding()
            .foregroundColor(.black)
          Text("곡의 이름을 설정해 주세요.")
            .foregroundColor(.black)
          TextField(placeholder, text: $text).textFieldStyle(.roundedBorder).padding()
          Divider()
          HStack{
            Spacer()
            Button(role: .cancel) {
              withAnimation {
                isPresented.toggle()
              }
            } label: {
              VStack{
                Spacer()
                  .frame(height: 5)
                Text("Cancel")
                  .padding()
                Spacer()
                  .frame(height: 25)
              }

            }
            Spacer()
            Divider()
            Spacer()
            Button() {
              action(text)
              withAnimation {
                isPresented.toggle()
              }
            } label: {
              VStack{
                Spacer()
                  .frame(height: 5)
                Text("Action")
                  .bold()
                Spacer()
                  .frame(height: 25)
              }
            }
            Spacer()
          }
          .frame(height: 40)
        }
        .background(Color(red: 242, green: 242, blue: 242)).opacity(0.7)
        .frame(width: 300, height: 200)
        .cornerRadius(20)
        .overlay {
          RoundedRectangle(cornerRadius: 20)
            .stroke(.quaternary, lineWidth: 1)
        }
        .offset(y: -80)
      }
    }
  }
}

extension View {
  public func textFieldAlert(
    isPresented: Binding<Bool>,
    title: String,
    text: Binding<String>,
    placeholder: String = "",
    action: @escaping (String) -> Void
  ) -> some View {
    self.modifier(TextFieldAlert(isPresented: isPresented, title: title, text: text, placeholder: placeholder, action: action))
  }
}
