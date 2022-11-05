//
//  TeaCard.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/20/22.
//

import SwiftUI

struct TeaCard: View {
    
    var tea: Tea
        
    var accentColor: Color {
        switch TeaType(rawValue: tea.type ?? "") ?? .Other {
        case .Black:
            return Color.black
        case .Green:
            return Color.green
        case .Fruit:
            return Color.yellow
        case .Herbal:
            return Color.yellow
        case .Roobios:
            return Color.brown
        case .White:
            return Color.gray
        case .Other:
            return Color.red
        }
    }
    @State private var isShowingEditTea = false
    @State private var deleteConfirmationDisplayed = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // Tea Details
            VStack(alignment: .leading) {
                
                
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "cup.and.saucer.fill")
                            .resizable()
                            .frame(width: 100, height: 90)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .foregroundColor(accentColor)
                        Text(tea.name ?? "Error")
                            .font(.title)
                            .padding(.vertical, 10)
                        Text(tea.teaDescription ?? "")
                            .italic()
                            .padding(.bottom, 10)
                    }
                    Spacer()
                    
                    
                    
                }
                
                Divider()
                    .padding(.vertical, 10)
                
                HStack {
                    Text("Rating:")
                        .bold()
                    Spacer()
                    RatingView(teaRating: Int(tea.rating))
                }
                .padding(.vertical)
                
                // Tea Type
                HStack {
                    Text("Tea Type:")
                        .bold()
                    Spacer()
                    Text(tea.type ?? "Error")
                }
                .padding(.vertical)
                
                // Tea Format
                HStack {
                    Text("Tea Format:")
                        .bold()
                    Spacer()
                    if tea.format == "looseLeaf" {
                        Image(systemName: "leaf.fill")
                            .resizable()
                            .foregroundColor(accentColor)
                            .frame(width: 30, height: 30)
                    } else {
                        Image(systemName: "bag.fill")
                            .resizable()
                            .foregroundColor(accentColor)
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(.vertical)
                
                Divider()
                    .padding(.vertical, 10)
                
                if !(tea.notes ?? "").isEmpty {
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .bold()
                            .padding(.vertical, 2)
                        Text(tea.notes!)
                    }
                }
            }
            .padding()
            
            Button {
                deleteConfirmationDisplayed = true
            } label: {
                Text("Delete Tea")
                    .padding()
                    .foregroundColor(.red)
            }
            
        }
        .sheet(isPresented: $isShowingEditTea) {
            TeaCardEditable(tea)
        }
        .toolbar(content: {
            Button {
                isShowingEditTea = true
            } label: {
                Text("Edit")
                    .padding()
            }
        })
        .alert(isPresented: $deleteConfirmationDisplayed) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("You won't be able to undo this action."),
                primaryButton: .destructive(Text("Delete")) {
                    viewContext.delete(tea)
                    do {
                        try viewContext.save()
                    } catch {
                        print("Error deleting tea: \(error)")
                    }
                },
                secondaryButton: .default(Text("Cancel"))
            )
        }
        
        
    }
}

//struct TeaCard_Previews: PreviewProvider {
//    @Environment(\.managedObjectContext) private var viewContext
//    static var previews: some View {
//        TeaCard(tea: Tea(context: viewContext))
//    }
//}
