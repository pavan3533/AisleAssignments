//
//  Font.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import SwiftUI

extension Font {
    static func inter(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return .custom("Inter", size: size) 
    }
}
