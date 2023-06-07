//
//  Tester.swift
//  Leafy
//
//  Created by Alec Agayan on 6/6/23.
//

import SwiftUI

struct Tester: View {
    @State var presentPopup = false
    var body: some View {
        Button("New Recipe") {
          presentPopup = true
        }
        .popover(isPresented: $presentPopup) {
            NewRecipeView(presentPopup: $presentPopup)
        }    }
}

struct Tester_Previews: PreviewProvider {
    static var previews: some View {
        Tester()
    }
}
