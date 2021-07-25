//
//  SellWaste.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 12/06/21.
//

import SwiftUI

struct SellWaste: View {
    var waste : Waste
    
    @State var buyerName: String = ""
    @State var sellPrice: String = ""
    @State var savingList: [Saving] = [Saving]()
    @State var showingAlert: Bool = false
    @Binding var isShowingSellPage : Bool
    
    var body: some View {
        VStack {
            Text("*Penjualan*")
                .bold()
                .underline()
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.clear)
                
                VStack {
                    HStack {
                        //                Rectangle()
                        //                    .fill(Color.black)
                        //                    .frame(width: ScreenSize.width * 0.15, height: ScreenSize.height * 0.075)
                        //                    .padding(.leading, 10)
                        
                        Image("Saving_\(waste.name)")
                            .resizable()
                            .frame(width: ScreenSize.width * 0.15, height: ScreenSize.height * 0.075)
                        //.padding(.leading, )
                        //.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        Text(waste.name)
                            .foregroundColor(.black)
                        
                        Text("\(String(format: "%.2f", waste.totalSavingAmount)) Kg")
                            .padding(.leading, 115)
                        
                        //Spacer()
                        
                    }
                    .padding()
                
                    
                }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }
            
            HStack(spacing: 0) {
                Text("Pembeli: ")
                    .bold()
                
                TextField("Nama Pembeli", text: $buyerName)
                    //.padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.gray).opacity(0.5))
            }
            .padding()
            
            HStack(spacing: 0){
                Text("Harga Jual:  Rp ")
                    .bold()
                
                TextField("", text: $sellPrice)
                    //.padding(.trailing)
                    .keyboardType(.numberPad)
                    .padding(.vertical, 5)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.gray).opacity(0.5))
            }
            .padding([.leading, .bottom, .trailing])
            
            Button(action: {
                self.sellWaste()
                self.showingAlert.toggle()
            }) {
                Text("Confirm")
            }
            
        }
        .onAppear(perform: {
            self.fetchSavingData()
        })
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("Penjualan Berhasil!"), message: Text("Jenis sampah: \(waste.name)\n Jumlah: \(String(format: "%.2f", waste.totalSavingAmount)) kg\nPembeli: \(buyerName)\nHarga jual: Rp \(Double(sellPrice)!.formattedWithSeparator)"), dismissButton: .default(Text("OK")))
//        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Penjualan Berhasil!"), message: Text("Jenis sampah: \(waste.name)\n Jumlah: \(String(format: "%.2f", waste.totalSavingAmount)) kg\nPembeli: \(buyerName)\nHarga jual: Rp \(Double(sellPrice)!.formattedWithSeparator)"), dismissButton: .default(Text("OK")) {
                self.isShowingSellPage.toggle()
            })
        }
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
        let jsonBodyA : [String : Any] = ["amount" : waste.totalSavingAmount, "buyer" : buyerName, "earning" : sellPrice, "waste" : ["id" : waste.id]]
        
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
            }
        }.resume()
    }
    
    func fetchSavingData() {
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
}


struct SellWaste_Previews: PreviewProvider {
    static var previews: some View {
        SellWaste(waste: ModelData().wastes[1], isShowingSellPage: .constant(true))
    }
}
