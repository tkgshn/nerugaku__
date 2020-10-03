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
    
    var body: some View {
        // currentQuestionIndexがもともと1から始まっているので、ここで引いてあげなきゃいけない
        Text(getJapaneseQuestion(currentQuestionIndex-1)) // これで絶対答えのが表示されてるようになる？
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
struct BoxView2: View {
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
    
    
    // 数字でDicのリスト番号を指定して、その中のjapaneseを吐き出す関数
    func getJapaneseQuestion(_ index: Int) -> String {
        let japaneseWord = Dic[index]["japanese"]!
        return japaneseWord
    }
    
    var body: some View {
        // currentQuestionIndexがもともと1から始まっているので、ここで引いてあげなきゃいけない
        Text(getJapaneseQuestion(currentQuestionIndex)) // これで絶対答えのが表示されてるようになる？
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
struct BoxView3: View {
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
    
    
    // 数字でDicのリスト番号を指定して、その中のjapaneseを吐き出す関数
    func getJapaneseQuestion(_ index: Int) -> String {
        let japaneseWord = Dic[index]["japanese"]!
        return japaneseWord
    }
    
    var body: some View {
        // currentQuestionIndexがもともと1から始まっているので、ここで引いてあげなきゃいけない
        Text(getJapaneseQuestion(currentQuestionIndex+1)) // これで絶対答えのが表示されてるようになる？
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


// MARK: - SingleSelectableBoxView
struct SingleSelectableBoxView: View {
    @Binding var selectedBox: BoxType
    @Binding var currentQuestionIndex: Int
    
    var body: some View {
        VStack {
            
            BoxView(selectedBox: $selectedBox, color: .red, boxType: .red, currentQuestionIndex: $currentQuestionIndex)
            BoxView2(selectedBox: $selectedBox, color: .green, boxType: .green, currentQuestionIndex: $currentQuestionIndex)
            BoxView3(selectedBox: $selectedBox, color: .blue, boxType: .blue, currentQuestionIndex: $currentQuestionIndex)
            
        }
    }
    
}



// MARK: - Preview
struct QuestionRootView_Previews2: PreviewProvider {
    static var previews: some View {
        QuestionRootView(audioContent: audioContentData[0])

    }
}
