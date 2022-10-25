//
//  TeaFriendApp.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/20/22.
//

import SwiftUI

@main
struct TeaFriendApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ListView()
//            CoreDataDemo()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
