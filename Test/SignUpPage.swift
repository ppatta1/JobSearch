//
//  StartPage.swift
//  Test
//
//  Created by Padma Priya on 3/28/21.
//

import SwiftUI

struct SignUpPage: View {
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var name: String = ""
    @State private var gender: Int = 0
    @State private var dob = Date()
    @State private var contactNumber = ""
    @State private var skill1 = ""
    @State private var skill1Rating: Double = 0
    @State private var skill2 = ""
    @State private var skill2Rating: Double = 0
    @State private var skill3 = ""
    @State private var skill3Rating: Double = 0
    @State private var typeOfJob: JobCardModel.TypeOfJob = .none
    @State private var datePickerShown: Bool = false
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
    var disableForm: Bool {
        email.isEmpty || password.isEmpty
    }
    var genderOptions = ["Female", "Male", "Prefer not to say"]
    var body: some View {
        Form {
            Section(header: Text("Account Information")) {
                TextField("Firstname", text: $firstname)
                TextField("Lastname", text: $lastname)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
            }
            
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
                HStack {
                    Text("Date of Birth")
                    Spacer()
                    Text("\(dob, formatter: dateFormatter)").foregroundColor(.accentColor)
                }.onTapGesture {
                    datePickerShown.toggle()
                }
                if datePickerShown {
                    DatePicker("", selection: $dob, displayedComponents: [.date])
                        .datePickerStyle(WheelDatePickerStyle())
                }
                TextField("Contact", text: $contactNumber)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Technical Skills")) {
                VStack {
                    HStack {
                        TextField("Skill1", text: $skill1)
                        Spacer()
                        Slider(value: $skill1Rating, in: 0...5, step: 1)
                        Text("\(Int(skill1Rating))")
                    }
                    HStack {
                        TextField("Skill2", text: $skill2)
                        Spacer()
                        Slider(value: $skill2Rating, in: 0...5, step: 1)
                        Text("\(Int(skill2Rating))")
                    }
                    HStack {
                        TextField("Skill3", text: $skill3)
                        Spacer()
                        Slider(value: $skill3Rating, in: 0...5, step: 1)
                        Text("\(Int(skill3Rating))")
                    }
                }
            }
            
            Section(header: Text("Job Preferences")) {
                VStack {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 7.5)
                                .trim(from: 0, to: 1)
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .frame(width: 15, height: 15)
                                .foregroundColor(typeOfJob == .partTime ? .accentColor : Color.gray.opacity(0.2))
                            
                            RoundedRectangle(cornerRadius: 7.5)
                                .trim(from: 0, to: 1)
                                .foregroundColor(typeOfJob == .partTime ? .accentColor : Color.gray.opacity(0.2))
                                .frame(width: 15, height: 15)
                            if typeOfJob == .partTime {
                                Image(systemName: "checkmark")
                                    .resizable().frame(width: 10, height: 10)
                                    .foregroundColor(.white)
                            }
                        }.onTapGesture {
                            if typeOfJob == .partTime {
                                typeOfJob = .none
                            } else {
                                typeOfJob = .partTime
                            }
                        }
                        Text("Part-time")
                    }
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 7.5)
                                .trim(from: 0, to: 1)
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .frame(width: 15, height: 15)
                                .foregroundColor(typeOfJob == .fullTime ? .accentColor : Color.gray.opacity(0.2))
                            
                            RoundedRectangle(cornerRadius: 7.5)
                                .trim(from: 0, to: 1)
                                .foregroundColor(typeOfJob == .fullTime ? .accentColor : Color.gray.opacity(0.2))
                                .frame(width: 15, height: 15)
                            if typeOfJob == .fullTime {
                                Image(systemName: "checkmark")
                                    .resizable().frame(width: 10, height: 10)
                                    .foregroundColor(.white)
                            }
                        }.onTapGesture {
                            if typeOfJob == .fullTime {
                                typeOfJob = .none
                            } else {
                                typeOfJob = .fullTime
                            }
                        }
                        Text("Full-time")
                    }
                }
            }
            
            Section {
                NavigationLink(destination: HomePage()) {
                    Button(action: {
                        
                    }) {
                        HStack {
                            HStack {
                                Spacer()
                                Text("Proceed to SignUp")
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                        }
                        .foregroundColor(Color(red: 31/255, green: 39/255, blue: 123/255, opacity: 0.9))
                    }
                }
            }
            .disabled(disableForm)
        }.navigationBarTitle(Text("Sign Up")).accentColor(Color(red: 31/255, green: 39/255, blue: 123/255, opacity: 0.9))
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
