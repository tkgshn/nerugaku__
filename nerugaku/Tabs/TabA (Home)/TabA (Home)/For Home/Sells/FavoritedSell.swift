//
//  FavoritedSell.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/25/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

// MARK: - FavoritedSell
struct FavoritedSell: View {
    var body: some View {
        NavigationLink(destination: FavoritedList()) {
            HStack {
                ZStack {
                    Rectangle()
                        .fill(Color(UIColor.systemGray5))
                        .frame(width: 60.0, height: 60.0)
                    Image(systemName: "heart")
                    .font(.system(size: 30.0, weight: .thin))
                    .foregroundColor(Color.red)
                
                }
                Text("お気に入り")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                    .padding(.leading, 10.0)
                Spacer()
            }
            .frame(width: 170, height: 60)
            .background(Color(UIColor.systemGray6))
        }
    }
}

// MARK: - FavoritedObjectLinkPreView
struct FavoritedSell_Previews: PreviewProvider {
    static var previews: some View {
        FavoritedSell()
            .previewLayout(.sizeThatFits)
            .environmentObject(UserData())
    }
}
