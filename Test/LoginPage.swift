//
//  LoginPage.swift
//  Test
//
//  Created by Padma Priya on 4/19/21.
//

import SwiftUI

struct LoginPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLinkActive = false
    @State private var showInvalidDetailsView = false
    @State var userInfo: FetchedResults<UserInfo>.Element
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest (entity: UserInfo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserInfo.email, ascending: true)]) var users: FetchedResults<UserInfo>
    
    var body: some View {
        Form {
            Section() {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                if showInvalidDetailsView {
                    HStack {
                        Text("Invalid email or password").foregroundColor(.red)
                    }
                }
                NavigationLink(destination: HomePage(userInfo: $userInfo), isActive: $isLinkActive) {
                    Button(action: {
                    }) {
                        HStack {
                            Spacer()
                            Text("Proceed to Login")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .foregroundColor(.accentColor)
                    }.onTapGesture {
                        for user in users {
                            if user.email == self.email && user.password == self.password {
                                userInfo = user
                                isLinkActive = true
                                break
                            }
                        }
                        if isLinkActive == false {
                            self.showInvalidDetailsView = true
                        }
                    }
                }
            }
        }.navigationBarTitle(Text("Log in")).accentColor(colorScheme == .dark ? .blue : Color(red: 31/255, green: 39/255, blue: 123/255, opacity: 0.9))
    }
}
