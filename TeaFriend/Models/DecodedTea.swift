//
//  DecodedTea.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/25/22.
//

import Foundation

struct DecodedTea: Decodable {
    var name: String
    var isLooseLeaf: Bool
    var teaType: String
    var brand: String
    var description: String
    var stars: Int
}
