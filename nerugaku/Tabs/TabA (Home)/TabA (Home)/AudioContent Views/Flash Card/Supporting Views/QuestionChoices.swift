//
//  QuestionChoices.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/23/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

// ユーザーが何を選択したのかがわかるように、BoxのTypeを定義する
enum BoxType: String {
    case unknown
    case red
    case green
    case blue
}

// 選択状態をハンドリングできるようにSingleSelectableBoxViewModelというViewModelを定義
//selectedBoxというプロパティを定義しています。@PublishedのProperty Wrapperをつけているので、値が更新されると自動的にSwiftUIにも通知されViewが更新されます。
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

// MARK: - BoxView
//選択肢は同じid内のphrasesをランダムに取得したものにする
struct BoxView: View {
    @Binding var selectedBox: BoxType
    let color: Color
    let boxType: BoxType
    
    //    現在表示している問題を共通化する
    @Binding var currentQuestionIndex: Int
    @Binding var getChoicesNumber: Int
    //  辞書を作成
    let Dic = [
        ["japanese": "私", "english": "I", "phraseAudioName"  : "人称"],
        ["japanese": "私とあなた", "english": "I and You", "phraseAudioName"  : "国と言語"],
        ["japanese": "私たち", "english": "both of us", "phraseAudioName"  : "人称"],
        ["japanese": "彼", "english": "he", "phraseAudioName"  : "国と言語"],
        ["japanese": "彼と彼女", "english": "he and she", "phraseAudioName"  : "人称"],
        ["japanese": "彼ら", "english": "they both", "phraseAudioName"  : "国と言語"],
    ]
    
    
    // 数字でDicのリスト番号を指定して、その中のjapaneseを吐き出す関数
    func getJapaneseQuestion(_ index: Int) -> String {
        let japaneseWord = Dic[index]["japanese"]!
        return japaneseWord
    }
    
    func getChoices(_ n: Int) -> String {
        let DicCount: Int = Dic.count //辞書の中の全部の数を数える
        let onlyJapanese = Dic.map{$0["japanese"]!}
        
        let questionList = 0..<DicCount
        let randomQuestionList = questionList.shuffled()
        
        let answer = getJapaneseQuestion(randomQuestionList[0]) // これは答えにしておく
        
        let Choices = onlyJapanese.filter { $0 != answer} // 全ての選択肢
        let shuffleChoices = Choices.shuffled() // 選択肢をシャッフル
        
        let showCoices = [answer, shuffleChoices[0], shuffleChoices[1]].shuffled()
        let result = showCoices[n]
        return result
    }
    
    var body: some View {
        // currentQuestionIndexがもともと1から始まっているので、ここで引いてあげなきゃいけない
//        Text(getJapaneseQuestion(currentQuestionIndex-1)) //これで絶対答えのが表示されてるようになる？
        
        Text(getChoices(getChoicesNumber))
        
            .font(.headline)
            .padding()
            .background(color)
            .cornerRadius(10)
            //        onTapGestureでタップしたらviewModelのselectedBoxに.redを代入し、赤いViewが選択されたことを表現
            .onTapGesture {
                self.selectedBox = self.boxType
            }
            .padding()
            //        selectedBoxがredだったら枠線を表示
            .border(Color.black, width: selectedBox == boxType ? 4 : 0)
    }
}

//extension Binding where Value == Int {
//    func IntToStrDef(_ def: Int) -> Binding<String> {
//        return Binding<String>(get: {
//            return String(self.wrappedValue)
//        }) { value in
//            self.wrappedValue = Int(value) ?? def
//        }
//    }
//}


// MARK: - SingleSelectableBoxView
struct SingleSelectableBoxView: View {
    @Binding var selectedBox: BoxType
    @Binding var currentQuestionIndex: Int
    @Binding var getChoicesNumber: Int
    
    
    var body: some View {
        VStack {
            
            BoxView(selectedBox: $selectedBox, color: .red, boxType: .red, currentQuestionIndex: $currentQuestionIndex, getChoicesNumber: self.$getChoicesNumber)
            BoxView(selectedBox: $selectedBox, color: .green, boxType: .green, currentQuestionIndex: $currentQuestionIndex, getChoicesNumber: self.$getChoicesNumber)
            BoxView(selectedBox: $selectedBox, color: .blue, boxType: .blue, currentQuestionIndex: $currentQuestionIndex, getChoicesNumber: self.$getChoicesNumber)
            
        }
    }
    
}


