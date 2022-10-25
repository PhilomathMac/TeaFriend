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
    var brand: String
    var typeString: String
    var format: TeaFormat
    var notes: String
    var rating: Int
    
    var type: TeaType {
        switch typeString {
        case "Black", "black":
            return TeaType.Black
        case "Green", "green":
            return TeaType.Green
        case "Fruit", "fruit":
            return TeaType.Fruit
        case "Herbal", "herbal":
            return TeaType.Herbal
        case "Roobios", "roobios":
            return TeaType.Roobios
        case "White", "white":
            return TeaType.White
        default:
            return TeaType.Other
        }        
    }
    
    
}
