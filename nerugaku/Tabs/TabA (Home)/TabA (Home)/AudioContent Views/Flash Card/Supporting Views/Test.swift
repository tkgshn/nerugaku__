//
//  Test.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/30/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

struct Test: View {
    var audioContent: AudioContent
//    let phrases = [
//        ["japanese": "私", "english": "I", "phraseAudioName"  : "人称"],
//        ["japanese": "私とあなた", "english": "I and You", "phraseAudioName"  : "国と言語"],
//        ["japanese": "私たち", "english": "both of us", "phraseAudioName"  : "人称"],
//        ["japanese": "彼", "english": "he", "phraseAudioName"  : "国と言語"],
//        ["japanese": "彼と彼女", "english": "he and she", "phraseAudioName"  : "人称"],
//        ["japanese": "彼ら", "english": "they both", "phraseAudioName"  : "国と言語"],
//    ]
    
    var body: some View {
        List {
//            0から全部のコンテンツがある回数だけぶん回す
//            ForEach(0..<phrases.count) { n in
////                [取得したい行数][取得したいキー]を指定
//                Text(phrases[n]["japanese"]!)
//                Text(phrases[n]["english"]!)
//            }
//            Text(audioContent.phrases[0]["english"])
            Text(self.audioContent.phrases[String(0)]!.english)
//            Text(audioContent.phrases[currentQuestionIndex]["english"]!)
        }
    }
}



struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test(audioContent: audioContentData[0])
    }
}





