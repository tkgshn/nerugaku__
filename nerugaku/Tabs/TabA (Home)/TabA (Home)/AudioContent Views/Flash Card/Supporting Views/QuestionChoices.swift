//
//  QuestionChoices.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/23/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

// MARK: - BoxView
//選択肢は同じid内のphrasesをランダムに取得したものにする
struct BoxView: View {
    @Binding var selectedBox: BoxType
    let color: Color
    let boxType: BoxType
    //    フレーズを選択肢として辞書に入れる
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
