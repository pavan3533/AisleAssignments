//
//  TabItem.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import SwiftUI

struct TabItem: View {
    let title: String
    let systemIcon: String
    var badgeCount: Int? = nil
    var selected: Bool = false

    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: systemIcon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(selected ? .black : .gray)

                if let count = badgeCount {
                    Text("\(count)+")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Circle().fill(Color.pink))
                        .offset(x: 10, y: -10)
                }
            }
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(selected ? .black : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}
