//
//  HomePage.swift
//  Test
//
//  Created by Padma Priya on 3/28/21.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        JobsListView()
//        TabView {
//            JobsListView()
//                .tabItem {
//                    Label("Home", systemImage: "house")
//                }
//
//            SavedJobsPage()
//                .tabItem {
//                    Label("Saved", systemImage: "heart")
//                }
//            ProfilePage()
//                .tabItem {
//                    Label("Profile", systemImage: "person")
//                }
//        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("JobSearch")
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(Color(red: 31/255, green: 39/255, blue: 123/255, opacity: 0.9))
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
