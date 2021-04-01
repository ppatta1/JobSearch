//
//  ContentView.swift
//  Test
//
//  Created by Padma Priya on 3/24/21.
//

import SwiftUI

struct ContentView: View {
    @State var isLaunchPageShown = true
    @State var showPermissionPopup = false
    @State var showSignUpPage = false
    
    var body: some View {
        if isLaunchPageShown {
            LaunchPage(isLaunchPageShown: $isLaunchPageShown).animation(.interactiveSpring())
        } else {
            SignUporLogInPage(showPermissionPopup: $showPermissionPopup, showSignUpPage: $showSignUpPage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
