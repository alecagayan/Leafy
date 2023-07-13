//
//  LeafyApp.swift
//  Leafy
//
//  Created by Alec Agayan on 4/20/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
    let providerFactory = AppCheckDebugProviderFactory()
    AppCheck.setAppCheckProviderFactory(providerFactory)
        
    FirebaseApp.configure()
    return true
  }
}

@main
struct LeafyApp: App {
  // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userStateViewModel = UserStateViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ViewSwitcher()
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
            
        }
    }
}

struct ViewSwitcher: View {
    @EnvironmentObject var vm: UserStateViewModel
    var body: some View {
        //if (vm.isLoggedIn) {
        if(true) {
            HomeView()
        } else {
            StartView()
        }
    }
}
