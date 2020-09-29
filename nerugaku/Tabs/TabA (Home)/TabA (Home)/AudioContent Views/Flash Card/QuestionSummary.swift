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
//                    .renderingMode(.original)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                //                Text(label)
                //                    .font(Font.system(size: size))
                //                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.primary)
    }
}

enum Gender: String {
    case male
    case female
}

struct QuestionSummaryText: View {
    var audioContent: AudioContent
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("本日の学習結果")
                .foregroundColor(Color.gray)
                .padding(.bottom, 5.0)
            HStack(alignment: .bottom){
//                1日あたり（0時から24時の間）の学習単語数をカウント
                Text("12")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                Text("単語")
                    .font(.title)
            }
//            予めユーザーが設定した目標の単語数-自分が今日すでに暗記した数
            Text("本日の目標までn単語")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.vertical, 5.0)
                .padding(.horizontal)
                .background(Color.gray)
            HStack(alignment: .bottom) {
//                さっき解いた問題数、正当数ともいう
                Text("1")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                Text("/")
                    .font(.system(size: 55))
//                この問題が持っている全ての単語数
                Text(String(audioContent.allpharase))
                    .font(.system(size: 50))
                    .fontWeight(.regular)
            }
            Image("Airplane")
        }
        .padding(.top)
    }
}



//MARK:- Body
struct QuestionSummary: View {
    var audioContent: AudioContent
    @State var isShowSubViw = false
    @State var isDictionaryShown = false
    var body: some View {
        ZStack {
            if isShowSubViw {
                QuestionRootView(audioContent: audioContent)
            } else {
                
                ScrollView {
                    QuestionSummaryText(audioContent
                        : audioContent)
                        .padding(.vertical)
                    
                    HStack {
                        
                        //            学習履歴
                        Button(action: {
                            print("Share tapped!")
                        }) {
                            VStack {
                                Image(systemName: "chart.bar")
                                    .resizable()
                                    .frame(width: 27.0, height: 27.0)
                                    .foregroundColor(Color.primary)
                                Text("学習履歴")
                                    .font(.footnote)
                                    .foregroundColor(Color.primary)
                                    .padding(.top, -5.0)
                            }
                            .padding(.vertical, 10.0)
                            .padding(.horizontal, 6.0)
                            .foregroundColor(.gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.orange, lineWidth: 2)
                            )
                        }
                        Button(action: {
                            withAnimation() {
                                self.isShowSubViw.toggle()
                            }
                        }) {
                            VStack {
                                Text("単語の復習へ")
                                    .font(.system(size: 20))
                                    .fontWeight(.black)
                                    .foregroundColor(Color.white)
                            }
                            .padding(.vertical, 22.0)
                            .padding(.horizontal, 80.0)
                            .background(Color.orange)
                            .cornerRadius(5)
                            
                        }
                        
                    }
                    
                    ForEach(1..<audioContent.allpharase) { num in
                        Group {
                            HStack {
                                //                        ここからボタン
                                Button(action: {
                                })
                                {
                                    VStack{
                                        Text("詳細")
                                            //                                        Text(String("word"))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.white)
                                    }
                                    
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
                                }
                                
                                .padding(.horizontal, -30.0)
                                .buttonStyle(PlainButtonStyle())
                                //                        ここはフレーズの文字
                                
                                VStack(alignment: .leading) {
                                    Text(self.audioContent.phrases[String(num)]!.english)
                                    
                                    Text(self.audioContent.phrases[String(num)]!.japanese)
                                }
                                .padding(.leading, 20.0)
                                Spacer()
                                //                        スペースを開けてチェックボックス
                                CheckboxField(
                                    id: Gender.male.rawValue,
                                    label: Gender.male.rawValue,
                                    size: 20,
                                    callback: checkboxSelected
                                )
                                .padding(.trailing)
                            }
                            Divider()
                        }
                    }
                    .padding(.horizontal)
                    
                    
                }
                
            }
        }
    }
    
    func checkboxSelected(id: String, isMarked: Bool) {
        print("\(id) is marked: \(isMarked)")
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

