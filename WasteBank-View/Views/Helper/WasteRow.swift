//
//  WasteRow.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 10/06/21.
//

import SwiftUI

struct WasteRow: View {
    //var saving : Saving
    var waste : Waste
    //let formattedAmount = String(format: "%.2f", saving.amount)
    @State var extendView = false
    @State var isShowingSellPage = false
    @State var showingAlert = false
    
    @State var savingList: [Saving] = [Saving]()
    
    @State var buyerName: String = ""
    @State var sellPrice: String = ""
    
    @Binding var wasteList : [Waste]
    @Binding var isExtending : Bool
    
    var body: some View {
        ZStack {
            
            NavigationLink(destination: SellWaste(waste: waste, isShowingSellPage: $isShowingSellPage), isActive: $isShowingSellPage) {
                EmptyView()
            }
            
            RoundedRectangle(cornerRadius: 15)
                .frame(width: ScreenSize.width * 0.9, height: extendView ? ScreenSize.height * 0.275 : ScreenSize.height * 0.1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.init(hex: "30444E"))
                
        
            VStack {
                HStack {
    //                Rectangle()
    //                    .fill(Color.black)
    //                    .frame(width: ScreenSize.width * 0.15, height: ScreenSize.height * 0.075)
    //                    .padding(.leading, 10)
                    
                    Image("Waste_\(waste.name)")
                        .resizable()
                        .frame(width: ScreenSize.width * 0.15, height: ScreenSize.height * 0.065)
                        //.padding(.leading, )
                        //.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .padding(.leading, 10)
                        
                    Text(waste.name)
                        .foregroundColor(.white)
                        .padding(.leading, 30)
                    
                    Text("\(String(format: "%.2f", waste.totalSavingAmount)) Kg")
                        .bold()
                        .padding(.leading, 80)
                        //.padding(.trailing, 20)
                        .foregroundColor(.white)
                    
                    //Spacer()
                    
                    Image(systemName: extendView ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                    
                }
                .padding()
                .onTapGesture {
                    self.extendView.toggle()
                    self.isExtending.toggle()
                }
                
                if(extendView) {
                    Rectangle()
                        .frame(width: ScreenSize.width * 0.9, height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .onAppear(perform: {
                            self.fetchSavingData()
                        })
                    
                    Text("JUAL")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.top, 5)
                    
                    HStack {
                        VStack(spacing: 0) {
                            HStack {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.init(hex: "286053"))
                                        .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    
                                    Image(systemName: "person.fill")
                                        .foregroundColor(Color.init(hex: "3ED598"))
                                }
                                
                                ZStack(alignment: .leading) {
                                    if buyerName.isEmpty { Text("Nama Pembeli").foregroundColor(.gray).padding(.leading, 0) }
                                    
                                    TextField("Nama Pembeli", text: $buyerName)
                                        //.padding()
                                        .foregroundColor(.gray)
                                        .underlineTextField()
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                        //.border(Color.black, width: 2)
                                        //.padding(.top, 10)
                                        //.padding(.trailing, 50)
                                }
                            }
                            .padding(.leading, 40)
                            .frame(height: 45)
                            
                            HStack {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.init(hex: "286053"))
                                        .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    
                                    Image(systemName: "creditcard")
                                        .foregroundColor(Color.init(hex: "3ED598"))
                                }
                                
                                Text("Rp")
                                    .bold()
                                    .foregroundColor(.white)
                                
                                ZStack(alignment: .leading) {
                                    if sellPrice.isEmpty { Text("Harga Jual").foregroundColor(.gray).padding(.leading, 0) }
                                    
                                    TextField("Harga Jual", text: $sellPrice)
                                        //.padding()
                                        .foregroundColor(.gray)
                                        .underlineTextField()
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                        //.border(Color.black, width: 2)
                                        //.padding(.top, 10)
                                        //.padding(.trailing, 50)
                                }
                                //.offset(x: -10)
                            }
                            .padding(.leading, 40)
                            .frame(height: 45)
                            
                        }
                        
                        if !buyerName.isEmpty && !sellPrice.isEmpty {
                            Button(action: {
                               // self.isShowingSellPage.toggle()
                                self.showingAlert.toggle()
                                //Sell function
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                    self.sellWaste()
//                                }
                                self.sellWaste()
                                
                                
                                self.extendView.toggle()
                            }){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width: 110, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(Color.init(hex: "3ED598"))
                                        
                        
                                    Text("Confirm")
                                        .bold()
                                        .foregroundColor(.white)
                                }
                                
                            }
                            .padding(.trailing, 40)
                            .offset(y: 5)
                        }
                        else {
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 110, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.init(hex: "286053"))
                                    
                                Text("Confirm")
                                    .bold()
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 40)
                            .offset(y: 5)
                        }
                        
                    }
                    
                    
                }
                
            }

        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Penjualan Berhasil!"), message: Text("Jenis sampah: \(waste.name)\n Jumlah: \(String(format: "%.2f", waste.totalSavingAmount)) kg\nPembeli: \(buyerName)\nHarga jual: Rp \(Double(sellPrice)!.formattedWithSeparator)"), dismissButton: .default(Text("OK")) {
                self.sellWaste()
                //self.isShowingSellPage.toggle()
            })
        }
        //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
    
    func sellWaste() {
        
        for saving in savingList {
            let oldEarning = saving.earning
            let newEarning = (saving.amount / (waste.totalSavingAmount)) * Double(sellPrice)!
            
            let totalEarning = oldEarning + newEarning
            
            let jsonBody : [String : Any] = ["amount" : 0, "earning" : totalEarning]
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
            
            guard let url = URL(string: "\(DBConnection.url)/savings/\(saving.id)") else {
                print("Invalid URL")
                return
            }
            
            print("Update Saving Amount URL: \(url)")
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = jsonData
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let response = response as? HTTPURLResponse {
                    print("Update saving amount status code:  \(response.statusCode)")
                    
                    if response.statusCode == 200 {
                        self.createTransactionHistory(savingId: saving.id, amount: saving.amount, earning: newEarning)
                    }
                }
            }.resume()
            
            
        }
        
        //Create Sell Transaction History
        let jsonBodyA : [String : Any] = ["amount" : waste.totalSavingAmount, "buyer" : buyerName, "earning" : Double(sellPrice) as Any, "waste" : ["id" : waste.id]]
        
        let jsonDataA = try? JSONSerialization.data(withJSONObject: jsonBodyA)
        
        guard let url = URL(string: "\(DBConnection.url)/sell-transactions") else {
            print("Invalid URL")
            return
        }
        //print("Update TOTAL Saving Amount URL: \(url)")
        var requestA = URLRequest(url: url)
        requestA.httpMethod = "POST"
        requestA.httpBody = jsonDataA
        
        requestA.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestA.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: requestA) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("Create sell transaction status code:  \(response.statusCode)")
            }
        }.resume()
        
        //Set Waste amount to 0
        let jsonBody : [String : Any] = ["totalSavingAmount" : 0]
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        
        guard let url = URL(string: "\(DBConnection.url)/wastes/\(waste.id)") else {
            print("Invalid URL")
            return
        }
        print("Update TOTAL Saving Amount URL: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("Update total amount status code:  \(response.statusCode)")
                
                self.fetchAdminSavingData()
            }
        }.resume()
    }
    
    func fetchSavingData() {
        //print("Fetching saving data on click...")
        guard let url = URL(string: "\(DBConnection.url)/savings?waste.id=\(waste.id)") else {
            print("Invalid URL")
            return
        }
        
        print("Getting saving with URL: \(url)")
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let response = try? JSONDecoder().decode([Saving].self, from: data) {
                    DispatchQueue.main.async {
                        self.savingList = response
                    }
                    return
                }
                else {
                    print("JSON Decode Fail!")
                }
            }
        }.resume()
    }
    
    func createTransactionHistory(savingId : Int, amount: Double, earning : Double) {
        print("Creating Transaction History...")
        let jsonBody : [String : Any] = ["amount": amount, "type" : "Jual", "saving" : ["id" : savingId], "earning" : earning]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "\(DBConnection.url)/saving-transactions") else {
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
            
            if let response = response as? HTTPURLResponse {
                print("Create Transaction status code:  \(response.statusCode)")
            }
            
//            if let responseJSON = responseJSON as? [String: Any] {
//                print("Create Transaction History JSON Response: \n\(responseJSON)")
//            }
            
        }.resume()
    }
    
    func fetchAdminSavingData() {
        print("Masuk")
        guard let url = URL(string: "\(DBConnection.url)/wastes") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Waste].self, from: data) {
                    DispatchQueue.main.async {
                        self.wasteList = response
                        //print(membersList)
                        print("Fetch Admin selesai")
                        
                    }
                    return
                }
                else {
                    print("JSON Decode Fail!")
                }
                
            }
            
            
        }.resume()
    
    }
}

struct WasteRow_Previews: PreviewProvider {
    static var previews: some View {
        WasteRow(waste: ModelData().wastes[0], wasteList: .constant(ModelData().wastes), isExtending: .constant(false))
    }
}
