//
//  JobCardView.swift
//  Test
//
//  Created by Padma Priya on 3/29/21.
//

import SwiftUI
import MapKit
import UIKit

struct JobCardView: View {
    let jobDetails: JobCardModel
    @State var isDetailedViewActive = false
    @Binding var user: FetchedResults<UserInfo>.Element
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.accessibilityInvertColors) var invertColor
    var body: some View {
        NavigationLink(destination: JobDetailedView(jobDetails: jobDetails, user: $user), isActive: $isDetailedViewActive) {
            EmptyView()
        }
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(jobDetails.jobTitle)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(jobDetails.companyName)
                        .fontWeight(.semibold)
                    Text(jobDetails.location)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                if let image = jobDetails.imageName {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50, alignment: .trailing)
                } else {
                    Image("DefaultCompanyLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50, alignment: .trailing)
                }
            }
            Text(jobDetails.jobDescription)
                .font(.subheadline)
            Spacer()
            HStack() {
                HStack {
                    Image(systemName: "timer")
                        .font(.subheadline)
                    if let maxExp = jobDetails.maxExpRequired {
                        Text("\(jobDetails.minExpRequired) - \(maxExp) years")
                            .font(.subheadline)
                    } else {
                        Text("\(jobDetails.minExpRequired)+ years")
                            .font(.subheadline)
                    }
                }
                Spacer()
                HStack {
                    if let lat = jobDetails.latitude, let long = jobDetails.longitude, let userLat = user.latitude, let userLong = user.longitude, userLat != 0, userLong != 0 {
                        let coordinate1 = CLLocation(latitude: userLat, longitude: userLong)
                        let coordinate2 = CLLocation(latitude: lat, longitude: long)
                        let distance = coordinate1.distance(from: coordinate2) / 1609
                        let distStr = String(format: "%0.1f", distance)
                        Image(systemName: "location")
                            .font(.subheadline)
                        Text("\(distStr) miles away")
                            .font(.subheadline)
                    }
                }
                
                Spacer()
                HStack {
                    Image(systemName: "bag")
                        .font(.subheadline)
                    switch jobDetails.fullTimeOrPartTime {
                    case .fullTime:
                        Text("Full-time")
                            .font(.subheadline)
                    case .partTime:
                        Text("Part-time")
                            .font(.subheadline)
                    case .none:
                        Text("N/A")
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
            .fill(colorScheme == .dark ? .gray : jobDetails.backgroundColor)
        )
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
//        .shadow(color: colorScheme == .dark ? Color(red: 1 - jobDetails.backgroundColor.components.red, green: 1 - jobDetails.backgroundColor.components.green, blue: 1 - jobDetails.backgroundColor.components.blue) : jobDetails.backgroundColor, radius: 5, x: 1, y: 1)
        .onTapGesture {
            isDetailedViewActive = true
        }
        Spacer()
    }
}
extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        
        typealias NativeColor = UIColor

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }
}
