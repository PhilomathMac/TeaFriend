//
//  FilteredTeaList.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/17/22.
//

import SwiftUI

struct FilteredTeaList: View {
    @FetchRequest var fetchRequest: FetchedResults<Tea>
    
    var body: some View {
        List(fetchRequest) { tea in
            NavigationLink {
                TeaCard(tea: tea)
            } label: {
                Text(tea.name ?? "Error")
            }
        }
        .resignKeyboardOnDragGesture()
    }
    
    init(filter: String) {
        if filter != "" {
            _fetchRequest = FetchRequest<Tea>(sortDescriptors: [SortDescriptor(\.name)], predicate: NSPredicate(format: "name CONTAINS[cd] %@", filter))
        } else {
            _fetchRequest = FetchRequest<Tea>(sortDescriptors: [SortDescriptor(\.name)])
        }
    }
    
}

struct TeaList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredTeaList(filter: "")
    }
}
