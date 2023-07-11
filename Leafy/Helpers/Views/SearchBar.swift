//
//  SearchBar.swift
//  Leafy
//
//  Created by Alec Agayan on 6/7/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearchButtonClicked: () -> Void
    
    var body: some View {
        ZStack {
            TextField("Search", text: $text)
                .textFieldStyle(SearchBarStyle())
            HStack {
                Spacer()
                Button(action: onSearchButtonClicked) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                }
                .padding(16)
            }
        }
        .padding(16)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), onSearchButtonClicked: {})
    }
}
