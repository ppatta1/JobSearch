//
//  FilterListView.swift
//  Test
//
//  Created by Padma Priya on 3/31/21.
//

import SwiftUI

struct FilterListView: View {
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    
    @EnvironmentObject var filters: FilterObject
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.menuClose()
            }
                
            HStack {
                FilterList()
                    .environmentObject(filters)
                    .frame(width: self.width)
                    .offset(x: self.isOpen ? UIScreen.main.bounds.size.width - self.width : UIScreen.main.bounds.size.width)
                    .animation(.default)
                Spacer()
            }
        }
    }
}
