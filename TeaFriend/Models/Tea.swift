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
    var format: TeaFormat
    var notes: String
    var rating: Int
}
