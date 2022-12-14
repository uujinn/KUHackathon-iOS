//
//  WaveView.swift
//  KUHackerthon-ios
//
//  Created by 양유진 on 2022/08/20.
//


import SwiftUI
import Lottie

// Lottie File Frame 관리
enum ProgressKeyFrames: CGFloat {
  case start = 0
  case end = 39
}

struct WaveView: UIViewRepresentable {
  
  typealias UIViewType = UIView
  let animationView = AnimationView()
  var filename: String
  @Binding var mode: String
  
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: .zero)
  
    //4. Add animation
    //사용자 애니메이션 파일명
    animationView.animation = Animation.named(filename)
    //애니메이션 크기가 적절하게 조정될 수 있도록
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = .loop
    //애니메이션 재생
    animationView.play(fromFrame: ProgressKeyFrames.start.rawValue, toFrame: ProgressKeyFrames.end.rawValue, loopMode: .none)
    
    //컨테이너의 너비와 높이를 자동으로 지정할 수 있도록
    animationView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(animationView)
    
    //5. 자동완성 기능
    NSLayoutConstraint.activate([
        //레이아웃의 높이와 넓이의 제약
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
    
    
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
    if mode == "loop"{
      animationView.pause()
      animationView.stop()
    }else{
      animationView.play()
      animationView.loopMode = .loop
    }
    
  }
  

}

