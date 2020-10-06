//
//  SummaryWords.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 10/6/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

struct SummaryWords: View {
    var audioContent: AudioContent
    @Binding var isDictionaryShown: Bool
    var body: some View {
        ForEach(1..<self.audioContent.allpharase) { num in
            HStack {
                //                        ここからボタン
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("詳細")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(40)
                        .background(Color.green)
                        .font(.headline)
                        .mask(Circle()
                                .frame(width: 55.0, height: 55.0))
                        //                                    このボタンをタップで辞書の表示を管理するトグルをオンにする
                        .onTapGesture {
                            self.isDictionaryShown = true
                        }
                        .sheet(isPresented: self.$isDictionaryShown) {
                            //モーダル遷移した後に表示するビュー
                            SystemDictionary(word: self.audioContent.phrases[String(num)]!.english)
                            
                        }
                })
                .padding(.horizontal, -30.0)
                .buttonStyle(PlainButtonStyle())
                
                //                        ここはフレーズの文字
                
                VStack(alignment: .leading) {
                    Text(self.audioContent.phrases[String(num)]!.english)
                    
                    Text(self.audioContent.phrases[String(num)]!.japanese)
                }
                .padding(.leading, 20.0)
                //                        スペースを開けてチェックボックス
                Spacer()
                
                CheckboxField(
                    id: Gender.male.rawValue,
                    label: Gender.male.rawValue,
                    size: 20,
                    callback: checkboxSelected
                )
            }
            Divider()
        }
        .padding(.horizontal)
        
    }
    func checkboxSelected(id: String, isMarked: Bool) {
        print("\(id) is marked: \(isMarked)")
    }
}



struct SummaryWords_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuestionSummary(audioContent: audioContentData[0]).colorScheme(.light)
            QuestionSummary(audioContent: audioContentData[0]).colorScheme(.dark)
        }
    }
}
