//
//  JobCardView.swift
//  Test
//
//  Created by Padma Priya on 3/29/21.
//

import SwiftUI

struct JobCardView: View {
    let jobDetails: JobCardModel
    
    var body: some View {
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
            .fill(jobDetails.backgroundColor)
        )
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .shadow(color: jobDetails.backgroundColor, radius: 5, x: 1, y: 1)
        Spacer()
    }
}

struct JobCardView_Previews: PreviewProvider {
    static var jobDetails = JobCardModel.data[0]
    static var previews: some View {
        JobCardView(jobDetails: jobDetails)
    }
}
