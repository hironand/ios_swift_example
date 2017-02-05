//
//  Speech.swift
//  SpeechSyntheExample
//
//  Created by hironand on 2017/01/26.
//  Copyright © 2017年 appirca. All rights reserved.
//

import AVFoundation

class Speech {
    
    func speek(word: String?){
        
        if let word = word {
            // これをやらないと音が出ない
            // AVSessionのカテゴリを変更
            let audioSession = AVAudioSession.sharedInstance()
            try! audioSession.setCategory(AVAudioSessionCategoryAmbient)
            
            let speaker = AVSpeechSynthesizer()
            let uttr = AVSpeechUtterance(string: word)
            uttr.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            speaker.speak(uttr)
            
            // これをやらないと音が出ない
            // AVSessionのカテゴリを変更
            try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try! audioSession.setActive(true)
        }
    }
    
}
