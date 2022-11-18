//
//  Tea.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import Foundation
import SwiftUI

struct TeaModel: Identifiable, Equatable {
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
            return Color.mint
        case .Herbal:
            return Color.indigo
        case .Rooibos:
            return Color.pink
        case .White:
            return Color.gray
        case .Oolong:
            return Color.orange
        case .Puerh:
            return Color.brown
        case .Other:
            return Color.red
        }
    }
    
    
}
