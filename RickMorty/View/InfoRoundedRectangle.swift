//
//  InfoRoundedRectangle.swift
//  RickMorty
//
//  Created by Anton on 23.08.23.
//

import SwiftUI

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
