//
//  SellHistory.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 20/06/21.
//

import SwiftUI

struct SellHistory: View {
    @State var sellTransactionList = [SellTransaction]()
    
    var body: some View {
        ScrollView {
//            Text("Riwayat Transaksi Penjualan")
//                .font(.system(size: 24))
//                .bold()
//                .padding(.bottom, 15)
            
            //List penjualan
            ForEach(sellTransactionList) { transaction in
                SellTransactionRow(transaction: transaction)
                    .padding(.bottom, 10)
            }
            
            
        }
        .padding(.top, 10)
        .onAppear(perform: {
            
            //Fetch Sell Transaction List
            self.fetchSellTransactionData()
        })
        
    }
    
    func fetchSellTransactionData() {
        print("Getting sell transactions data...")
        
        guard let url = URL(string: "\(DBConnection.url)/sell-transactions") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([SellTransaction].self, from: data) {
                    DispatchQueue.main.async {
                        self.sellTransactionList = response
                        //print(membersList)
                        
                        self.sellTransactionList.reverse()
                    }
                    return
                    
                }
                else {
                    print("Sell Transaction JSON Decode Fail")
                }
            }
        }.resume()
    }
}

struct SellHistory_Previews: PreviewProvider {
    static var previews: some View {
        SellHistory(sellTransactionList: ModelData().sellTransactions)
    }
}

struct SellTransactionRow: View {
    var transaction : SellTransaction
    @State var formattedTransactionDate = "*Date*"
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                //.border(Color.white, width: 3)
                //.cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                .foregroundColor(Color.init(hex: "2e8267"))
                .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(transaction.buyer)")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("\(transaction.waste.name)")
                            .bold()
                            .foregroundColor(Color.init(hex: "3DD598"))
                        
                        Text("Rp \(transaction.earning.formattedWithSeparator)")
                            .bold()
                            .foregroundColor(Color.init(hex: "D2D2D2"))
                    }
                    
                    Text("\(formattedTransactionDate)")
                        .foregroundColor(Color.init(hex: "262F56"))
                }
                
                Spacer()
                
                VStack {
                    Text("\(String(format: "%.2f", transaction.amount))")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(Color.init(hex: "3DD598"))
                    
                    Text("KG")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(Color.init(hex: "D2D2D2"))
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)
            
        }
        .onAppear(perform: {
            self.formattedTransactionDate = String(transaction.createdAt.prefix(10))
        })
    }
}



//VStack(alignment: .leading) {
//
//
//
//
//
//
//    Text("\(formattedTransactionDate)")
//        .font(.system(size: 16))
//        .bold()
//        .underline()
//        .padding(.top, 10)
//
//    HStack{
//        Text("Sampah : ")
//
//    }
//    .frame(width: ScreenSize.width * 0.85, alignment: .leading)
//    .padding(.top, 15)
//
//
//
//    HStack{
//        Text("Jumlah : ")
//        Text("\(String(format: "%.2f", transaction.amount)) Kg")
//            .frame(width: ScreenSize.width * 0.65, alignment: .trailing)
//    }
//    .frame(width: ScreenSize.width * 0.85, alignment: .leading)
//    .padding(.top, 15)
//
//    HStack{
//        Text("Harga Jual : ")
//        Text("Rp \(transaction.earning.formattedWithSeparator)")
//            .bold()
//            .frame(width: ScreenSize.width * 0.6, alignment: .trailing)
//
//    }
//    .frame(width: ScreenSize.width * 0.85, alignment: .leading)
//    .padding(.top, 15)
//}
