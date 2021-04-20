//
//  JobDetailedView.swift
//  Test
//
//  Created by Padma Priya on 4/20/21.
//

import SwiftUI
import MapKit

struct JobDetailedView: View {
    let jobDetails: JobCardModel
    @Binding var user: FetchedResults<UserInfo>.Element
    var body: some View {
        ScrollView {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(jobDetails.jobTitle)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(jobDetails.companyName)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(jobDetails.location)
                        .font(.title3)
                        .fontWeight(.semibold)
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                if let image = jobDetails.imageName {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70, alignment: .trailing)
                } else {
                    Image("DefaultCompanyLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70, alignment: .trailing)
                }
            }
            Text(jobDetails.jobDescription)
            HStack {
                Image(systemName: "timer")
                if let maxExp = jobDetails.maxExpRequired {
                    Text("\(jobDetails.minExpRequired) - \(maxExp) years")
                } else {
                    Text("\(jobDetails.minExpRequired)+ years")
                }
            }
            HStack {
                if let lat = jobDetails.latitude, let long = jobDetails.longitude, let userLat = user.latitude, let userLong = user.longitude, userLat != 0, userLong != 0 {
                    let coordinate1 = CLLocation(latitude: userLat, longitude: userLong)
                    let coordinate2 = CLLocation(latitude: lat, longitude: long)
                    let distance = coordinate1.distance(from: coordinate2) / 1609
                    let distStr = String(format: "%0.1f", distance)
                    Image(systemName: "location")
                    Text("\(distStr) miles away")
                }
            }
            HStack {
                Image(systemName: "bag")
                switch jobDetails.fullTimeOrPartTime {
                case .fullTime:
                    Text("Full-time")
                case .partTime:
                    Text("Part-time")
                case .none:
                    Text("N/A")
                }
            }
            if let desc = jobDetails.jobDetailedDescription {
                Text(desc)
            }
        }.padding()
        .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

