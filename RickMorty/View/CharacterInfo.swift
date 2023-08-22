//
//  CharacterInfo.swift
//  RickMorty
//
//  Created by Anton on 22.08.23.
//

import SwiftUI

struct CharacterInfo: View {
    
    var characterName: String
    
    var body: some View {
        Text("Character Name: \(characterName)")
    }
}

struct CharacterInfo_Previews: PreviewProvider {
    static var previews: some View {
        CharacterInfo(characterName: "Rick")
    }
}
