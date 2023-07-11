//
//  ButtonStyles.swift
//  Leafy
//
//  Created by Alec Agayan on 5/24/23.
//

import SwiftUI

struct NextButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("DMSans-Bold", size: 22))
            .foregroundColor(colorScheme == .dark ? Color(red: 13/255, green: 35/255, blue: 41/255) : Color(red: 209/255, green: 255/255, blue: 93/255))
            .frame(width: 300, height: 50)
            .background(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
            .cornerRadius(10)
            //make entire button clickable
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 5.0)

    }
}

struct SearchBarStyle: TextFieldStyle {
    @Environment(\.colorScheme) var colorScheme

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(colorScheme == .dark ? Color(red: 7/255, green: 17/255, blue: 19/255) : Color(red: 241/255, green: 255/255, blue: 209/255))
            .cornerRadius(100)
            .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
            .font(.custom("DMSans-Medium", size: 18))
            .padding(.bottom, 5.0)
    }
}

struct StylePreviews: PreviewProvider {
    static var previews: some View {
        TextField("Hello", text: .constant("Hello There"))
            .textFieldStyle(SearchBarStyle())
    }
}
