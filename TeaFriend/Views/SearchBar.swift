//
//  SearchBar.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/16/22.
//

import SwiftUI

struct SearchBar: View {
    
    @State private var searchText = ""
    @State private var showCancelButton = true
    
    var body: some View {
        HStack {
            // Search Bar
            HStack {
                // Magnifying Glass
                Image(systemName: "magnifyingglass")
                // Text
                
                TextField("Search", text: $searchText) { isEditing in
                    showCancelButton = true
                } onCommit: {
                    // MARK: Search Teas
                }

                // Clear Button
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .opacity(searchText == "" ? 0 : 1)
                }

            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            
            // Cancel Button
            if showCancelButton {
                
                Button("Cancel") {
                    searchText = ""
                    showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
                
            }
        }
        .padding(.horizontal)
        .toolbar(showCancelButton ? .visible : .hidden)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}