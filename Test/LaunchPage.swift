//
//  LaunchPage.swift
//  Test
//
//  Created by Padma Priya on 3/24/21.
//

import SwiftUI

struct LaunchPage: View {
    @Binding var isLaunchPageShown: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
            Image("JobSearch")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .transition(.scale)
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isLaunchPageShown = false
                    }
                })
            }
        }
    }
}
