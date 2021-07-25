//
//  MemberRegisterB.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 01/07/21.
//

import SwiftUI

struct MemberRegisterB: View {
    @State var password = ""
    @State var confirmPassword = ""
    
    @State var showingAlert = false
    @State var isShowingRegisterPageC = false
    @State var showPasswordA = false
    @State var showPasswordB = false
    
    @Binding var isShowingRegisterPageB : Bool
    @Binding var isShowingRegisterPage : Bool
    
    @Binding var username : String
    @Binding var fullname : String
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            NavigationLink(destination: MemberRegisterC(isShowingRegisterPageC: $isShowingRegisterPageC, isShowingRegisterPage: $isShowingRegisterPage, username: $username, fullname: $fullname, password: $password), isActive: $isShowingRegisterPageC){
                EmptyView()
            }

            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    Image("Logo")
                        .resizable()
                        .frame(width: 50, height: 75, alignment: .center)
                    
                    Text("Hello!")
                        .bold()
                        .font(.system(size: 34))
                        .foregroundColor(.white)
                    
                    Text("\(fullname)")
                        .font(.system(size: 22))
                        .foregroundColor(.gray)
                    
                    Text("")
                        .frame(width: ScreenSize.width * 0.85)
                }
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "623A42"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "lock.fill")
                            .resizable()
                            .foregroundColor(Color.init(hex: "FF575F"))
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        if password.isEmpty { Text("Kata Sandi").foregroundColor(.gray).padding(.leading, 15) }
                        
                        if showPasswordA {
                            TextField("Kata Sandi", text: $password)
                                .padding()
                                .foregroundColor(.gray)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .underlineTextField()
                                //.padding(.top, 10)
                                .padding(.trailing, 15)
                        }
                        else {
                            SecureField("Kata Sandi", text: $password)
                                .padding()
                                .foregroundColor(.gray)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .underlineTextField()
                                //.padding(.top, 10)
                                .padding(.trailing, 15)
                        }
                        
                        
                        
                        Button(action: {
                            self.showPasswordA.toggle()
                        }) {
                            if showPasswordA {
                                Image(systemName: "eye")
                                    .resizable()
                                    .frame(width: 20, height: 15, alignment: .center)
                                    .foregroundColor(.gray)
                            } else {
                                Image(systemName: "eye.slash")
                                    .resizable()
                                    .frame(width: 20, height: 15, alignment: .center)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        .padding(.leading, 270)
                    }
                }
                .padding(.horizontal,20)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "623A42"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "lock.fill")
                            .resizable()
                            .foregroundColor(Color.init(hex: "FF575F"))
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        if confirmPassword.isEmpty { Text("Konfirmasi Kata Sandi").foregroundColor(.gray).padding(.leading, 15) }
                        
                        if showPasswordB {
                            TextField("Konfirmasi Kata Sandi", text: $confirmPassword)
                                .padding()
                                .foregroundColor(.gray)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .underlineTextField()
                                //.padding(.top, 10)
                                .padding(.trailing, 15)
                        }
                        else {
                            SecureField("Konfirmasi Kata Sandi", text: $confirmPassword)
                                .padding()
                                .foregroundColor(.gray)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .underlineTextField()
                                //.padding(.top, 10)
                                .padding(.trailing, 15)
                        }
                        
                        
                        Button(action: {
                            self.showPasswordB.toggle()
                        }) {
                            if showPasswordB {
                                Image(systemName: "eye")
                                    .resizable()
                                    .frame(width: 20, height: 15, alignment: .center)
                                    .foregroundColor(.gray)
                            } else {
                                Image(systemName: "eye.slash")
                                    .resizable()
                                    .frame(width: 20, height: 15, alignment: .center)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        .padding(.leading, 270)
                    }
                }
                .offset(y: -10)
                .padding(.bottom, 10)
                .padding(.horizontal,20)
                
                HStack(spacing: 10) {
                    Button(action: {
                        //Go back to Login Page
                        self.isShowingRegisterPageB = false
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(15)
                                .foregroundColor(Color.init(hex: "286053"))
                                .frame(width: ScreenSize.height * 0.065, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            Image(systemName: "arrow.left")
                                .resizable()
                                .foregroundColor(Color.init(hex: "3DD598"))
                                .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                    }
                    
                    if !confirmPassword.isEmpty && !password.isEmpty {
                        Button(action: {
                            if password == confirmPassword {
                                self.isShowingRegisterPageC = true
                            }
                            else {
                                self.showingAlert.toggle()
                            }
                            
                        }) {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(15)
                                    .foregroundColor(Color.init(hex: "40DF9F"))
                                    .frame(width: ScreenSize.width * 0.65, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                HStack {
                                    Text("Lanjut")
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }
                            }
                        }
                    }
                    else {
                        ZStack {
                            Rectangle()
                                .cornerRadius(15)
                                .foregroundColor(Color.init(hex: "286053"))
                                .frame(width: ScreenSize.width * 0.65, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            HStack {
                                Text("Lanjut")
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }
                    
                    
                    //.padding()
                }

                
//                NavigationLink(destination: MemberRegister(isShowingRegisterPage: $isShowingRegisterPage), isActive: $isShowingRegisterPage) {
//                    EmptyView()
//                }
                
//                NavigationLink(destination: MemberProfile(), isActive: $isShowingMemberProfilePage) {
//                    EmptyView()
//                }
                
            }
            .navigationTitle("Pendaftaran")
            .navigationBarTitle("Pendaftaran")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Konfirmasi kata sandi tidak sesuai!"), message: Text("Tekan 'OK' untuk melanjutkan"), dismissButton: .default(Text("OK")) {
                    password = ""
                    confirmPassword = ""
                })
            }
        }
    }
}

struct MemberRegisterB_Previews: PreviewProvider {
    static var previews: some View {
        MemberRegisterB(isShowingRegisterPageB: .constant(true), isShowingRegisterPage: .constant(true), username: .constant("alnodiadnan"), fullname: .constant("Alnodi Adnan"))
    }
}
