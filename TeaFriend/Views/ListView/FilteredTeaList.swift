//
//  FilteredTeaList.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/17/22.
//

import SwiftUI

struct FilteredTeaList: View {
    @FetchRequest var fetchRequest: FetchedResults<Tea>
    private var predicateList: [NSPredicate] = []
    
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
    
    init(searchText: String, filteredRating: Int, filteredType: TeaType?, filteredFormat: TeaFormat?) {
        // Build Predicate List
        if searchText != "" {
            let newPredicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
            predicateList.append(newPredicate)
        }
        if filteredRating != 0 {
            let newPredicate = NSPredicate(format: "rating >= %i", filteredRating)
            predicateList.append(newPredicate)
        }
        if filteredType != nil {
            let newPredicate = NSPredicate(format: "type == %@", filteredType!.rawValue)
            predicateList.append(newPredicate)
        }
        if filteredFormat != nil {
            let newPredicate = NSPredicate(format: "format == %@", filteredFormat!.rawValue)
            predicateList.append(newPredicate)
        }
        
        // Initialize Fetch Request
        if predicateList.isEmpty {
            _fetchRequest = FetchRequest<Tea>(sortDescriptors: [SortDescriptor(\.name)])
        }
        else if predicateList.count == 1 {
            _fetchRequest = FetchRequest<Tea>(sortDescriptors: [SortDescriptor(\.name)], predicate: predicateList.first)
        }
        else {
            let totalPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicateList)
            _fetchRequest = FetchRequest<Tea>(sortDescriptors: [SortDescriptor(\.name)], predicate: totalPredicate)
        }
    }
}

struct TeaList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredTeaList(searchText: "", filteredRating: 0, filteredType: nil, filteredFormat: nil)
    }
}
