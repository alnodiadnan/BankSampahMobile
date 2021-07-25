//
//  MemberLogin.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 23/05/21.
//

import SwiftUI

struct MemberLogin: View {
    @State private var username : String = ""
    @State private var password : String = ""
    @State private var isShowingRegisterPage : Bool = false
    @State private var isShowingMemberProfilePage : Bool = false
    @State var showingAlert = false
    @State var showPassword = false
    
    //@Binding var isShowingLoginPage : Bool
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(hex: "22343C")
                    .ignoresSafeArea()
                
                VStack() {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("")
                            .frame(width: ScreenSize.width * 0.85)
                        
                        Image("Logo")
                            .resizable()
                            .frame(width: 50, height: 75, alignment: .center)
                        Text("Selamat Datang!")
                            .bold()
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                        
                        Text("Login untuk melanjutkan")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        ZStack {
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(Color.init(hex: "625B39"))
                                .frame(width: 45, height: 60, alignment: .center)
                            
                            Image(systemName: "person.fill")
                                .resizable()
                                .foregroundColor(Color.init(hex: "FFC542"))
                                .frame(width: 20, height: 20, alignment: .center)
                        }
                        .padding(.leading, 10)
                        
                        ZStack(alignment: .leading) {
                            if username.isEmpty { Text("Nama Akun").foregroundColor(.gray).padding(.leading, 15) }
                            
                            TextField("Nama Akun", text: $username)
                                .padding()
                                .foregroundColor(.gray)
                                .underlineTextField()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                //.border(Color.black, width: 2)
                                //.padding(.top, 10)
                                .padding(.trailing, 50)
                        }
                    }
                    .padding(.leading, 20)
                    
                    
                    HStack {
                        ZStack {
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(Color.init(hex: "623A42"))
                                .frame(width: 45, height: 60, alignment: .center)
                            
                            Image(systemName: "lock.fill")
                                .resizable()
                                .foregroundColor(Color.init(hex: "FF575F"))
                                .frame(width: 20, height: 20, alignment: .center)
                        }
                        .padding(.leading, 10)
                        
                        ZStack(alignment: .leading) {
                            if password.isEmpty { Text("Kata Sandi").foregroundColor(.gray).padding(.leading, 15) }
                            
                            if showPassword {
                                TextField("Kata Sandi", text: $password)
                                    .padding()
                                    .foregroundColor(.gray)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .underlineTextField()
                                //.padding(.top, 10)
                                //.padding(.trailing, 15)
                            }
                            else {
                                SecureField("Kata Sandi", text: $password)
                                    .padding()
                                    .foregroundColor(.gray)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .underlineTextField()
                                //.padding(.top, 10)
                                //.padding(.trailing, 15)
                            }
                            
                            
                            Button(action: {
                                self.showPassword.toggle()
                            }) {
                                if showPassword {
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
                            .padding(.leading, 250)
                        }
                        .padding(.trailing, 50)
                        
                        
                    }
                    .offset(y: -15)
                    .padding(.leading, 20)
                    
                    
                    Button(action: {
                        print("Login button tapped!")
                        
                        //Login Function
                        memberLogin(username: self.username, password: self.password)
                        
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(15)
                                .foregroundColor(Color.init(hex: "40DF9F"))
                                .frame(width: ScreenSize.width * 0.85, height: ScreenSize.height * 0.065, alignment: .center)
                            
                            Text("Masuk")
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        print("Register button tapped!")
                        self.isShowingRegisterPage = true
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(15)
                                .foregroundColor(Color.init(hex: "286053"))
                                .frame(width: ScreenSize.width * 0.85, height: ScreenSize.height * 0.065, alignment: .center)
                            
                            Text("Daftar")
                                .bold()
                                .foregroundColor(Color.init(hex: "3DD598"))
                        }
                    }
                    .padding([.leading, .bottom, .trailing])
                    
                    NavigationLink(destination: MemberRegisterA(isShowingRegisterPage: $isShowingRegisterPage), isActive: $isShowingRegisterPage) {
                        EmptyView()
                    }
                    
                    //                NavigationLink(destination: MemberProfile(), isActive: $isShowingMemberProfilePage) {
                    //                    EmptyView()
                    //                }
                    
                }
                .navigationTitle("Login")
                .navigationBarTitle("Login")
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Login Gagal!"), message: Text("Tekan 'OK' untuk melanjutkan"), dismissButton: .default(Text("OK")) {
                        password = ""
                        username = ""
                    })
                }
            }
            //.navigationBarHidden(true)
            //.navigationBarBackButtonHidden(true)
        }
        
        
    }
    
    
    
    func memberLogin(username : String, password : String) {

        let jsonBody : [String : Any] = ["identifier": username, "password": password]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "\(DBConnection.url)/auth/local") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let responseJSON = responseJSON as? [String: Any] {
                print("LOGIN JSON RESPONSE: \n\(responseJSON)")
            }
            
            let userLoggedOn = try? JSONDecoder().decode(UserLoggedOn.self, from: data)
            
            print(userLoggedOn as Any)
        
            if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
                
                if response.statusCode == 200 {
                    saveLoginInfoToUserDefault(userLoggedOn)
                    
                    //Save login information to environtmentObject
                    //saveLoginInfoToEnvirontment(userLoggedOn)

                    self.getLoginInfoFromUserDefault()
                    self.tabSelection = 0
                }
                else {
                    self.showingAlert.toggle()
                }
            }
            
            
