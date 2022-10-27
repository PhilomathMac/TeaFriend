//
//  ListView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var model: TeaModel
    
    @State private var isShowingAddTea = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(model.allTeas) { tea in
                    NavigationLink {
                        TeaCard(tea: tea)
                    } label: {
                        Text(tea.name)
                    }

                }
            }
            .navigationTitle("My Teas")
            .toolbar {
                Button {
                    isShowingAddTea.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isShowingAddTea) {
                    TeaCardEditable()
                }

            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(TeaModel())
    }
}
