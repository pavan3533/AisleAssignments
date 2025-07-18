//
//  TabBarView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

import SwiftUI

struct TabBarView: View {
    var selectedTab: String

    var body: some View {
        HStack {
            TabItem(title: "Discover", systemIcon: "magnifyingglass", selected: selectedTab == "Discover")
            TabItem(title: "Notes", systemIcon: "envelope.fill", badgeCount: 9, selected: selectedTab == "Notes")
            TabItem(title: "Matches", systemIcon: "heart.fill", badgeCount: 50, selected: selectedTab == "Matches")
            TabItem(title: "Profile", systemIcon: "person.fill", selected: selectedTab == "Profile")
        }
        .padding(.top, 10)
        .padding(.bottom, 30)
        .background(Color.white)
    }
}
