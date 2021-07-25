//
//  AdminSaveRequestRow.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 23/07/21.
//

import SwiftUI

struct AdminSaveRequestRow: View {
    var request : SaveRequestHeader
    
    @State var formattedRequestDate = "*Date*"
    @State var statusColorHex : String = ""
    @State var wasteCount : Int = 0
    
    @State var extendView = false
    @State var showingSuccessAlert = false
    @State var showingAlert = false
    
    @Binding var saveRequestList : [SaveRequestHeader]
    
    @State var savingList : [Saving] = []
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            ZStack {
                Rectangle()
                    .cornerRadius(20)
                    .foregroundColor(Color.init(hex: "30444E"))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                    .frame(width: ScreenSize.width * 0.9, height: extendView ? ScreenSize.height * 0.235 + CGFloat(wasteCount * 20)  : ScreenSize.height * 0.12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack {
                    HStack {
                        VStack() {
                            Text("\(String(request.status).uppercased())")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.init(hex: statusColorHex))
                                .font(.system(size: 16))
                                .padding(.bottom, 5)
                                .padding(.top, 5)
                                .frame(width: ScreenSize.width * 0.75)
                            
                            Text("Nasabah : \(request.usersPermissionsUser.fullname)")
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .frame(width: ScreenSize.width * 0.7)

                            
                            Text("\(formattedRequestDate)")
                                .foregroundColor(Color.init(hex: "2a7e63"))
                                .fontWeight(.heavy)
                                .font(.system(size: 12))
                                .padding(.top, 5)
                            
                            
                        }
                        
                        if !extendView {
                            Button(action: {
                                self.extendView.toggle()
                            }){
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .frame(width: 15, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                            }
                            
                        }
                        else {
                            Button(action: {
                                self.extendView.toggle()
                            }){
                                Image(systemName: "chevron.up")
                                    .resizable()
                                    .frame(width: 15, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                            }

                        }
                        
                    }
                    
                    if extendView {
                        Rectangle()
                            .frame(width: ScreenSize.width * 0.9, height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .onAppear(perform: {
                            })
                            .foregroundColor(.white)
                        
                        ForEach(request.saveRequestDetails) { balance in
                            HStack {
                                Image("Waste_\(balance.wasteName)")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Text("\(balance.wasteName)")
                                    .foregroundColor(.white)
                                    .fontWeight(.heavy)
                                
                                Spacer()
                                Text("\(String(format: "%.2f", balance.amount)) Kg")
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 35)
                        }
                        
                        Rectangle()
                            .frame(width: ScreenSize.width * 0.9, height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .onAppear(perform: {
                            })
                            .foregroundColor(.white)
                        
                        HStack(spacing: 30) {
                            Button(action: {
                                //Accept Request Function
                                self.acceptSaveRequest()
                            }){
                                Image(systemName: "checkmark.circle")
                                    .resizable()
                                    .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.init(hex: "3DD598"))
                            }
                            
                            Button(action: {
                                //Decline Request Function
                                self.declineSaveRequest()
                            }){
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.init(hex: "FF575F"))
                            }
                        }
                    }
                    
                }
                

            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Permintaan Setor\nBerhasil Ditolak!"), message: Text("Tekan 'OK' untuk melanjutkan"), dismissButton: .default(Text("OK")) {
                //
                self.fetchAdminSaveRequest()
            })
        }
        .alert(isPresented: $showingSuccessAlert) {
            Alert(title: Text("Permintaan Setor\nBerhasil Disetujui!"), message: Text("Tekan 'OK' untuk melanjutkan"), dismissButton: .default(Text("OK")) {
                //
                self.fetchAdminSaveRequest()
            })
        }
        .onAppear(perform: {
            self.formattedRequestDate = String(request.createdAt.prefix(10))
            
            self.wasteCount = request.saveRequestDetails.count
            self.statusColorHex = calculateStatusColor()
        })
    }
    
    func calculateStatusColor() -> String {
        if request.status == "Disetujui" {
            return "3DD598"
        }
        else if request.status == "Ditolak" {
            return "FF575F"
        }
        else if request.status == "Menunggu Persetujuan" {
            return "f5bd03"
        }

        return "dfe4e4"
    }
    
    func acceptSaveRequest() {
        let jsonBody : [String : Any] = ["status" : "Disetujui"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "\(DBConnection.url)/save-request-headers/\(request.id)") else {
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
                print("Accept Saving Request Header Status code:  \(response.statusCode)")
                
                if response.statusCode == 200 {
                    //Show Alert
                    self.showingSuccessAlert = true
                    
                    //Update balance ke user
                    
                }
            }
                        
        }.resume()
    }

    func fetchSavingData() {
        guard let url = URL(string: "\(DBConnection.url)/savings?users_permissions_user.id=\(request.usersPermissionsUser.id)") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let response = try? JSONDecoder().decode([Saving].self, from: data) {
                    DispatchQueue.main.async {
                        self.savingList = response
                        
                    }
                    
                }
                else {
                    print("JSON Decode fail")
                }
            }
            
        }.resume()
    }
    
    func declineSaveRequest() {
        let jsonBody : [String : Any] = ["status" : "Ditolak"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "\(DBConnection.url)/save-request-headers/\(request.id)") else {
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
                print("Decline Saving Request Header Status code:  \(response.statusCode)")
                
                if response.statusCode == 200 {
                    //Show Alert
                    self.showingAlert = true
                }
            }
                        
        }.resume()
    }
    
    func fetchAdminSaveRequest() {
        print("Getting admin save request data...")
        guard let url = URL(string: "\(DBConnection.url)/save-request-headers?status_contains=menunggu") else {
            print("invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let response = try? JSONDecoder().decode([SaveRequestHeader].self, from: data) {
                    DispatchQueue.main.async {
                        self.saveRequestList = response
                        
                        self.saveRequestList.reverse()
                    }
                    
                }
                else {
                    print("JSON Decode fail")
                }
            }
            
            
        }.resume()
    }

}

struct AdminSaveRequestRow_Previews: PreviewProvider {
    static var previews: some View {
        AdminSaveRequestRow(request: ModelData().saveRequestHeaders[0], saveRequestList: .constant(ModelData().saveRequestHeaders))
    }
}
