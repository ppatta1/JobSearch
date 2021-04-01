//
//  FilterObject.swift
//  Test
//
//  Created by Padma Priya on 3/31/21.
//

import Foundation

class FilterObject: ObservableObject {
    @Published var typeOfJob: JobCardModel.TypeOfJob = .none
    @Published var minExpReq: String = ""
    @Published var maxExpReq: String = ""
}
