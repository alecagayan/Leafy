//
//  DirectionRow.swift
//  Leafy
//
//  Created by Alec Agayan on 6/6/23.
//

import SwiftUI

struct DirectionRow: View {
    var header: String
    var bodytext: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack (alignment: .leading) {
            TextField("Header", text: .constant(header))
                .font(.custom("DMSans-Medium", size: 18))

            Spacer()
            
            TextField("Body Text", text: .constant(bodytext), axis: .vertical)
                .lineLimit(2...4)
                .font(.custom("DMSans-Regular", size: 18))

            
        }
        .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))    }
}

struct DirectionRow_Previews: PreviewProvider {
    static var previews: some View {
        DirectionRow(header: "shrick", bodytext: "crick")
    }
}
