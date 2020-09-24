//
//  CategoryList.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/25/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

struct CategoryList: View {
    var categoryName: String
    var items: [AudioContent]
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        //        縦方向
        List {
            ForEach(self.items) { audioContent in
                //                        それをクリックできるようにする
                NavigationLink(
                    destination: AudioContentDetail(
                        audioContent: audioContent
                    )
                ) {
                    AudioContentRow(audioContent: audioContent)
                    
                }
            }
        }
        .navigationBarTitle(Text(self.categoryName))
    }
}
