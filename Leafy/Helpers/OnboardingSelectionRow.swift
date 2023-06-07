//
//  OnboardingSelectionRow.swift
//  Leafy
//
//  Created by Alec Agayan on 5/24/23.
//

import SwiftUI

struct OnboardingSelectionRow: View {
    @Environment(\.colorScheme) var colorScheme
    var text: String
    @State var image = "circle"
    @State var smallScale = false
    var body: some View {
        // multiple choice selection row with a checkbox and text
        // frame width 300x80 (width x height)
        HStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.leading)
            Text(text)
            Spacer()
        }
        .frame(width: 300, height: 50)
        .foregroundColor(colorScheme == .dark ? Color(red: 13/255, green: 35/255, blue: 41/255) : Color(red: 209/255, green: 255/255, blue: 93/255))
        .font(.custom("DMSans-Medium", size: 18))
        .background(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
        .cornerRadius(10)
        .scaleEffect(smallScale ? 0.95 : 1)
        .onTapGesture {
            if (image == "circle") {
                image = "checkmark.circle"
                withAnimation(.easeInOut) {
                    smallScale = true
                }
            } else {
                image = "circle"
                withAnimation(.easeInOut) {
                    smallScale = false
                }
            }
        }
    }
}

struct OnboardingSelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSelectionRow(text: "Grill")
    }
}
