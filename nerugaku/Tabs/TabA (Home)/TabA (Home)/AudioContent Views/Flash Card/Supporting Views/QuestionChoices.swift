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
    //        同じaudioContent内のJapaneseを選択肢として辞書にインポート
    //    var audioContent: AudioContent
    
    //  辞書を作成
    let Dic = [
        ["japanese": "私", "english": "I", "phraseAudioName"  : "人称"],
        ["japanese": "私とあなた", "english": "I and You", "phraseAudioName"  : "国と言語"],
        ["japanese": "私たち", "english": "both of us", "phraseAudioName"  : "人称"],
        ["japanese": "彼", "english": "he", "phraseAudioName"  : "国と言語"],
        ["japanese": "彼と彼女", "english": "he and she", "phraseAudioName"  : "人称"],
        ["japanese": "彼ら", "english": "they both", "phraseAudioName"  : "国と言語"],
    ]
    
    //    {
    //        // まずは辞書からjapaneseだけを抽出
    //        DicArry = Dic.map(){$0["japanese"]!} // この時点の中身 ["私", "私とあなた", "私たち", "彼", "彼と彼女", "彼ら"]
    //
    //        // DicArryをシャッフルする
    //        ShuffledDicArry = DicArry.shuffled() // シャッフルの位置は毎回変化するが、["彼ら", "私たち", "彼と彼女", "彼", "私とあなた", "私"]のようになる
    //
    //        // 3つだけ取得する
    //        // この際は辞書のindexが被っていないので、同じものが選択肢になることはない
    //
    //        //        print("①　\(ShuffledDicArry[0])")
    //        //        print("②　\(ShuffledDicArry[1])")
    //        //        print("③　\(ShuffledDicArry[2])")
    //    }
    
    
    var body: some View {
        //        要素の中からランダムに取得
        
        
        
        //        Text(ShuffledDicArry[0])
        
        
        //            Button("tap") {
        //                DicArry = self.Dic.map(){$0["japanese"]!}
        //                ShuffledDicArry = self.DicArry.shuffled()
        //            }
        //        ForEach (0..<6) { n in
        //            let japanese = [(phrases[n]["japanese"])!]
        //            let japaneseText = ("\(japanese.randomElement()!)")
        //
        //        }
        //        Text(choiceDic.map{$0["japanese"]!})
        Text("test")
            //        ForEach (0..<6) { n in
            //            Text(choiceDic[0]["japanese"]!)
            //        }
            //        上記の辞書の中から、ランダムで3つほど選択する
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
    var body: some View {
        VStack {
            
            BoxView(selectedBox: $selectedBox, color: .red, boxType: .red)
            BoxView(selectedBox: $selectedBox, color: .green, boxType: .green)
            BoxView(selectedBox: $selectedBox, color: .blue, boxType: .blue)
            
        }
    }
}



// MARK: - Preview
struct QuestionRootView_Previews2: PreviewProvider {
    static var previews: some View {
        QuestionRootView(audioContent: audioContentData[0])
        
    }
}
