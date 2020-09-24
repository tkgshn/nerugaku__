//
//  ListSecond.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/25/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI

//
//  List1.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/25/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI


struct ListSecond: View {
    @EnvironmentObject private var userData: UserData
    var body: some View {
        List {
            ForEach(audioContentData) { audioContent in
                
                NavigationLink(
                    destination: AudioContentDetail(audioContent: audioContent)
                ) {
                    AudioContentRow(audioContent: audioContent)
                }
                
            }
        }
        .environmentObject(UserData())
    }
}

struct ListSecond_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            NavigationView {
                ListSecond()
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
        .environmentObject(UserData())
    }
}


