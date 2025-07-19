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
           switch weight {
           case .regular:
               return .custom("Inter_28pt-Regular", size: size)
           case .bold:
               return .custom("Inter_28pt-Black", size: size)
           case .heavy:
               return .custom("Inter_28pt-ExtraBold", size: size)
           default:
               return .custom("Inter_28pt-Regular", size: size)
           }
       }

    static func gilroy(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        switch weight {
        case .light:
            return .custom("Gilroy-Light", size: size)
        case .bold, .heavy:
            return .custom("Gilroy-ExtraBold", size: size)
        default:
            return .custom("Gilroy-Light", size: size)
        }
    }
}

