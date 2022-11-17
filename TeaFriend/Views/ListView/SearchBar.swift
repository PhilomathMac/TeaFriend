//
//  SearchBar.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/16/22.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    @State private var showCancelButton = false
    
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
                    print(searchText)
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
                    UIApplication.shared.endEditing(true)
                    searchText = ""
                    showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
                
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
        // My attempt at using the newer syntax .toolbar -> currently doesn't work
//        .toolbar(showCancelButton ? .visible : .hidden)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
    }
}
