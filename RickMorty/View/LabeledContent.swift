//
//  LabeledContent.swift
//  RickMorty
//
//  Created by Anton on 23.08.23.
//

import SwiftUI

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

struct LabeledContent_Previews: PreviewProvider {
    static var previews: some View {
        LabeledContent(label: "label", value: "value")
    }
}
