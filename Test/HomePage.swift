//
//  HomePage.swift
//  Test
//
//  Created by Padma Priya on 3/28/21.
//

import SwiftUI

struct HomePage: View {
    @State var isEditAllowed = true
    @Binding var userInfo: FetchedResults<UserInfo>.Element
    
    let persistenceContainer = PersistenceController.shared
    var body: some View {
        TabView {
            JobsListView(user: $userInfo)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

//            SavedJobsPage()
//                .tabItem {
//                    Label("Saved", systemImage: "heart")
//                }
            
            SignUpPage(shouldAllowEdit: $isEditAllowed, userInfo: $userInfo).environment(\.managedObjectContext, persistenceContainer.container.viewContext)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("JobSearch")
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(Color(red: 31/255, green: 39/255, blue: 123/255, opacity: 0.9))
    }
}

