//
//  ListView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import SwiftUI

struct ListView: View {
//    @EnvironmentObject var model: ViewModel
    
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
            .onAppear() {
                if !UserDefaults.standard.bool(forKey: "teasImported") {
                    importJSONTeas()
                    UserDefaults.standard.set(true, forKey: "teasImported")
                }
            }
        }
    }
    
    func importJSONTeas() {
        guard let path = Bundle.main.path(forResource: "teas", ofType: ".json") else {
            print("Error getting json path")
            return
        }
        
        let url = URL(filePath: path)
        
        do {
            
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            do {
                
                let decodedTeas = try decoder.decode([DecodedTea].self, from: data)
                
                for tea in decodedTeas {
                    
                    let newTea = Tea(context: viewContext)
                    newTea.id = UUID()
                    newTea.name = tea.name
                    newTea.teaDescription = tea.description
                    newTea.rating = Int16(tea.stars)
                    newTea.brand = tea.brand
                    newTea.type = tea.teaType
                    newTea.format = tea.isLooseLeaf ? "looseLeaf" : "teaBag"
                    
                    do {
                        try viewContext.save()
                    } catch {
                        print("error saving \(newTea.name) to Core Data")
                    }
                    
                }
                
            } catch {
                print("error decoding JSON: \(error)")
            }
        } catch {
            print("Error creating data: \(error)")
        }
    }
    
    // Note: Unneeded Function Now?
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
