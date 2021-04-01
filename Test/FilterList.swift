//
//  FilterList.swift
//  Test
//
//  Created by Padma Priya on 3/31/21.
//

import SwiftUI

struct FilterList: View {
    @State private var expand = false
    
    @EnvironmentObject var filters: FilterObject
    
    init() {
        UITabBar.appearance().isTranslucent = false
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Full-time or Part-time")
                        .font(.subheadline)
                    Spacer()
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                }.onTapGesture {
                    self.expand.toggle()
                }
                if expand {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 7.5)
                                .trim(from: 0, to: 1)
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .frame(width: 15, height: 15)
                                .foregroundColor(filters.typeOfJob == .fullTime ? .accentColor : Color.gray.opacity(0.2))
                            
                            RoundedRectangle(cornerRadius: 7.5)
                                .trim(from: 0, to: 1)
                                .foregroundColor(filters.typeOfJob == .fullTime ? .accentColor : Color.gray.opacity(0.2))
                                .frame(width: 15, height: 15)
                            if filters.typeOfJob == .fullTime {
                                Image(systemName: "checkmark")
                                    .resizable().frame(width: 10, height: 10)
                                    .foregroundColor(.white)
                            }
                        }.onTapGesture {
                            if filters.typeOfJob == .fullTime {
                                filters.typeOfJob = .none
                            } else {
                                filters.typeOfJob = .fullTime
                            }
                        }
                        Text("Full-time")
                            .font(.subheadline)
                    }
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 7.5)
                                .trim(from: 0, to: 1)
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .frame(width: 15, height: 15)
                                .foregroundColor(filters.typeOfJob == .partTime ? .accentColor : Color.gray.opacity(0.2))
                            
                            RoundedRectangle(cornerRadius: 7.5)
                                .trim(from: 0, to: 1)
                                .foregroundColor(filters.typeOfJob == .partTime ? .accentColor : Color.gray.opacity(0.2))
                                .frame(width: 15, height: 15)
                            if filters.typeOfJob == .partTime {
                                Image(systemName: "checkmark")
                                    .resizable().frame(width: 10, height: 10)
                                    .foregroundColor(.white)
                            }
                        }.onTapGesture {
                            if filters.typeOfJob == .partTime {
                                filters.typeOfJob = .none
                            } else {
                                filters.typeOfJob = .partTime
                            }
                        }
                        Text("Part-time")
                            .font(.subheadline)
                    }
                }
            }
            Section {
                VStack(alignment:.leading) {
                    Text("Experience Required")
                        .font(.subheadline)
                    HStack {
                        TextField("Min", text: $filters.minExpReq)
                            .font(.subheadline)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
                        Text("-").font(.subheadline)
                        Spacer()
                        TextField("Max", text: $filters.maxExpReq)
                            .font(.subheadline)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
                        Text("Years").font(.subheadline)
                    }
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
}

struct FilterList_Previews: PreviewProvider {
    static var previews: some View {
        FilterList()
    }
}
