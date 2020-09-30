//
//  QuestionChoices.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/23/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

// MARK: - 回答の選択肢を生成
//表示中の単語を除く同じシーンの中からランダムで4つ表示（これが選択肢になる）（日本語を表示）
//struct ChoiceGeneration: View {
//    var audioContent: AudioContent
//
//    func addDic() {
//        var dic = ForEach(1..<audioContent.allpharase+1) { num in
//            self.audioContent.phrases[String(num)]!.japanese
//        }
//    }
//
//    var body: some View {
//        VStack {
//
//            Text(audioContent.)
//        }
//    }
//}
//
//struct QuestionChoices_Previews: PreviewProvider {
//    static var previews: some View {
//        ChoiceGeneration(audioContent: audioContentData[0])
//            .previewLayout(.sizeThatFits)
//    }
//}


// MARK: - BoxView
//選択肢は同じid内のphrasesをランダムに取得したものにする
struct BoxView: View {
    @Binding var selectedBox: BoxType
    let color: Color
    let boxType: BoxType
    //    フレーズを選択肢として辞書に入れる
//        同じaudioContent内のJapaneseを選択肢として辞書にインポート
//    var audioContent: AudioContent
    
    let choiceDic = ["example text A", "example text B", "example text c", "TestD"]
    var body: some View {
        //        要素の中からランダムに取得
        Text(choiceDic.randomElement()!)
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

