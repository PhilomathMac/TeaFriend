//
//  ListView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isShowingAddTea = false
    @State var searchText = ""
    @State private var isShowingFilters = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchBar(searchText: $searchText)
                    Button {
                        isShowingFilters.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .padding(.trailing)
                    }
                }
                
                FilteredTeaList(filter: searchText)
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
                .sheet(isPresented: $isShowingFilters) {
                    FilterView()
                        .presentationDetents([.medium])
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
                        print("error saving \(String(describing: newTea.name)) to Core Data")
                    }
                    
                }
                
            } catch {
                print("error decoding JSON: \(error)")
            }
        } catch {
            print("Error creating data: \(error)")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
