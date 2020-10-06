//
//  SummaryText.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 10/6/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

struct SummaryText: View {
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
