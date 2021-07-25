//
//  MemberRegisterC.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 01/07/21.
//

import SwiftUI

struct MemberRegisterC: View {
    @State var email = ""
    @State var address = ""
    @State var birthdate = ""
    @State var gender = ""
    @State var phoneNumber = ""
    
    @State var showingAlert = false
    //@State var isShowingRegisterPageC = false
    
    @Binding var isShowingRegisterPageC : Bool
    @Binding var isShowingRegisterPage : Bool
    
    @Binding var username : String
    @Binding var fullname : String
    @Binding var password : String
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
//            NavigationLink(destination: MemberRegisterC(), isActive: $isShowingRegisterPageC){
//                EmptyView()
//            }

            VStack {

                VStack(alignment: .leading, spacing: 20) {
                    Text("")
                        .frame(width: ScreenSize.width * 0.85)
                    
                    Image("Logo")
                        .resizable()
                        .frame(width: 50, height: 75, alignment: .center)
                    
                    Text("Lengkapi data dirimu!")
                        .bold()
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    
                }
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "2e846a"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "envelope")
                            .resizable()
                            .foregroundColor(Color.init(hex: "3dd598"))
                            .frame(width: 25, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        if email.isEmpty { Text("Email").foregroundColor(.gray).padding(.leading, 15) }
                        
                        TextField("Email", text: $email)
                            .padding()
                            .foregroundColor(.gray)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .underlineTextField()
                            //.padding(.top, 10)
                            .padding(.trailing, 15)
                    }
                }
                .padding(.horizontal, 20)
                .offset(y: 10)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "2e846a"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "house.fill")
                            .resizable()
                            .foregroundColor(Color.init(hex: "3dd598"))
                            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        if address.isEmpty { Text("Alamat").foregroundColor(.gray).padding(.leading, 15) }
                        
                        TextField("Alamat", text: $address)
                            .padding()
                            .foregroundColor(.gray)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .underlineTextField()
                            //.padding(.top, 10)
                            .padding(.trailing, 15)
                    }
                }
                .padding(.horizontal, 20)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "2e846a"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "phone.fill")
                            .resizable()
                            .foregroundColor(Color.init(hex: "3dd598"))
                            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        if phoneNumber.isEmpty { Text("Nomor Telepon").foregroundColor(.gray).padding(.leading, 15) }
                        
                        TextField("Nomor Telepon", text: $phoneNumber)
                            .padding()
                            .foregroundColor(.gray)
                            .disableAutocorrection(true)
                            .keyboardType(.numberPad)
                            .autocapitalization(.none)
                            .underlineTextField()
                            //.padding(.top, 10)
                            .padding(.trailing, 15)
                    }
                }
                .padding(.horizontal, 20)
                .offset(y: -5)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "2e846a"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "person.2.fill")
                            .resizable()
                            .foregroundColor(Color.init(hex: "3dd598"))
                            .frame(width: 25, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {

                        GenderRadioButtonGroups { selected in
                            print("Gender Selected: \(selected)")
                            self.gender = selected
                        }
                    }
                    .padding(.leading, 15)
                }
                .padding(.horizontal, 20)
                .frame(width: ScreenSize.width, alignment: .leading)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "2e846a"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "calendar")
                            .resizable()
                            .foregroundColor(Color.init(hex: "3dd598"))
                            .frame(width: 25, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        if birthdate.isEmpty { Text("Tanggal Lahir ").foregroundColor(.gray).padding(.leading, 15) }
                        
                        TextField("Tanggal Lahir", text: $birthdate)
                            .padding()
                            .foregroundColor(.gray)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .underlineTextField()
                            //.padding(.top, 10)
                            .padding(.trailing, 15)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                HStack(spacing: 10) {
                    Button(action: {
                        //Go back to RegisterB Page
                        self.isShowingRegisterPageC = false
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
                    
                    if !address.isEmpty && !email.isEmpty && !gender.isEmpty && !birthdate.isEmpty {
                        Button(action: {
                            //Register Function
                            
                            self.registerMember(username: username, email: email, password: password, address: address, gender: gender, fullname: fullname)
                        }) {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(15)
                                    .foregroundColor(Color.init(hex: "40DF9F"))
                                    .frame(width: ScreenSize.width * 0.65, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                HStack {
                                    Text("Daftar")
                                        .bold()
                                        .foregroundColor(.white)
                                    
//                                    Image(systemName: "arrow.right")
//                                        .resizable()
//                                        .foregroundColor(.white)
//                                        .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
                                Text("Daftar")
                                    .bold()
                                    .foregroundColor(.white)
                                
//                                Image(systemName: "arrow.right")
//                                    .resizable()
//                                    .foregroundColor(.white)
//                                    .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
                Alert(title: Text("Register Berhasil!"), message: Text("Tekan 'OK' untuk melanjutkan"), dismissButton: .default(Text("OK")) {
                    //Balik ke login
                    self.isShowingRegisterPage = false
                })
            }
        }
    }
    
    func registerMember(username: String, email: String, password: String, address: String, gender: String, fullname: String) {
        
        let jsonBody : [String : Any] = ["username": username, "email": email, "password": password, "confirmed": false, "address": address, "gender": gender, "fullname": fullname, "type": "Member", "birthDate": birthdate, "point": 0, "phoneNumber" : phoneNumber]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "\(DBConnection.url)/users") else {
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
                print("Register JSON Response: \n\(responseJSON)")
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status code:  \(response.statusCode)")
                
                if response.statusCode == 201 {
                    self.showingAlert.toggle()
                }
            }
            
            
        }.resume()
    }
}

struct MemberRegisterC_Previews: PreviewProvider {
    static var previews: some View {
        MemberRegisterC(isShowingRegisterPageC: .constant(true), isShowingRegisterPage: .constant(true), username: .constant("alnodiadnan"), fullname: .constant("Alnodi Adnan"), password: .constant("password"))
    }
}