//            saveLoginInfoToUserDefault(userLoggedOn)
//
//            //Save login information to environtmentObject
//            //saveLoginInfoToEnvirontment(userLoggedOn)
//
//            self.getLoginInfoFromUserDefault()
//            self.tabSelection = 2
        }.resume()
        
        
        func saveLoginInfoToUserDefault(_ userLoggedOn: UserLoggedOn?) {
            //Save login info to userDefault
            UserDefaults.standard.set(userLoggedOn!.user.id, forKey: "loggedId")
            
            UserDefaults.standard.set(userLoggedOn!.user.username, forKey: "loggedUsername")
            
            UserDefaults.standard.set(userLoggedOn!.user.fullname, forKey: "loggedFullname")
            
            UserDefaults.standard.set(userLoggedOn!.user.email, forKey: "loggedEmail")
            
            UserDefaults.standard.set(userLoggedOn!.user.createdAt, forKey: "loggedJoinDate")
            
            UserDefaults.standard.set(userLoggedOn!.user.address, forKey: "loggedAddress")
            
            UserDefaults.standard.set(userLoggedOn!.user.gender, forKey: "loggedGender")
            
            UserDefaults.standard.set(userLoggedOn!.user.type, forKey: "loggedType")
            
            UserDefaults.standard.set(userLoggedOn!.user.birthDate, forKey: "loggedBirthDate")
            
            UserDefaults.standard.set(userLoggedOn!.user.point, forKey: "loggedPoint")
            
            UserDefaults.standard.set(userLoggedOn!.user.phoneNumber, forKey: "loggedPhoneNumber")
            
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
            UserDefaults.standard.set("true", forKey: "isLoggedInString")
            
        }
        
        func saveLoginInfoToEnvirontment(_ userLoggedOn: UserLoggedOn?) {
            userLoggedOnInfo.username = userLoggedOn!.user.username
            
            userLoggedOnInfo.fullname = userLoggedOn!.user.fullname
            
            userLoggedOnInfo.email = userLoggedOn!.user.email
            
            userLoggedOnInfo.joinDate = userLoggedOn!.user.createdAt
            
            userLoggedOnInfo.gender = userLoggedOn!.user.gender
            
            userLoggedOnInfo.address = userLoggedOn!.user.address
            
            userLoggedOnInfo.type = userLoggedOn!.user.type
            
            userLoggedOnInfo.birthDate = userLoggedOn!.user.birthDate
            
            userLoggedOnInfo.point = userLoggedOn!.user.point
            
            userLoggedOnInfo.phoneNumber = userLoggedOn!.user.phoneNumber
            
            userLoggedOnInfo.isLoggedIn = true
        }
        
    }
    
    func getLoginInfoFromUserDefault() {
        userLoggedOnInfo.id = UserDefaults.standard.integer(forKey: "loggedId")
        
        userLoggedOnInfo.fullname = UserDefaults.standard.string(forKey: "loggedFullname")!
        
        userLoggedOnInfo.fullname = UserDefaults.standard.string(forKey: "loggedFullname")!
        
        userLoggedOnInfo.username = UserDefaults.standard.string(forKey: "loggedUsername")!
        
        userLoggedOnInfo.email = UserDefaults.standard.string(forKey: "loggedEmail")!
        
        userLoggedOnInfo.address
            = UserDefaults.standard.string(forKey: "loggedAddress")!
        
        userLoggedOnInfo.gender = UserDefaults.standard.string(forKey: "loggedGender")!
        
        userLoggedOnInfo.joinDate = UserDefaults.standard.string(forKey: "loggedJoinDate")!
        
        userLoggedOnInfo.birthDate = UserDefaults.standard.string(forKey: "loggedBirthDate")!
        
        userLoggedOnInfo.point = UserDefaults.standard.integer(forKey: "loggedPoint")
        
        userLoggedOnInfo.phoneNumber = UserDefaults.standard.string(forKey: "loggedPhoneNumber")!
        
        userLoggedOnInfo.type = UserDefaults.standard.string(forKey: "loggedType")!
        
        userLoggedOnInfo.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

}

struct MemberLogin_Previews: PreviewProvider {
    static var previews: some View {
        MemberLogin(tabSelection: .constant(3))
        //MemberLogin(isShowingLoginPage: .constant(true))
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .overlay(
                Rectangle()
                    .frame(height: 0.5)
                    .padding(.top, 40)
            )
            .foregroundColor(.black)
            .padding(.vertical)
    }
}
