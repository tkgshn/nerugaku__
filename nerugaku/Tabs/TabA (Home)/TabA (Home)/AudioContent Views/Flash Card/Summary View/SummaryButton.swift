//
//  SummaryButton.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 10/6/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

struct SummaryButton: View {
    @Binding var isShowSubView: Bool
    var body: some View {
        HStack {
            Button(action: {}) {
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
                    self.isShowSubView.toggle()
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
    }
}
