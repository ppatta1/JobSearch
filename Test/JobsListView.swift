//
//  JobsListView.swift
//  Test
//
//  Created by Padma Priya on 3/30/21.
//

import SwiftUI
import MapKit

struct JobsListView: View {
    
//    @State private var location: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan())
    @Binding var user: FetchedResults<UserInfo>.Element
    
    var jobs: [JobCardModel] {
        var searchedJobs: [JobCardModel] = []
        if searchText == "" {
            searchedJobs = JobCardModel.data
        } else {
            for job in JobCardModel.data {
                if job.jobTitle.contains(searchText) {
                    searchedJobs.append(job)
                }
            }
        }
        if filters.typeOfJob != .none {
            searchedJobs = searchedJobs.filter {
                $0.fullTimeOrPartTime == filters.typeOfJob
            }
        }
        if let minExp = Int(filters.minExpReq) {
            searchedJobs = searchedJobs.filter {
                $0.minExpRequired >= minExp
            }
        }
        if let maxExp = Int(filters.maxExpReq) {
            searchedJobs = searchedJobs.filter {
                $0.maxExpRequired ?? 0 <= maxExp
            }
        }
        return searchedJobs
    }
    
    @StateObject var filters = FilterObject()
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State private var menuOpen: Bool = false
    
    func search() {
        
    }
    
    func cancel() {
        
    }
    
    var body: some View {
        ScrollView {
            ZStack() {
                VStack(spacing: -10) {
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")

                            TextField("search", text: $searchText, onEditingChanged: { isEditing in
                                self.showCancelButton = true
                            }, onCommit: {
                                    
                            }).foregroundColor(.primary)

                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                            }
                        }
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                        if showCancelButton  {
                            Image(systemName: "line.horizontal.3.decrease.circle").foregroundColor(Color(.systemBlue))
                                .onTapGesture {
                                    self.openMenu()
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            Button("Cancel") {
                                UIApplication.shared.endEditing(true)
                                self.searchText = ""
                                self.showCancelButton = false
                                filters.typeOfJob = .none
                                filters.minExpReq = ""
                                filters.maxExpReq = ""
                            }
                            .foregroundColor(Color(.systemBlue))
                        }
                    }
                    .padding()
                    .navigationBarHidden(showCancelButton)
                    ForEach(0..<jobs.count, id: \.self) { index in
                        JobCardView(jobDetails: jobs[index], user: $user)
                            .stacked(at: index, in: jobs.count).frame(maxHeight: .infinity)
                    }
                    .resignKeyboardOnDragGesture()
                }
                FilterListView(width: 250, isOpen: self.menuOpen, menuClose: self.openMenu)
                    .environmentObject(filters)
            }
        }
    }
    
    func openMenu() {
        self.menuOpen.toggle()
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        return self.offset(CGSize(width: 0, height: 0))
    }
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
