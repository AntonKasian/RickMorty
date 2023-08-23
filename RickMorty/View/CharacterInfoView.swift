//
//  CharacterInfo.swift
//  RickMorty
//
//  Created by Anton on 22.08.23.
//

import SwiftUI

struct CharacterInfoView: View {
    var backColor = #colorLiteral(red: 0.01487923693, green: 0.04629518837, blue: 0.1187677309, alpha: 1)
    var planetColor = #colorLiteral(red: 0.09615487605, green: 0.1091408804, blue: 0.1651378274, alpha: 1)
    
    @ObservedObject var viewModel: CharacterInfoViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            // MARK: - Main
            
            if let image = viewModel.characterImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(width: 148, height: 148)
            }
            Text("\(viewModel.characterName)")
                .font(.system(size: 25).bold())
                .foregroundColor(.white)
            if viewModel.characterStatus == "Dead" {
                Text(viewModel.characterStatus)
                    .foregroundColor(.red)
            } else {
                Text(viewModel.characterStatus)
                    .foregroundColor(.green)
            }
            
            // MARK: - Info
            
            Section(text: "Info")
                .foregroundColor(.white)
                .padding(.top)
            
            InfoRoundedRectangle(
                height: 130,
                cornerRadius: 10
            ) {
                VStack(alignment: .leading, spacing: 10) {
                    LabeledContent(label: "Species:", value: viewModel.characterSpecies)
                    if viewModel.characterType == "" {
                        LabeledContent(label: "Type:", value: "None")
                    } else {
                        LabeledContent(label: "Type:", value: viewModel.characterType ?? "None")
                    }
                    LabeledContent(label: "Gender:", value: viewModel.characterGender)
                }
                .padding()
            }
            
            // MARK: - Origin
            
            Section(text: "Origin")
                .foregroundColor(.white)
                .padding(.top)
            InfoRoundedRectangle(height: 80, cornerRadius: 10) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(planetColor))
                            .frame(width: 64, height: 64)
                        Image("Planet1")
                    }
                    .padding(.trailing, 10)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.characterPlanet)
                            .foregroundColor(.white)
                        Text(viewModel.characterPlanetType ?? "Planet")
                            .foregroundColor(.green)
                            .font(.system(size: 14))
                    }
                    Spacer()
                }
                .padding(10)
            }
            
            // MARK: - Episodes
            
            Section(text: "Episodes")
                .foregroundColor(.white)
                .padding(.top)
            
            ForEach(viewModel.episodes) {episode in
                InfoRoundedRectangle(height: 80, cornerRadius: 10) {
                    VStack(alignment: .leading) {
                        Text(episode.name)
                            .foregroundColor(.white)
                        Spacer()
                        HStack {
                            let episodeCode = episode.episode
                            let components = episodeCode.split(separator: "E")
                            
                            if components.count == 2,
                               let seasonNumber = Int(components[0].dropFirst()),
                               let episodeNumber = Int(components[1]) {
                                let formattedEpisode = "Episode: \(episodeNumber), Season: \(seasonNumber)"
                                Text(formattedEpisode)
                                    .foregroundColor(.green)
                                    .font(.system(size: 14))
                            }
                            Spacer()
                            Text(episode.air_date)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 14))
                        }
                    }
                    .padding()
                }
            } .padding(5)
            
        }
        .background(Color(backColor))
    }
    
    struct CharacterInfo_Previews: PreviewProvider {
        static var previews: some View {
            let originLocation = Location(name: "Earth", url: "", type: "Planet", dimension: "Dimension C-137")
            let currentLocation = Location(name: "Earth", url: "", type: "Planet", dimension: "Dimension C-137")
            
            let sampleCharacter = Character(id: 1, name: "Rick",
                                            status: "Alive",
                                            species: "Human",
                                            type: "None",
                                            gender: "Male",
                                            origin: originLocation,
                                            location: currentLocation,
                                            image: "",
                                            episode: [],
                                            url: "",
                                            created: "")
            
            let viewModel = CharacterInfoViewModel(character: sampleCharacter, image: nil, episodes: [])
            CharacterInfoView(viewModel: viewModel)
        }
    }
}
