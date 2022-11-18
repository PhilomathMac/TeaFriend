//
//  FilterView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/17/22.
//

import SwiftUI

struct FilterView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Filter Options")
                    .font(.title)
                Spacer()
                Button {
                    // MARK: Clear Filters
                } label: {
                    Text("Reset Filters")
                        .foregroundColor(Color(.systemGreen))
                }
            }
            Divider()
            FilterByRatingView()
            Divider()
            FilterByTypeView()
            Divider()
            FilterByFormatView()
        }
        .padding()
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
