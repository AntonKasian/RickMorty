//
//  Section.swift
//  RickMorty
//
//  Created by Anton on 23.08.23.
//

import SwiftUI

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

struct Section_Previews: PreviewProvider {
    static var previews: some View {
        Section(text: "Text")
    }
}
