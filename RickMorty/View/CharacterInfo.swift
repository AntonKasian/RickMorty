//
//  CharacterInfo.swift
//  RickMorty
//
//  Created by Anton on 22.08.23.
//

import SwiftUI

struct CharacterInfo: View {
    
    @State var field = ""
    var characterName: String
    var characterImage: UIImage?
    var characterStatus: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let image = characterImage {
                Image(uiImage: image) // Используйте Image(uiImage:) для отображения UIImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(width: 148, height: 148)
            }
            Text("\(characterName)")
                .font(.system(size: 25).bold())
            Text(characterStatus)
                .foregroundColor(.green)
            
            Section(text: "Info")
            
            InfoRoundedRectangle(
                height: 130,
                cornerRadius: 10
            ) {
                VStack(alignment: .leading, spacing: 10) {
                    LabeledContent(label: "Species", value: "Human")
                    LabeledContent(label: "Gender", value: "Male")
                    LabeledContent(label: "Origin", value: "Earth")
                }
                .padding()
            }
            Section(text: "Origin")
            InfoRoundedRectangle(height: 140, cornerRadius: 10) {
                LabeledContent(label: "Text", value: "Text2")
            }
        }
    }
    
    struct LabeledContent: View {
        var label: String
        var value: String
        
        var body: some View {
            HStack {
                Text(label)
                    .foregroundColor(.secondary)
                Spacer()
                Text(value)
            }
        }
    }
    
    struct InfoRoundedRectangle<Content: View>: View {
        var height: CGFloat
        var cornerRadius: CGFloat
        @ViewBuilder var content: Content
        
        var body: some View {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(Color(.systemGray6))
                .frame(width: UIScreen.main.bounds.width - 40, height: height)
                .overlay(content)
        }
    }
    
    struct Section: View {
        var text: String
        var body: some View {
            HStack {
                Text(text)
                    .font(.headline)
                    .frame(alignment: .leading)
                    .padding(.leading)
                Spacer()
            }
        }
    }
    
    
    struct CharacterInfo_Previews: PreviewProvider {
        static var previews: some View {
            CharacterInfo(characterName: "Rick", characterStatus: "Alive")
        }
    }
}
