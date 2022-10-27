//
//  Tea.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import Foundation
import SwiftUI

struct Tea: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var brand: String
    var type: TeaType
    var format: TeaFormat
    var notes: String
    var rating: Int
    
    var accentColor: Color {
        switch type {
        case .Black:
            return Color.black
        case .Green:
            return Color.green
        case .Fruit:
            return Color.yellow
        case .Herbal:
            return Color.yellow
        case .Roobios:
            return Color.brown
        case .White:
            return Color.gray
        case .Other:
            return Color.red
        }
    }
    
    
}
