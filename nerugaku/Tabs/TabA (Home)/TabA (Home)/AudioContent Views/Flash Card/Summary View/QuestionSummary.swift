//
//  QuestionSummary.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/23/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

//MARK:- Checkbox Field
struct CheckboxField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: Int
    let callback: (String, Bool)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 10,
        color: Color = Color.black,
        textSize: Int = 14,
        callback: @escaping (String, Bool)->()
    ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.callback = callback
    }
    
    @State var isMarked:Bool = false
    
    var body: some View {
        Button(action:{
            self.isMarked.toggle()
            self.callback(self.id, self.isMarked)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "checkmark.square" : "square")
                    .foregroundColor(Color.primary)
                    //                                        .renderingMode(.original)
                    //                                        .resizable()
                    //                                        .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
//                Text(label)
//                    .font(Font.system(size: size))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.primary)
    }
}

enum Gender: String {
    case male
    case female
}




//MARK:- Body
struct QuestionSummary: View {
    var audioContent: AudioContent
    @State var isShowSubView = false
    @State var isDictionaryShown = false
    var body: some View {
        //        Text("hoge")
        ZStack {
            if isShowSubView {
                //                単語の復讐へをクリックすると表示されるview
                Text("showing sub view")
                //        QuestionRootView(audioContent: audioContent, getChoicesNumber: getChoicesNumber)
            } else {
                //                それ以外の場合の処理
                ScrollView {
                    //  文字の表示
                    SummaryText(audioContent: audioContent)
                        .padding(.vertical)
                    
                    // ボタン
                    SummaryButton(isShowSubView: $isShowSubView)
                    
                    SummaryWords(audioContent: audioContent, isDictionaryShown: $isDictionaryShown)
                    
                }
            }
        }
    }
}





struct QuestionSummary_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuestionSummary(audioContent: audioContentData[0]).colorScheme(.light)
            QuestionSummary(audioContent: audioContentData[0]).colorScheme(.dark)
        }
    }
}




