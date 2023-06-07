//
//  UserStateViewModel.swift
//  Leafy
//
//  Created by Alec Agayan on 4/20/23.
//

import Foundation
import FirebaseAuth
enum UserStateError: Error{
    case signInError, signOutError
}

@MainActor
class UserStateViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var showSettings = false
    
    
    
    // sign in function that logs in and gets user data
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                
                print("Error: \(error.localizedDescription)")
                
                
            } else {
                print("User signed in")
                //set isLoggedin to true
                self.isLoggedIn = true
            }
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
        
    
    func newUser(email: String, password: String, repeatPassword: String) {
        if (password == repeatPassword) {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error as NSError? {
                    
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("User created")
                }
            }
        }
    }
}

