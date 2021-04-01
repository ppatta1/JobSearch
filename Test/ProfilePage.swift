//
//  ProfilePage.swift
//  Test
//
//  Created by Padma Priya on 3/31/21.
//

import SwiftUI

struct ProfilePage: View {
    @State private var name: String = ""
    @State private var gender: Int = 0
    var genderOptions = ["Female", "Male", "Prefer not to say"]
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Full Name", text: $name)
                HStack {
                    Picker(selection: $gender, label: Text("Gender")) {
                        Text("Female").tag(0)
                        Text("Male").tag(1)
                        Text("Prefer not to say").tag(2)
                    }.pickerStyle(MenuPickerStyle())
                    Spacer()
                    Text(genderOptions[gender])
                }
            }
        }
    }
}

extension ProfilePage {
    enum Gender {
        case female
        case male
        case prefer_not_to_say
    }
}
struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
