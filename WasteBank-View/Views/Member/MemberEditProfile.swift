//
//  MemberEditProfile.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 25/05/21.
//

import SwiftUI

struct MemberEditProfile: View {
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    
    @State private var username : String = ""
    @State private var fullname : String = ""
    @State private var email : String = ""
    @State private var address : String = ""
    @State private var gender : String = "male"
    @State private var birthdate : String = ""
    @State private var phoneNumber : String = ""
    
    @State private var initialGender : String = ""
    
    @State private var isShowingImagePicker = false
    @State var selectedImage: Image? = Image(systemName: "camera.circle")
    
    @State var showingAlert = false
    
    @Binding var isShowingEditProfile : Bool
    
    //@Binding var isShowingRegisterPage : Bool
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            ScrollView {
                HStack {
                    Text("Edit Profile")
                        .fontWeight(.heavy)
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                .padding(.top, 10)
                
                Button(action: {
                    self.isShowingImagePicker = true
                }) {
                    //Text("Pick Image")
                    self.selectedImage?.resizable().scaledToFill()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                        .foregroundColor(Color.init(hex: "3ED598"))
                }
                //.frame(width: ScreenSize.width)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "2e846a"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundColor(Color.init(hex: "3dd598"))
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        
                        TextField("\(userLoggedOnInfo.username)", text: $username)
                            .padding()
                            .foregroundColor(.gray)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .underlineTextField()
                            //.padding(.top, 10)
                            .padding(.trailing, 15)
                    }
                }
                .padding(.horizontal,10)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "2e846a"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundColor(Color.init(hex: "3dd598"))
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        
                        TextField("\(userLoggedOnInfo.fullname)", text: $fullname)
                            .padding()
                            .foregroundColor(.gray)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .underlineTextField()
                            //.padding(.top, 10)
                            .padding(.trailing, 15)
                    }
                }
                .padding(.horizontal,10)
                
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
                .padding(.horizontal, 10)
                
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
                .padding(.horizontal, 10)
                //.offset(y: -5)
                
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
                .padding(.horizontal, 10)
                
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
                        
                        if initialGender == Gender.male.rawValue{
                            GenderRadioButtonGroups(callback:  { selected in
                                print("Gender Selected: \(selected)")
                                self.gender = selected
                            }, selectedId: Gender.male.rawValue)
                        }
                        else if initialGender == Gender.female.rawValue {
                            GenderRadioButtonGroups(callback:  { selected in
                                print("Gender Selected: \(selected)")
                                self.gender = selected
                            }, selectedId: Gender.female.rawValue)
                        }
                        
                    }
                    .padding(.leading, 15)
                }
                .padding(.horizontal, 10)
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
                        
                        TextField("\(userLoggedOnInfo.birthDate)", text: $birthdate)
                            .padding()
                            .foregroundColor(.gray)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .underlineTextField()
                            //.padding(.top, 10)
                            .padding(.trailing, 15)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                HStack(spacing: 10) {
                    Button(action: {
                        self.isShowingEditProfile = false
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
                    
                    Button(action: {
                        //Update Function
                        self.updateLoggedOnMemberInfo(newUsername: username, newEmail: email, newAddress: address, newGender: gender, newFullname: fullname,newBirthDate: birthdate, newPhoneNumber: phoneNumber)
                        
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(15)
                                .foregroundColor(Color.init(hex: "40DF9F"))
                                .frame(width: ScreenSize.width * 0.65, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            HStack {
                                Text("Confirm")
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

               
//                Button(action: {
//                    print("Update Profile button tapped!")
//
//                    //Update Function
//                    self.updateLoggedOnMemberInfo(newUsername: username, newEmail: email, newAddress: address, newGender: gender, newFullname: fullname)
//                }) {
//                    Text("Update Info")
//                }
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .sheet(isPresented: $isShowingImagePicker, content: {
                ImagePicker(image: self.$selectedImage)
            })
            .onAppear(perform: {
                self.username = userLoggedOnInfo.username
                self.fullname = userLoggedOnInfo.fullname
                self.gender = userLoggedOnInfo.gender
                self.address = userLoggedOnInfo.address
                self.email = userLoggedOnInfo.email
                self.birthdate = userLoggedOnInfo.birthDate
                self.phoneNumber = userLoggedOnInfo.phoneNumber
                
                self.initialGender = gender == "Laki-laki" ? Gender.male.rawValue : Gender.female.rawValue
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Update Berhasil!"), message: Text("Tekan 'OK' untuk melanjutkan"), dismissButton: .default(Text("OK")) {
                    self.isShowingEditProfile = false
                })
        }
        }
    }
    
    func updateLoggedOnMemberInfo(newUsername: String, newEmail: String, newAddress: String, newGender: String, newFullname: String, newBirthDate : String, newPhoneNumber : String) {
        
        let jsonBody : [String : Any] = ["username": newUsername, "email": newEmail, "confirmed": false, "address": newAddress, "gender": newGender, "fullname": newFullname, "birthDate" : newBirthDate, "phoneNumber" : newPhoneNumber]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "\(DBConnection.url)/users/\(userLoggedOnInfo.id)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                print("Update profile status code:  \(response.statusCode)")
                
                if response.statusCode == 200 {
                    refreshLogin(newUsername: newUsername, newEmail: newEmail, newAddress: newAddress, newGender: newGender, newFullname: newFullname, newBirthDate: newBirthDate, newPhoneNumber: newPhoneNumber)
                    
                    self.showingAlert.toggle()
                }
            }
        }.resume()
        
    }
    
    func refreshLogin(newUsername: String, newEmail: String, newAddress: String, newGender: String, newFullname: String, newBirthDate: String, newPhoneNumber : String) {
        UserDefaults.standard.set(newUsername, forKey: "loggedUsername")
        
        UserDefaults.standard.set(newFullname, forKey: "loggedFullname")
        
        UserDefaults.standard.set(newEmail, forKey: "loggedEmail")
        
        UserDefaults.standard.set(newAddress, forKey: "loggedAddress")
        
        UserDefaults.standard.set(newGender, forKey: "loggedGender")
        
        UserDefaults.standard.set(newBirthDate, forKey: "loggedBirthDate")
        
        UserDefaults.standard.set(newPhoneNumber, forKey: "loggedPhoneNumber")
        
        userLoggedOnInfo.id = UserDefaults.standard.integer(forKey: "loggedId")
        
        userLoggedOnInfo.fullname = UserDefaults.standard.string(forKey: "loggedFullname")!
        
        userLoggedOnInfo.fullname = UserDefaults.standard.string(forKey: "loggedFullname")!
        
        userLoggedOnInfo.username = UserDefaults.standard.string(forKey: "loggedUsername")!
        
        userLoggedOnInfo.email = UserDefaults.standard.string(forKey: "loggedEmail")!
        
        userLoggedOnInfo.address
            = UserDefaults.standard.string(forKey: "loggedAddress")!
        
        userLoggedOnInfo.gender = UserDefaults.standard.string(forKey: "loggedGender")!
        
        userLoggedOnInfo.joinDate = UserDefaults.standard.string(forKey: "loggedJoinDate")!
        
        userLoggedOnInfo.type = UserDefaults.standard.string(forKey: "loggedType")!
        
        userLoggedOnInfo.birthDate = UserDefaults.standard.string(forKey: "loggedBirthDate")!
        
        userLoggedOnInfo.phoneNumber = UserDefaults.standard.string(forKey: "loggedPhoneNumber")!
        
        userLoggedOnInfo.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}

struct MemberEditProfile_Previews: PreviewProvider {
    static var previews: some View {
        MemberEditProfile(isShowingEditProfile: .constant(true))
            .environmentObject(UserLoggedOnInfo())
    }
}
