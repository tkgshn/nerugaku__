//
//  QuestionChoices.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/23/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

// MARK: - 回答の選択肢を生成

// MARK: - BoxView
//選択肢は同じid内のphrasesをランダムに取得したものにする
struct BoxView: View {
    @Binding var selectedBox: BoxType
    let color: Color
    let boxType: BoxType
    
    //    現在表示している問題を共通化する
    @Binding var currentQuestionIndex: Int
    
    //  辞書を作成
    let Dic = [
        ["japanese": "私", "english": "I", "phraseAudioName"  : "人称"],
        ["japanese": "私とあなた", "english": "I and You", "phraseAudioName"  : "国と言語"],
        ["japanese": "私たち", "english": "both of us", "phraseAudioName"  : "人称"],
        ["japanese": "彼", "english": "he", "phraseAudioName"  : "国と言語"],
        ["japanese": "彼と彼女", "english": "he and she", "phraseAudioName"  : "人称"],
        ["japanese": "彼ら", "english": "they both", "phraseAudioName"  : "国と言語"],
    ]
    
    
    //    // 数字でDicの番号を指定して、その中のenglishを吐き出す関数
    //    func getQuestion(_ index: Int) -> String {
    //        let question = Dic[index]["english"]!
    //        return question
    //    }
    
    // 数字でDicのリスト番号を指定して、その中のjapaneseを吐き出す関数
    func getJapaneseQuestion(_ index: Int) -> String {
        let japaneseWord = Dic[index]["japanese"]!
        return japaneseWord
    }
    
    var body: some View {
        
        Text(getJapaneseQuestion(currentQuestionIndex-1)) // これで絶対答えのが表示されてるようになる？
            .font(.headline)
            .padding()
            .background(color)
            .cornerRadius(10)
            .onTapGesture {
                self.selectedBox = self.boxType
            }
            .padding()
            .border(Color.black, width: selectedBox == boxType ? 4 : 0)
    }
}







enum BoxType: String {
    case unknown
    case red
    case green
    case blue
}

final class SingleSelectableBoxViewModel: ObservableObject {
    @Published var selectedBox: BoxType = .unknown
    var cancels: [Any] = []
    
    init() {
        let selected = $selectedBox.sink { (box) in
            print("selected box is \(box.rawValue)")
        }
        cancels.append(selected)
    }
}


// MARK: - SingleSelectableBoxView
struct SingleSelectableBoxView: View {
    @Binding var selectedBox: BoxType
    @Binding var currentQuestionIndex: Int
    
    var body: some View {
        VStack {
            
            BoxView(selectedBox: $selectedBox, color: .red, boxType: .red, currentQuestionIndex: $currentQuestionIndex)
            BoxView(selectedBox: $selectedBox, color: .green, boxType: .green, currentQuestionIndex: $currentQuestionIndex)
            BoxView(selectedBox: $selectedBox, color: .blue, boxType: .blue, currentQuestionIndex: $currentQuestionIndex)
            
        }
    }
}



// MARK: - Preview
struct QuestionRootView_Previews2: PreviewProvider {
    static var previews: some View {
        QuestionRootView(audioContent: audioContentData[0])
        
    }
}
