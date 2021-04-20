//
//  SignUporLogInPage.swift
//  Test
//
//  Created by Padma Priya on 3/28/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct SignUporLogInPage: View {
    @Binding var showPermissionPopup: Bool
    @Binding var showSignUpPage: Bool
    @State var showsLoginPage = false
    @State var isEditAllowed = false
    
//    private let loc = LocationModel()
    let persistenceContainer = PersistenceController.shared
    
    @State var userInfo: FetchedResults<UserInfo>.Element = UserInfo()
    var body: some View {
        NavigationView {
        ZStack {
            Image("JobSearch")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .transition(.scale)
            VStack {
                HStack(alignment: .lastTextBaseline, spacing: 10) {
                    Spacer(minLength: 10)
                    NavigationLink(destination: SignUpPage(shouldAllowEdit: $isEditAllowed, userInfo: $userInfo).environment(\.managedObjectContext, persistenceContainer.container.viewContext), isActive: $showSignUpPage) {
                    Button(action: {
//                        showPermissionPopup = true
                        showSignUpPage = true
                    }) {
                        HStack {
                                Text("SignUp")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                        .background(Color(red: 31/255, green: 39/255, blue: 123/255, opacity: 0.9))
                        .cornerRadius(10)
                    }.alert(isPresented: $showPermissionPopup) { () -> Alert in
                        let primaryButton = Alert.Button.default(Text("Allow")) {
//                            loc.requestAuthorisation(always: false)
//                            let mapView = MKMapView(frame: UIScreen.main.bounds)
//                            mapView.showsUserLocation = true
//                            mapView.userTrackingMode = .follow
                            showSignUpPage = true
                        }
                        let secondaryButton = Alert.Button.cancel(Text("Not now")) {
                            showSignUpPage = true
                        }
                        return Alert(title: Text("JobSearch would like to access your phone's location"), message: Text("To provide best results of jobsearch, you need to allow access to location"), primaryButton: primaryButton, secondaryButton: secondaryButton)
                    }
                    }
                    NavigationLink(destination: LoginPage(userInfo: userInfo).environment(\.managedObjectContext, persistenceContainer.container.viewContext), isActive: $showsLoginPage) {
                        Button(action: {
                            showsLoginPage = true
                        }) {
                            HStack {
                                    Text("LogIn")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 227/255, green: 90/255, blue: 0, opacity: 0.9))
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer(minLength: 10)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                Spacer(minLength: 10)
            }
        }}
    }
}

//class LocationModel: NSObject, ObservableObject {
//    private let locationManager = CLLocationManager()
//    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined
//    @Published var location: CLLocation?
//
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//    }
//
//    public func requestAuthorisation(always: Bool = false) {
//        if always {
//            self.locationManager.requestAlwaysAuthorization()
//        } else {
//            self.locationManager.requestWhenInUseAuthorization()
//        }
//
////        if authorisationStatus == .authorizedAlways || authorisationStatus == .authorizedWhenInUse {
////            locationManager.startUpdatingLocation()
////        }
//    }
//}
//
//extension LocationModel: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        self.authorisationStatus = status
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        self.location = locations.last
//    }
//}
