//
//  MemberRegister.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 24/05/21.
//

import SwiftUI

struct MemberRegister: View {
    @State private var username : String = ""
    @State private var fullname : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var address : String = ""
    @State private var gender : String = ""
    
    
    @State private var isShowingImagePicker = false
    @State var selectedImage: Image? = Image(systemName: "camera.circle")
    @State var showingAlert = false
    
    @Binding var isShowingRegisterPage : Bool
    
    var body: some View {
        VStack (alignment: .center) {
            Text("Register Page")
                .bold()
            
            Button(action: {
                self.isShowingImagePicker = true
            }) {
                Text("Pick Image")
            }
            //.frame(width: ScreenSize.width)
            
            self.selectedImage?.resizable().scaledToFill()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
            
            TextField("Nama Akun", text: $username)
                .padding(.all, 10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                //.padding()
            
            TextField("Nama Lengkap", text: $fullname)
                .padding(.all, 10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
            
            HStack() {
                Text("Jenis Kelamin: ")
                
                GenderRadioButtonGroups { selected in
                    print("Gender Selected: \(selected)")
                    self.gender = selected
                }
                
            }
            .padding(.all, 10)
            //.frame(width: ScreenSize.width)
            
            //.padding(.leading, 15)
            
            TextField("Alamat", text: $address)
                .padding(.all, 10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                //.padding()
            
            TextField("Email", text: $email)
                .padding(.all, 10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                //.padding()
            
            SecureField("Kata Sandi", text: $password)
                .padding(.all, 10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                //.padding()
            
           
            
            Button(action: {
                print("Register button tapped!")
                
                //Register Function
                registerMember(username: username, email: email, password: password, address: address, gender: gender, fullname: fullname)
            }) {
                Text("Register")
            }
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .sheet(isPresented: $isShowingImagePicker, content: {
            ImagePicker(image: self.$selectedImage)
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Pendaftaran Berhasil!"), message: Text("Tekan 'OK' untuk melanjutkan"), dismissButton: .default(Text("OK")) {
                self.isShowingRegisterPage.toggle()
            })
        }

    }
    
    func registerMember(username: String, email: String, password: String, address: String, gender: String, fullname: String) {
        
        let jsonBody : [String : Any] = ["username": username, "email": email, "password": password, "confirmed": false, "address": address, "gender": gender, "fullname": fullname, "type": "Member"]
        
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
            
            
            
            
            //Go back to login page
            
        }.resume()
    }
}

struct MemberRegister_Previews: PreviewProvider {
    static var previews: some View {
        MemberRegister(isShowingRegisterPage: .constant(true))
        
        MemberRegister(isShowingRegisterPage: .constant(true))
            .previewDevice("iPhone 8")
    }
}
