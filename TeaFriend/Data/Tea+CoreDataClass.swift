//
//  Tea+CoreDataClass.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/18/22.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(Tea)
public class Tea: NSManagedObject {

    var accentColor: Color {
        switch TeaType(rawValue: type ?? "") ?? .Other {
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
