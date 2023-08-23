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
    var backColor = #colorLiteral(red: 0.01487923693, green: 0.04629518837, blue: 0.1187677309, alpha: 1)
    
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
                    LabeledContent(label: "Species:", value: "Human")
                    LabeledContent(label: "Gender:", value: "Male")
                    LabeledContent(label: "Gender:", value: "Earth")
                }
                .padding()
            }
            
            // MARK: - Origin
            
            Section(text: "Origin")
                .foregroundColor(.white)
            InfoRoundedRectangle(height: 80, cornerRadius: 10) {
                HStack {
                    Image("rick")
                        .resizable()
                        .frame(width: 64, height: 64)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Earth")
                            .foregroundColor(.white)
                        Text("Planet")
                            .foregroundColor(.green)
                            .font(.system(size: 14))
                    }
                    Spacer()
                }
                .padding()
            }
            
            // MARK: - Episodes
            
            Section(text: "Episodes")
                .foregroundColor(.white)
            
            ForEach(0..<10) {_ in
                InfoRoundedRectangle(height: 80, cornerRadius: 10) {
                    VStack(alignment: .leading) {
                        Text("Pilot")
                            .foregroundColor(.white)
                        Spacer()
                        HStack {
                            Text("Episode: 1, Season: 1")
                                .foregroundColor(.green)
                                .font(.system(size: 14))
                            Spacer()
                            Text("December 2, 2013")
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
                    .foregroundColor(Color(.systemGray4))
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
            CharacterInfo(characterName: "Rick", characterStatus: "Alive")
        }
    }
}
