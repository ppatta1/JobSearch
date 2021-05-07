//
//  StartPage.swift
//  Test
//
//  Created by Padma Priya on 3/28/21.
//

import SwiftUI
import MapKit

struct SignUpPage: View {
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var gender: Int = 0
    @State private var dob = Date()
    @State private var contactNumber = ""
    @State private var noOfSkills = 0
    @State private var skills: [String] = []
    @State private var skillsRatings: [Double] = []
    @State private var skill1 = ""
    @State private var skill1Rating: Double = 0
    @State private var skill2 = ""
    @State private var skill2Rating: Double = 0
    @State private var skill3 = ""
    @State private var skill3Rating: Double = 0
    @State private var typeOfJob: JobCardModel.TypeOfJob = .none
    @State private var datePickerShown: Bool = false
    @State private var isSignUpButtonActive = false
    @State private var showUserAlreadyExistsView = false
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    @State private var userPlace: String = "Set location"
    @State private var showsUpdateToast = false
    @State private var currentLocation: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan())
    @State private var showsImagePicker = false
    @State private var showsProfileImageActionSheet = false
    @State private var profileImage:UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    private let loc = LocationModel()
    
    @Binding var shouldAllowEdit: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @Binding var user: FetchedResults<UserInfo>.Element
    
    @FetchRequest (entity: UserInfo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserInfo.email, ascending: true)]) var users: FetchedResults<UserInfo>
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
    var disableForm: Bool {
        email.isEmpty || password.isEmpty
    }
    var genderOptions = ["Female", "Male", "Prefer not to say"]
    var skillsOptions = ["Swift", "Java", "C", "C++", "Python", "Javascript", "English", "Leadership"]
    
    init(shouldAllowEdit: Binding<Bool>, userInfo: Binding<FetchedResults<UserInfo>.Element>) {
        self._shouldAllowEdit = shouldAllowEdit
        self._user = userInfo
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(uiImage: profileImage ?? UIImage(named: "UserDefaultImage")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding()
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding()
                    .onTapGesture {
                        self.showsProfileImageActionSheet = true
                    }
            }
        VStack(alignment: .leading, spacing: 15) {
            Section(header: Text("Account Information").fontWeight(.bold)) {
                TextField("Firstname", text: $firstname)
                    .disabled(shouldAllowEdit)
                TextField("Lastname", text: $lastname)
                    .disabled(shouldAllowEdit)
                TextField("Email", text: $email)
                    .disabled(shouldAllowEdit)
                if !shouldAllowEdit {
                    SecureField("Password", text: $password)
                }
            }
            Section(header: Text("Personal Information").fontWeight(.bold)) {
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
            
            Section(header: Text("Technical Skills").fontWeight(.bold)) {
                VStack {
                    ForEach(Array(skills.enumerated()), id: \.0) { i, _ in
                        HStack {
                            TextField("Skill \(i)", text: $skills[i])
                            Spacer()
                            Slider(value: $skillsRatings[i], in: 0...5, step: 1)
                            Text("\(Int(skillsRatings[i]))")
                        }
                    }
                    Stepper(onIncrement: {
                        if(self.noOfSkills < 10){
                            self.skills.append("")
                            self.skillsRatings.append(0)
                            self.noOfSkills += 1
                        }
                    },
                        onDecrement: {
                            if(self.noOfSkills >= 0){
                                self.skills.removeLast()
                                self.skillsRatings.removeLast()
                                self.noOfSkills -= 1
                            }
                        }) {}
                    }
            }
            
            Section(header: Text("Job Preferences").fontWeight(.bold)) {
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

            if !shouldAllowEdit {
                Section() {
                    HStack {
                        Image(systemName: "location")
//                        Text("\(latitude)")
//                        Text(" ")
//                        Text("\(longitude)")
//                        Text("")
                        Text(userPlace).foregroundColor(.accentColor)
                    }
                }.onTapGesture {
//                    loc.requestAuthorisation(always: false)
//                    let mapView = MKMapView(frame: UIScreen.main.bounds)
//                    mapView.showsUserLocation = true
//                    mapView.userTrackingMode = .follow
//                    let myLocation: CLLocation = (loc.location ?? CLLocation()) as CLLocation
//                    let myLatitude: String = String(format: "%f", currentLocation.center.latitude)
//                    let myLongitude: String = String(format: "%f", currentLocation.center.longitude)
//                    location = myLatitude + " " + myLongitude
//                    loc.requestAuthorisation(always: false)
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        if let userLoc = self.loc.location {
                            currentLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLoc.coordinate.latitude, longitude: userLoc.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0))
                        }
                        latitude = currentLocation.center.latitude
                        longitude = currentLocation.center.longitude
                        userPlace = self.loc.placemark?.name ?? ""
                    }
                }
            }

            Section() {
                if showUserAlreadyExistsView {
                    HStack {
                        Text("User alreasy exists.").foregroundColor(.red)
                    }
                }
                if !shouldAllowEdit {
                    Section {
                        NavigationLink(destination: HomePage(userInfo: $user), isActive: $isSignUpButtonActive) {
                            Button(action: {
                                var alreadyExists = false
                                for user in users {
                                    if email == user.email {
                                        alreadyExists = true
                                        break
                                    }
                                }
                                if !alreadyExists {
                                    addUserDetails()
                                    isSignUpButtonActive = true
                                } else {
                                    self.showUserAlreadyExistsView = true
                                }
                            }) {
                                HStack {
                                    HStack {
                                        Spacer()
                                        Text("Proceed to SignUp")
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                }
                                .foregroundColor(.accentColor)
                            }.onTapGesture {
//                                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                                    if let userL = self.loc.location {
//                                        currentLocation = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userL.coordinate.latitude, longitude: userL.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//                                    }
//                                    latitude = currentLocation.center.latitude
//                                    longitude = currentLocation.center.longitude
//                                }
                            }
                        }
                    }
                    .disabled(disableForm)
                } else {
                    Section {
                        Button(action: {
                            datePickerShown = false
                            showsUpdateToast = true
                            updateUserDetails()
                        }) {
                            HStack {
                                HStack {
                                    Spacer()
                                    Text("Update")
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                            }
                            .foregroundColor(.accentColor)
                        }
                        Button(action: {
                        }) {
                            HStack {
                                HStack {
                                    Spacer()
                                    Text("Logout")
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                            }
                            .foregroundColor(.accentColor)
                        }.onTapGesture {
                            
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text("Sign Up")).accentColor(colorScheme == .dark ? .blue : Color(red: 31/255, green: 39/255, blue: 123/255, opacity: 0.9))
        .onAppear {
            if !shouldAllowEdit {
                loc.requestAuthorisation(always: false)
            }
        }.alert(isPresented: $showsUpdateToast) { () -> Alert in
            Alert(title: Text("Updated successfully"))
        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .sheet(isPresented: $showsImagePicker) {
            ImagePicker(sourceType: self.sourceType, image: $profileImage, isPresented: $showsImagePicker)
        }
        .actionSheet(isPresented: $showsProfileImageActionSheet) { () -> ActionSheet in
            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Take Photo"), action: {
                self.showsImagePicker = true
                self.sourceType = .camera
            }), ActionSheet.Button.default(Text("choose Photo"), action: {
                self.showsImagePicker = true
                self.sourceType = .photoLibrary
            }), ActionSheet.Button.cancel()])
        }
        .onAppear {
            if self.shouldAllowEdit {
                self.firstname = self.user.first_name ?? ""
                self.lastname =  self.user.last_name ?? ""
                self.email =  self.user.email ?? ""
                self.password =  self.user.password ?? ""
                self.gender = Int(self.user.gender)
                self.dob = self.user.dob ?? Date()
                self.contactNumber = self.user.contact ?? ""
                self.noOfSkills = Int(self.user.number_of_skills)
                self.skills = self.user.skills as? [String] ?? []
                self.skillsRatings = self.user.skill_ratings as? [Double] ?? []
                self.typeOfJob = JobCardModel.TypeOfJob(rawValue: Int(self.user.job_preference))!
                if let imgData = self.user.profile_image {
                    self.profileImage = UIImage(data: imgData) ?? UIImage(named: "UserDefaultImage")!
                }
                self.latitude = self.user.latitude
                self.longitude = self.user.longitude
            }
        }
    }
    
    func addUserDetails() {
        let userInfo = UserInfo(context: viewContext)
        userInfo.first_name = firstname
        userInfo.last_name = lastname
        userInfo.email = email
        userInfo.password = password
        userInfo.gender = Int16(gender)
        userInfo.dob = dob
        userInfo.contact = contactNumber
        userInfo.number_of_skills = Int16(noOfSkills)
        userInfo.skills = skills as NSObject
        userInfo.skill_ratings = skillsRatings as NSObject
        userInfo.job_preference = Int16(typeOfJob.rawValue)
        userInfo.latitude = latitude
        userInfo.longitude = longitude
        userInfo.user_place = userPlace
        userInfo.profile_image = profileImage?.jpegData(compressionQuality: 1.0)
        user = userInfo
        saveContext()
    }
    
    func updateUserDetails() {
        user.first_name = firstname
        user.last_name = lastname
        user.email = email
        user.password = password
        user.gender = Int16(gender)
        user.dob = dob
        user.contact = contactNumber
        user.number_of_skills = Int16(noOfSkills)
        user.skills = skills as NSObject
        user.skill_ratings = skillsRatings as NSObject
        user.job_preference = Int16(typeOfJob.rawValue)
        user.profile_image = profileImage?.jpegData(compressionQuality: 1.0)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
}

class LocationModel: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined
    @Published var location: CLLocation?
    @Published var placemark: CLPlacemark?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
    }

    public func requestAuthorisation(always: Bool = false) {
        if always {
            self.locationManager.requestAlwaysAuthorization()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }
    
    private func geocode() {
        guard let location = self.location else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
          if error == nil {
            self.placemark = places?[0]
          } else {
            self.placemark = nil
          }
        })
      }
}

extension LocationModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorisationStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last
        self.geocode()
    }
}

