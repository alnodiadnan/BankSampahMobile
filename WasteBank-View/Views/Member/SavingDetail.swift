//
//  BalanceDetail.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 18/05/21.
//

import SwiftUI

struct SavingDetail: View {
    @State var savingSelected : Saving
    @State var savingTransactionList = [SavingTransaction]()
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Image("Waste_\(savingSelected.type)")
                        .resizable()
                        .frame(width: ScreenSize.width * 0.15, height: ScreenSize.width * 0.15)
                    
                    Text("\(savingSelected.type)")
                        .fontWeight(.heavy)
                        .font(.system(size: 40))
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .foregroundColor(.white)
                }
                .padding()
                .padding(.trailing, 10)
                
                ScrollView {
                    ForEach(savingTransactionList) { transaction in
                        SavingTransactionHistory(transaction: transaction)
                    }
                }
                .padding(.top, 10)

            }
            .onAppear(perform: {
                self.getTransactionHistoryForSelectedSaving()
            })
            .navigationBarTitle("Riwayat Tabungan")
        }
        
    }
    
    func getTransactionHistoryForSelectedSaving() {
        print("Getting Transaction for saving with ID: \(savingSelected.id)...")
        
        guard let url = URL(string: "\(DBConnection.url)/saving-transactions?saving.id=\(savingSelected.id)") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([SavingTransaction].self, from: data) {
                    DispatchQueue.main.async {
                        self.savingTransactionList = response
                        //print(membersList)
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

struct BalanceDetail_Previews: PreviewProvider {
    static var previews: some View {
        SavingDetail(savingSelected: (ModelData().savings[1]), savingTransactionList: ModelData().savingTransactions)
    }
}

struct SavingTransactionHistory : View {
    var transaction : SavingTransaction
    @State var formattedTransactionDate = ""
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                //.border(Color.white, width: 3)
                //.cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                .foregroundColor(transaction.type == "Setor" ? Color.init(hex: "2e8267") : Color.init(hex: "793438"))
                .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            HStack {
                VStack(alignment: .leading, spacing : 5){
                    Text("\(transaction.type)")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                    
                    if(transaction.type == "Jual") {
                        Text("Rp \(transaction.earning.formattedWithSeparator)")
                            .foregroundColor(Color.init(hex: "3DD598"))
                    }
                    //FF575F
                    Text("\(formattedTransactionDate)")
                        .bold()
                        .foregroundColor(transaction.type == "Setor" ? Color.init(hex: "3DD598") : Color.init(hex: "FF575F"))
                    
//                    HStack (spacing: 50) {
//                        Text("\(transaction.type)")
//                            //.padding(.trailing, 60)
//
//                        if(transaction.type == "Jual") {
//                            Text("\(String(format: "-%.2f", transaction.amount)) Kg")
//                        }
//                        else {
//                            Text("\(String(format: "%.2f", transaction.amount)) Kg")
//                        }
//                            //.padding(.trailing)
//
//    //                    Text("Rp \(String(format: "%.0f", transaction.earning))")
//    //                        .padding(.leading, 90)
//
//    //                    Text("Rp \(transaction.earning)")
//    //                        .padding(.leading, 0)
//
//                        if(transaction.type == "Jual") {
//                            Text("Rp \(transaction.earning.formattedWithSeparator)")
//                                .padding(.leading, 0)
//                        }
//
//                    }
//
//                    .foregroundColor(transaction.type == "Setor" ? .black : .blue)
//                    .frame(width: ScreenSize.width * 0.90)
                }
                //.frame(width: ScreenSize.width * 0.90)
                
                Spacer()
                
                VStack {
                    Text("\(String(format: "%.2f", transaction.amount))")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(transaction.type == "Setor" ? Color.init(hex: "3DD598") : Color.init(hex: "FF575F"))
                    
                    Text("KG")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(Color.init(hex: "D2D2D2"))
                }
            }
            .padding(.horizontal, 40)
        }
        //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        .onAppear(perform: {
            self.formattedTransactionDate = String(transaction.createdAt.prefix(10))
        })
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Double {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

//ZStack {
//    RoundedRectangle(cornerRadius: 20)
//        .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//        .foregroundColor(.gray)
//
//    VStack {
//        Image("Waste_\(savingSelected.type)")
//            .resizable()
//            .frame(width: ScreenSize.width * 0.3, height: ScreenSize.width * 0.3)
//
//        Text("\(savingSelected.type)")
//            .font(.system(size: 20))
//            .scaledToFit()
//            .minimumScaleFactor(0.01)
//            .lineLimit(1)
//
//        Text("Jumlah Tabungan: \(String(format: "%.2f", savingSelected.amount)) Kg")
//            //.font(.system(size: 16))
//            .font(.subheadline)
//            .scaledToFit()
//            .minimumScaleFactor(0.01)
//            .lineLimit(1)
//            .padding(.top)
//    }
//
//
//}
