//
//  TeaCardEditable.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import SwiftUI

struct TeaCardEditable: View {
    
    @State var teaFormat: TeaFormat = .looseLeaf
    @State var teaType: TeaType = .Green
    
    @State var teaNotes: String = "User notes about this tea"
    @State var teaDescription: String = "Some flowery language about the main flavor notes of this tea."
    @State var teaName: String = "Tea Name"
    
    
    var teaColor: Color {
        switch teaType {
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
    
    var body: some View {
        VStack {
            // Tea Details
            VStack {
                
                Image(systemName: "cup.and.saucer.fill")
                    .resizable()
                    .frame(width: 100, height: 90)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .foregroundColor(teaColor)
                
                TextField("Title", text: $teaName)
                    .font(.title)
                TextEditor(text: $teaDescription)
                    .italic()
                
                Divider()
                    .padding(.vertical, 10)
                HStack {
                    Text("Rating:")
                        .bold()
                    Spacer()
                    RatingView(teaRating: 4)
                }
                
                // Tea Type
                HStack {
                    Text("Tea Type:")
                        .bold()
                    Spacer()
                    Picker("", selection: $teaType) {
                        Text("Black").tag(TeaType.Black)
                        Text("Green").tag(TeaType.Green)
                        Text("Roobios").tag(TeaType.Roobios)
                        Text("Fruit/Herbal").tag(4)
                        Text("Roobios").tag(5)
                    }
                }
                
                
                
                // Tea Format
                HStack {
                    Text("Tea Format:")
                        .bold()
                    Spacer()
                    Picker("", selection: $teaFormat) {
                        Image(systemName: "bag.fill").tag(TeaFormat.teaBag)
                        Image(systemName: "leaf.fill").tag(TeaFormat.looseLeaf)
                    }
                }
                
                Divider()
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    Text("Notes:")
                        .bold()
                    TextEditor(text: $teaNotes)
                }
                
            }
            .padding()
            
            // Button
            HStack {
                Spacer()
                Button {
                    // Save Tea
                } label: {
                    Text("Save")
                        .padding()
                        .bold()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
                Button {
                    // Return to non-editable version without saving
                } label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                }
                Spacer()
            }
            
        }
    }
    
}
    
    
    struct TeaCardEditable_Previews: PreviewProvider {
        static var previews: some View {
            TeaCardEditable()
        }
    }
