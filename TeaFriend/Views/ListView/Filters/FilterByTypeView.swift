//
//  FilterByTypeView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/17/22.
//

import SwiftUI

struct FilterByTypeView: View {
    
    @State var chosenTeaType: TeaType?
    
    var body: some View {
        HStack {
            Text("Tea Type:")
                .bold()
                .padding(.vertical)
            Spacer()
            Picker("", selection: $chosenTeaType) {
                Text("Any").tag(nil as TeaType?)
                Text("Black").tag(TeaType.Black as TeaType?)
                Text("Green").tag(TeaType.Green as TeaType?)
                Text("Roobios").tag(TeaType.Roobios as TeaType?)
                Text("Herbal").tag(TeaType.Herbal as TeaType?)
                Text("Fruit").tag(TeaType.Fruit as TeaType?)
                Text("Roobios").tag(TeaType.Roobios as TeaType?)
                Text("Other").tag(TeaType.Other as TeaType?)
            }
        }
    }
}

struct FilterByTypeView_Previews: PreviewProvider {
    static var previews: some View {
        FilterByTypeView(chosenTeaType: .Black)
    }
}
