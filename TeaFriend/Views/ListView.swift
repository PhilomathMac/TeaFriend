//
//  ListView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var model: ViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var allTeas: FetchedResults<Tea>
    
    @State private var isShowingAddTea = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(allTeas) { tea in
                    NavigationLink {
                        TeaCard(tea: tea)
                    } label: {
                        Text(tea.name ?? "Error")
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
    
    func convertToTeaModel(coreDataTea: Tea) -> TeaModel {
        let newTea = TeaModel(
            name: coreDataTea.name ?? "Error",
            description: coreDataTea.description ,
            brand: coreDataTea.brand ?? "Error",
            type: TeaType(rawValue: coreDataTea.type!) ?? .Other,
            format: TeaFormat(rawValue: coreDataTea.format!) ?? .teaBag,
            notes: coreDataTea.notes ?? "Error",
            rating: Int(coreDataTea.rating )
        )
        return newTea
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ViewModel())
    }
}
