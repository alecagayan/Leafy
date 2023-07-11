//
//  LeafyTabBar.swift
//  Leafy
//
//  Created by Alec Agayan on 6/12/23.
//

import SwiftUI

struct LeafyTabBar: View {
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home
        case search
        case favorites
        case profile
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack {
                TabBarItem(tab: .home, imageName: "home", tabTitle: "Home", selectedTab: $selectedTab)
                TabBarItem(tab: .search, imageName: "search", tabTitle: "Search", selectedTab: $selectedTab)
                TabBarItem(tab: .favorites, imageName: "favorites", tabTitle: "Favorites", selectedTab: $selectedTab)
                TabBarItem(tab: .profile, imageName: "profile", tabTitle: "Profile", selectedTab: $selectedTab)
            }
            .background(Color.white)
            .padding(.top, 10)
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: -1)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabBarItem: View {
    var tab: LeafyTabBar.Tab
    var imageName: String
    var tabTitle: String
    @Binding var selectedTab: LeafyTabBar.Tab
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 4) {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(isSelected(tab) ? .blue : .gray)
                
                Text(tabTitle)
                    .font(.footnote)
                    .foregroundColor(isSelected(tab) ? .blue : .gray)
            }
        }
    }
    
    private func isSelected(_ tab: LeafyTabBar.Tab) -> Bool {
        return selectedTab == tab
    }
}

struct LeafyTabBar_Previews: PreviewProvider {
    static var previews: some View {
        LeafyTabBar()
            .previewLayout(.sizeThatFits)
            .background(Color.gray)
    }
}
