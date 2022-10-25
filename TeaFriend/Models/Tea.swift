//
//  Tea.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import Foundation

struct Tea: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var type: TeaType
    var typeString: String {
        switch type {
        case .Black:
            return "Black"
        case .Green:
            return "Green"
        case .Fruit:
            return "Fruit"
        case .Herbal:
            return "Herbal"
        case .Roobios:
            return "Roobios"
        case .White:
            return "White"
        }
    }
    var format: TeaFormat
    var notes: String
    var rating: Int
    
}
