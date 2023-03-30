//
//  datdpicer.swift
//  CustomAlertInSwiftUI
//
//  Created by reborn on 2022/05/31.
//

import SwiftUI
import AVFoundation
import SwiftUI
import Combine
import Foundation

struct ttsview: View {
    //@state를 지우고 @ObervedObject로 바꿔줌
    var body: some View {
        VStack{
            
            Button(action: {
                
                @ObservedObject var myTimer = MyTimer()
            }) {Text("TTS")}
        }
    }
}

struct datepicer_Previews: PreviewProvider {
    static var previews: some View {
        ttsview()
    }
}

class TTS: NSObject, AVSpeechSynthesizerDelegate {
    let speech = AVSpeechSynthesizer()
    var voice: AVSpeechSynthesisVoice!
    var utterance: AVSpeechUtterance!
    
    override init() {
        super.init()
        speech.delegate = self
    }
    func setText(_ s: String) {
        utterance = AVSpeechUtterance(string: s)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        speakVoice()
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: .allowBluetooth)
    }
    
    func speakVoice() {
        speech.speak(utterance)
    }
}
class MyTimer: ObservableObject {
    var value: Int = 0
    
    init() {
                                              //간격        //반복되기때문에 true   //timer을 in 해준다.
       let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.value += 1
            print(self.value)
            if self.value == 5{
            }
           if self.value == 5 {
               timer.invalidate()
               TTS().setText("테스트")
           }
        }
    }
}
