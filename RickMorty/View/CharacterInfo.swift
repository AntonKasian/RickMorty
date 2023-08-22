//
//  CharacterInfo.swift
//  RickMorty
//
//  Created by Anton on 22.08.23.
//

import SwiftUI

struct CharacterInfo: View {
    
    var characters: [Character] = []
    var characterName: String
    var characterImage: UIImage?
    
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
            Text("Alive")
                .foregroundColor(.green)
        }
    }
}

struct CharacterInfo_Previews: PreviewProvider {
    static var previews: some View {
        CharacterInfo(characterName: "Rick")
    }
}
