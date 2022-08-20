//
//  OtherView.swift
//  KUhackerthon-Sandbox
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

struct OtherView: View {
  @GestureState private var dragState = DragState.inactive
  @GestureState private var dragState2 = DragState.inactive
  @GestureState private var dragState3 = DragState.inactive
  @GestureState private var dragState4 = DragState.inactive
  @State private var position = CGSize.zero
  @State private var position2 = CGSize.zero
  @State private var position3 = CGSize.zero
  @State private var position4 = CGSize.zero
  
  var body: some View {
    ScrollView(.vertical){
      ScrollView(.horizontal){
        ForEach(0..<4, id: \.self){ num in
          if num == 0 {
            Image(systemName: "star.circle.fill")
              .font(.system(size: 120))
              .opacity(dragState.isPressing ? 0.5 : 1.0)
              .offset(x: position.width + dragState.translation.width, y: position.height)
              .animation(.easeInOut, value: dragState.translation)
              .foregroundColor(.green)
              .gesture(
                LongPressGesture(minimumDuration: 0.0)
                  .sequenced(before: DragGesture())
                  .updating($dragState, body: { (value, state, transaction) in
                    
                    switch value {
                    case .first(true):
                      state = .pressing
                    case .second(true, let drag):
                      state = .dragging(translation: drag?.translation ?? .zero)
                    default:
                      break
                    }
                    
                  })
                  .onEnded({ (value) in
                    
                    guard case .second(true, let drag?) = value else {
                      return
                    }
                    
                    //            self.position.height += drag.translation.height
                    self.position.width += drag.translation.width
                  })
              )
              .onChange(of: position) { value in
                print(value.width)
              }
          }else if num == 1{
            Image(systemName: "star.circle.fill")
              .font(.system(size: 120))
              .opacity(dragState2.isPressing ? 0.5 : 1.0)
              .offset(x: position2.width + dragState2.translation.width, y: position2.height)
              .animation(.easeInOut, value: dragState2.translation)
              .foregroundColor(.green)
              .gesture(
                LongPressGesture(minimumDuration: 0.0)
                  .sequenced(before: DragGesture())
                  .updating($dragState2, body: { (value, state, transaction) in
                    
                    switch value {
                    case .first(true):
                      state = .pressing
                    case .second(true, let drag):
                      state = .dragging(translation: drag?.translation ?? .zero)
                    default:
                      break
                    }
                    
                  })
                  .onEnded({ (value) in
                    
                    guard case .second(true, let drag?) = value else {
                      return
                    }
                    
                    //            self.position.height += drag.translation.height
                    self.position2.width += drag.translation.width
                  })
              )
          }
          else if num == 2{
            Image(systemName: "star.circle.fill")
              .font(.system(size: 120))
              .opacity(dragState3.isPressing ? 0.5 : 1.0)
              .offset(x: position3.width + dragState3.translation.width, y: position3.height)
              .animation(.easeInOut, value: dragState3.translation)
              .foregroundColor(.green)
              .gesture(
                LongPressGesture(minimumDuration: 0.0)
                  .sequenced(before: DragGesture())
                  .updating($dragState3, body: { (value, state, transaction) in
                    switch value {
                    case .first(true):
                      state = .pressing
                    case .second(true, let drag):
                      state = .dragging(translation: drag?.translation ?? .zero)
                    default:
                      break
                    }
                    
                  })
                  .onEnded({ (value) in
                    
                    guard case .second(true, let drag?) = value else {
                      return
                    }
                    
                    self.position3.width += drag.translation.width
                  })
              )
          }
          else if num == 3{
            Image(systemName: "star.circle.fill")
              .font(.system(size: 120))
              .opacity(dragState4.isPressing ? 0.5 : 1.0)
              .offset(x: position4.width + dragState4.translation.width, y: position4.height)
              .animation(.easeInOut, value: dragState4.translation)
              .foregroundColor(.green)
              .gesture(
                LongPressGesture(minimumDuration: 0.0)
                  .sequenced(before: DragGesture())
                  .updating($dragState4, body: { (value, state, transaction) in
                    
                    switch value {
                    case .first(true):
                      state = .pressing
                    case .second(true, let drag):
                      state = .dragging(translation: drag?.translation ?? .zero)
                    default:
                      break
                    }
                    
                  })
                  .onEnded({ (value) in
                    
                    guard case .second(true, let drag?) = value else {
                      return
                    }
                    
                    self.position4.width += drag.translation.width
                  })
              )
          }
          
        }
        //      Rectangle(){
        //        ForEach(0..<4, id: \.self){ num in
        //          Rectangle()
        //            .frame(width: 200)
        //            .foregroundColor(Color.yellow)
        //        }
        //      }
      }.frame(height: 500)
    }
    
  }
}

struct OtherView_Previews: PreviewProvider {
  static var previews: some View {
    OtherView()
      .previewInterfaceOrientation(.landscapeRight)
  }
}
