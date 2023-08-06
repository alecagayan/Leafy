//
//  Tester.swift
//  Leafy
//
//  Created by Alec Agayan on 6/6/23.
//

import SwiftUI
import Foundation

struct Tester: View {
    @State var presentPopup = false
    @State var strink = ""
    var body: some View {
        VStack {
            Button("New Recipe") {
                presentPopup = true
            }
            .popover(isPresented: $presentPopup) {
                NewRecipeView()
                
            }
            
            TextField("Hello", text: $strink)
                .textFieldStyle(SearchBarStyle())
        }
    }
}


struct Tester_Previews: PreviewProvider {
    static var previews: some View {
        Tester()
    }
}
