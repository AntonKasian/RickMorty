//
//  CharacterInfo.swift
//  RickMorty
//
//  Created by Anton on 22.08.23.
//

import SwiftUI

struct CharacterInfo: View {
    var backColor = #colorLiteral(red: 0.01487923693, green: 0.04629518837, blue: 0.1187677309, alpha: 1)
    var planetColor = #colorLiteral(red: 0.09615487605, green: 0.1091408804, blue: 0.1651378274, alpha: 1)
    
    //MARK: Main
    var characterName: String
    var characterImage: UIImage?
    var characterStatus: String
    
    //MARK: Info
    var characterSpecies: String
    var characterType: String?
    var characterGender: String
    
    //MARK: Origin
    var characterPlanet: String
    var characterPlanetType: String?
    
    //MARK: Episodes
    var episodes: [Episode] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let image = characterImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(width: 148, height: 148)
            }
            Text("\(characterName)")
                .font(.system(size: 25).bold())
                .foregroundColor(.white)
            Text(characterStatus)
                .foregroundColor(.green)
            
            // MARK: - Info
            
            Section(text: "Info")
                .foregroundColor(.white)
            
            InfoRoundedRectangle(
                height: 130,
                cornerRadius: 10
            ) {
                VStack(alignment: .leading, spacing: 10) {
                    LabeledContent(label: "Species:", value: characterSpecies)
                    if characterType == "" {
                        LabeledContent(label: "Type:", value: "None")
                    } else {
                        LabeledContent(label: "Type:", value: characterType ?? "None")
                    }
                    LabeledContent(label: "Gender:", value: characterGender)
                }
                .padding()
            }
            
            // MARK: - Origin
            
            Section(text: "Origin")
                .foregroundColor(.white)
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
                        Text(characterPlanet)
                            .foregroundColor(.white)
                        Text(characterPlanetType ?? "Planet")
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
            
            ForEach(episodes) {episode in
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
                                .foregroundColor(Color(.systemGray2))
                                .font(.system(size: 14))
                        }
                    }
                    .padding()
                }
            } .padding(5)
            
        }
        .background(Color(backColor))
    }
    
    struct LabeledContent: View {
        var label: String
        var value: String
        
        var body: some View {
            HStack {
                Text(label)
                    .foregroundColor(Color.gray)
                Spacer()
                Text(value)
                    .foregroundColor(.white)
            }
        }
    }
    
    struct InfoRoundedRectangle<Content: View>: View {
        var height: CGFloat
        var cornerRadius: CGFloat
        @ViewBuilder var content: Content
        var color = #colorLiteral(red: 0.1510384381, green: 0.1641024947, blue: 0.2202236056, alpha: 1)
        var body: some View {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(Color(color))
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
            CharacterInfo(characterName: "Rick", characterStatus: "Alive", characterSpecies: "Human", characterType: "None", characterGender: "Male", characterPlanet: "Earth", characterPlanetType: "Planet")
        }
    }
}
