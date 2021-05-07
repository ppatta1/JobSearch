//
//  JobCardModel.swift
//  Test
//
//  Created by Padma Priya on 3/29/21.
//

import Foundation
import SwiftUI

struct JobCardModel {
    var jobTitle: String
    var companyName: String
    var location: String
    var jobDescription: String
    var minExpRequired: Int
    var maxExpRequired: Int?
    var fullTimeOrPartTime: TypeOfJob
    var backgroundColor: Color
    var imageName: String?
    var latitude: Double?
    var longitude: Double?
    var jobDetailedDescription: String?
}

extension JobCardModel {
    enum TypeOfJob: Int {
        case none = 0
        case partTime
        case fullTime
    }
}

extension JobCardModel {
    static var data: [JobCardModel] {
        [
            JobCardModel(jobTitle: "Swift Developer", companyName: "Apple", location: "Texas", jobDescription: "IOS Application developer", minExpRequired: 1, maxExpRequired: 2, fullTimeOrPartTime: .fullTime, backgroundColor: Color(red: 247/255, green: 242/255, blue: 230/255, opacity: 1.0), imageName: "AppleCompanyLogo", latitude: 32.8227, longitude: -96.7879, jobDetailedDescription: " We are looking for a Swift Developer to join our team! As a Swift Developer you will be responsible for the development and maintenance of applications aimed towards iOS and OS X. You will oversee development of applications and their integration with back-end services. \n1. Plan, design and implement applications for iOS and OS X \n2. Monitor the performance, quality, and responsiveness of company's applications \n3. Work with the rest of the team to define, design, and develop new features \n4. Identify process bottlenecks \n5. Find and fix bugs in a timely manner \n6. Suggest improvement for the current processes \n7. Proficiency in Swift \n8. X years of experience as a Swift Developer or similar role \n9. Knowledge of performance limits and characteristics \n10. Experience with embedded databases \n11. Knowledge of RESTful APIs to connect to back-end services \n12. Understanding of UI design and a user-oriented focus \n13. Understanding of object-oriented programming \n14. Experience with Cocoa APIs on OS X \n15. Understanding of Apple’s design principles and interface guidelines \n16. Proficient understanding of code versioning tools such as Git, Mercurial or SVN \n17. Critical thinker and problem-solving skills \n18. Team player \n19. Good time-management skills \n20. Great interpersonal and communication skills"),
            JobCardModel(jobTitle: "Data Entry Specialist", companyName: "Randstand", location: "Tempe", jobDescription: "Administrative - Data Entry",minExpRequired: 1, maxExpRequired: 2, fullTimeOrPartTime: .fullTime, backgroundColor: Color(red: 247/255, green: 230/255, blue: 230/255, opacity: 1), imageName: "RHLogo", latitude: 33.4242, longitude: -111.9281),
            JobCardModel(jobTitle: "Program Coordinator", companyName: "Arizona State University", location: "Tempe", jobDescription: "Financial Aid and Scholarship Program Coordinator with focus on Internal and External scholarship Programs",minExpRequired: 0, maxExpRequired: 1, fullTimeOrPartTime: .partTime, backgroundColor: Color(red: 230/255, green: 241/255, blue: 247/255, opacity: 1), imageName: "ASULogo", latitude: 33.4242, longitude: -111.9281),
            JobCardModel(jobTitle: "Customer Service Lead", companyName: "Zoho", location: "Sanfransisco", jobDescription: "Monitoring employee performance and feedback",minExpRequired: 0, maxExpRequired: 2, fullTimeOrPartTime: .fullTime, backgroundColor: Color(red: 232/255, green: 225/255, blue: 237/255, opacity: 1), imageName: "ZohoLogo", latitude: 37.773972, longitude: -122.431297),
            JobCardModel(jobTitle: "Software Engineer", companyName: "Starbucks", location: "Seattle", jobDescription: "Cloud Intern",minExpRequired: 3, maxExpRequired: 4, fullTimeOrPartTime: .partTime, backgroundColor: Color(red: 225/255, green: 237/255, blue: 225/255, opacity: 1), imageName: "StarbucksLogo", latitude: 47.6062, longitude: -122.3321),
            JobCardModel(jobTitle: "Gallery Design Assistant", companyName: "RH", location: "Schottsdale", jobDescription: "Design, Art/Creative, Information Technology", minExpRequired: 1, maxExpRequired: 3 , fullTimeOrPartTime: .fullTime, backgroundColor: Color(red: 232/255, green: 232/255, blue: 232/255, opacity: 1), imageName: "RHLogo", latitude: 33.4255, longitude: -111.9400),
            JobCardModel(jobTitle: "Customer Success Executive", companyName: "Apple", location: "Texas", jobDescription: "Employee monitoring and feedback",minExpRequired: 0, maxExpRequired: 1, fullTimeOrPartTime: .partTime, backgroundColor: Color(red: 230/255, green: 241/255, blue: 247/255, opacity: 1), imageName: "AppleCompanyLogo", latitude: 31.9686, longitude: -99.9018),
            JobCardModel(jobTitle: "Customer Service Lead", companyName: "Zoho", location: "Sanfransisco", jobDescription: "Monitoring employee performance and feedback",minExpRequired: 1, maxExpRequired: 2, fullTimeOrPartTime: .fullTime, backgroundColor: Color(red: 247/255, green: 242/255, blue: 230/255, opacity: 1.0), imageName: "ZohoLogo", latitude: 37.7749, longitude: -122.4194),
            JobCardModel(jobTitle: "Program Coordinator", companyName: "Arizona State University", location: "Tempe", jobDescription: "Financial Aid and Scholarship Program Coordinator with focus on Internal and External scholarship Programs",minExpRequired: 1, maxExpRequired: 2, fullTimeOrPartTime: .partTime, backgroundColor: Color(red: 225/255, green: 237/255, blue: 225/255, opacity: 1), imageName: "ASULogo", latitude: 33.4255, longitude: -111.9400),
            JobCardModel(jobTitle: "Android Developer", companyName: "Walmart", location: "Seattle", jobDescription: "Android Application developer",minExpRequired: 0, maxExpRequired: 1, fullTimeOrPartTime: .partTime, backgroundColor: Color(red: 247/255, green: 230/255, blue: 230/255, opacity: 1), imageName: "WalmartCompanyLogo", latitude: 47.6062, longitude: -122.3321),
            JobCardModel(jobTitle: "Project Manager", companyName: "CVS Pharmacy", location: "Phoenix", jobDescription: "Coordinating key clients and Projects", minExpRequired: 2, maxExpRequired: 3, fullTimeOrPartTime: .fullTime, backgroundColor: Color(red: 232/255, green: 232/255, blue: 232/255, opacity: 1), imageName: "AppleCompanyLogo", latitude: 33.4484, longitude: -112.0740),
            JobCardModel(jobTitle: "Public Relations", companyName: "Arizona State University", location: "Tempe", jobDescription: "Marketing, Public Relations, Editing/Writing",minExpRequired: 0, maxExpRequired: 1, fullTimeOrPartTime: .partTime, backgroundColor: Color(red: 230/255, green: 241/255, blue: 247/255, opacity: 1), imageName: "ASULogo", latitude: 33.4255, longitude: -111.9400),
            JobCardModel(jobTitle: "Customer Success Executive", companyName: "Zoho", location: "Sanfransisco", jobDescription: "Health, Wellness and Fitness",minExpRequired: 2, maxExpRequired: 3, fullTimeOrPartTime: .fullTime, backgroundColor: Color(red: 232/255, green: 225/255, blue: 237/255, opacity: 1), imageName: "ZohoLogo", latitude: 37.7749, longitude: -122.4194),
            JobCardModel(jobTitle: "Research Assistant", companyName: "Arizona State University", location: "Tempe", jobDescription: "Research, Analyst, Information Technology",minExpRequired: 2, maxExpRequired: 3, fullTimeOrPartTime: .fullTime, backgroundColor: Color(red: 247/255, green: 242/255, blue: 230/255, opacity: 1.0), imageName: "ASULogo", latitude: 33.4255, longitude: -111.9400),
            JobCardModel(jobTitle: "Human Resources", companyName: "Apple", location: "Texas", jobDescription: "Human Resources",minExpRequired: 3, maxExpRequired: 4, fullTimeOrPartTime: .fullTime, backgroundColor: Color(red: 230/255, green: 241/255, blue: 247/255, opacity: 1), imageName: "AppleCompanyLogo", latitude: 31.9686, longitude: -99.9018)

        ]
    }
}
