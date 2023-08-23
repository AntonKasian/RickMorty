//
//  CharacterInfoViewModel.swift
//  RickMorty
//
//  Created by Anton on 23.08.23.
//

import SwiftUI

class CharacterInfoViewModel: ObservableObject {
    
    @Published var characterName: String
    @Published var characterImage: UIImage?
    @Published var characterStatus: String
    @Published var characterSpecies: String
    @Published var characterType: String?
    @Published var characterGender: String
    @Published var characterPlanet: String
    @Published var characterPlanetType: String?
    @Published var episodes: [Episode] = []

    init(character: Character, image: UIImage?, episodes: [Episode]) {
        self.characterName = character.name
        self.characterImage = image
        self.characterStatus = character.status
        self.characterSpecies = character.species
        self.characterType = character.type
        self.characterGender = character.gender
        self.characterPlanet = character.location.name
        self.characterPlanetType = character.location.type
        self.episodes = episodes
    }
}
