//
//  FilterByTypeView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/17/22.
//

import SwiftUI

struct FilterByTypeView: View {
    
    @Binding var filteredType: TeaType?
    
    var body: some View {
        HStack {
            Text("Tea Type:")
                .bold()
                .padding(.vertical)
            Spacer()
            Picker("", selection: $filteredType) {
                Text("Any").tag(nil as TeaType?)
                Text("Black").tag(TeaType.Black as TeaType?)
                Text("Green").tag(TeaType.Green as TeaType?)
                Text("Rooibos").tag(TeaType.Rooibos as TeaType?)
                Text("Herbal").tag(TeaType.Herbal as TeaType?)
                Text("Fruit").tag(TeaType.Fruit as TeaType?)
                Text("Pu'erh").tag(TeaType.Puerh as TeaType?)
                Text("Oolong").tag(TeaType.Oolong as TeaType?)
                Text("Other").tag(TeaType.Other as TeaType?)
            }
        }
    }
}

struct FilterByTypeView_Previews: PreviewProvider {
    
    @State static var filteredType = TeaType.Black as TeaType?
    
    static var previews: some View {
        FilterByTypeView(filteredType: $filteredType)
    }
}
