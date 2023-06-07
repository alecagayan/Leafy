//
//  StartView.swift
//  Leafy
//
//  Created by Alec Agayan on 4/20/23.
//

import SwiftUI
import FluidGradient

struct StartView: View {
    @EnvironmentObject var vm: UserStateViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var signupPressed = false
    @State var loginPressed = false
    @State var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    @State private var onboarding = false
    
    var body: some View {
        //background color
            ZStack{
                FluidGradient(blobs: [.green],
                              highlights: (colorScheme == .dark ? [Color(red: 13/255, green: 35/255, blue: 41/255), Color(red: 13/255, green: 35/255, blue: 41/255), Color(red: 13/255, green: 35/255, blue: 41/255)] : [Color(red: 209/255, green: 255/255, blue: 93/255), Color(red: 90/255, green: 255/255, blue: 122/255), Color(red: 20/255, green: 237/255, blue: 185/255)]),
                              speed: 1.0,
                              blur: 0.75)
                .ignoresSafeArea()
                //            Color(red: 13/255, green: 35/255, blue: 41/255)
                //                .ignoresSafeArea()
                if (onboarding == false) {
                VStack{
                    Image(colorScheme == .dark ? "LeafyDark" : "LeafyLight")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.size.width/2)
                        .padding()
                    
                }.offset(x: 0, y: -150)
                
                //login and signup button
                //login button underneath signup button and doesnt have frame
                VStack {
                    
                    if (signupPressed == true) {
                        //email textfield
                        TextField("Email", text: $email)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(colorScheme == .dark ? Color(red: 23/255, green: 51/255, blue: 59/255) : Color(uiColor: .systemGray6))
                            .opacity(0.75)
                            .cornerRadius(5.0)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        //password textfield
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(colorScheme == .dark ? Color(red: 23/255, green: 51/255, blue: 59/255) : Color(uiColor: .systemGray6))
                            .opacity(0.75)
                            .cornerRadius(5.0)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        //confirm password textfield
                        SecureField("Confirm Password", text: $repeatPassword)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(colorScheme == .dark ? Color(red: 23/255, green: 51/255, blue: 59/255) : Color(uiColor: .systemGray6))
                            .opacity(0.75)
                            .cornerRadius(5.0)
                            .padding(.bottom)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        //signup button
                        Button {
                            withAnimation{
                                onboarding.toggle()
                            }
                        } label: {
                            Text("Sign Up")
                                .font(.custom("DMSans-Bold", size: 22))
                        }
                        .foregroundColor(colorScheme == .dark ? Color(red: 13/255, green: 35/255, blue: 41/255) : Color(red: 209/255, green: 255/255, blue: 93/255))
                        .frame(width: 300, height: 50)
                        .background(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                        .cornerRadius(10)
                        .padding(.bottom, 5.0)
                        
                        
                        Button("Back") {
                            withAnimation {
                                signupPressed.toggle()
                            }
                        }
                        .font(.custom("DMSans-Medium", size: 20))
                        .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                        
                    } else if (loginPressed == true) {
                        //email textfield
                        TextField("Email", text: $email)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(colorScheme == .dark ? Color(red: 23/255, green: 51/255, blue: 59/255) : Color(uiColor: .systemGray6))
                            .opacity(0.75)
                            .cornerRadius(5.0)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        //password textfield
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(colorScheme == .dark ? Color(red: 23/255, green: 51/255, blue: 59/255) : Color(uiColor: .systemGray6))
                            .opacity(0.75)
                            .cornerRadius(5.0)
                            .padding(.bottom)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        //login button
                        //signup button
                        Button("Log In") {
                            withAnimation {
                                vm.signIn(email: email, password: password)
                            }
                            
                        }
                        .font(.custom("DMSans-Bold", size: 22))
                        .frame(width: 300, height: 50)
                        .foregroundColor(colorScheme == .dark ? Color(red: 13/255, green: 35/255, blue: 41/255) : Color(red: 209/255, green: 255/255, blue: 93/255))
                        .frame(width: 300, height: 50)
                        .background(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                        .cornerRadius(10)
                        .padding(.bottom, 5.0)
                        
                        
                        
                        Button("Back") {
                            withAnimation {
                                loginPressed.toggle()
                            }                    }
                        .font(.custom("DMSans-Medium", size: 20))
                        .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                    } else {
                        
                        Group{
                            
                            Button("Sign Up") {
                                //signup button status variable
                                withAnimation {
                                    signupPressed.toggle()
                                }
                            }
                            .font(.custom("DMSans-Bold", size: 22))
                            .foregroundColor(colorScheme == .dark ? Color(red: 13/255, green: 35/255, blue: 41/255) : Color(red: 209/255, green: 255/255, blue: 93/255))
                            .frame(width: 300, height: 50)
                            .background(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                            .cornerRadius(10)
                            //make entire button clickable
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 5.0)
                            
                            
                            //login button
                            Button("Login") {
                                withAnimation {
                                    loginPressed.toggle()
                                }
                            }
                            .font(.custom("DMSans-Medium", size: 20))
                            .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                        }
                    }
                }.frame(maxHeight: .infinity, alignment: .bottom)
                    .padding()
            } else {
                VStack {
                        Text("Which cooking tools are you comfortable using?")
                            .font(.custom("DMSans-Bold", size: 22))
                            .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                        
                        // add five OnboardingSelectionRow views here
                        OnboardingSelectionRow(text: "Grill")
                        OnboardingSelectionRow(text: "Oven")
                        OnboardingSelectionRow(text: "Stove")
                        OnboardingSelectionRow(text: "Microwave")
                        OnboardingSelectionRow(text: "Other")
                    
                    Spacer()

                }
                .padding(64)
                //.padding()
                
                VStack {
                    Button("Next") {
                        vm.newUser(email: email, password: password, repeatPassword: repeatPassword)
                        vm.signIn(email: email, password: password)
                    }
                    .buttonStyle(NextButton())

                    
                    Button("Back") {
                        withAnimation {
                            onboarding.toggle()
                        }
                    }
                    .font(.custom("DMSans-Medium", size: 20))
                    .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                    
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding()
            }
        }
        
    }  
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

