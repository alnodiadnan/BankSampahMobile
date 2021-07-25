//
//  AdminStatistic.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 06/07/21.
//

import SwiftUI

struct AdminStatistic: View {
    
    @State var sellTransactionList = [SellTransaction]()
    
    @State var revenueTotal : Double = 0
    @State var memberCount : Int = 0
    
    @Binding var wasteWeightTotal : Double
    //@Binding var wasteList : [Waste]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.init(hex: "30444E"))
                .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            HStack {
                VStack(alignment: .leading, spacing: 7) {
                    Text("Statistik")
                        .fontWeight(.heavy)
                        //.bold()
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.init(hex: "36AE7E"))
                            .frame(width: 15, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text("Anggota : \(memberCount) orang")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.init(hex: "36AE7E"))
                            .frame(width: 15, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text("Pendapatan : Rp \(revenueTotal.formattedWithSeparator)")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.init(hex: "36AE7E"))
                            .frame(width: 15, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text("Total Sampah : \(String(format: "%.2f", wasteWeightTotal)) / 2000 kg")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                }
                
                Image(systemName: "chart.bar.xaxis")
                    .resizable()
                    .foregroundColor(Color.init(hex: "36AE7E"))
                    .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
            }
        }
        .onAppear(perform: {
            
            
            self.fetchSellTransactionData()
            self.fetchMembersTotal()
        })
    }
    
    func fetchSellTransactionData() {
        print("Getting sell transactions data...")
        revenueTotal = 0
        
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
                        
                        for transaction in sellTransactionList {
                            revenueTotal = revenueTotal + transaction.earning
                        }
                    }
                    return
                    
                }
                else {
                    print("Sell Transaction JSON Decode Fail")
                }
            }
        }.resume()
    }
    
    func fetchMembersTotal() {
        guard let url = URL(string: "\(DBConnection.url)/users/count?type=Member") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(Int.self, from: data) {
                    DispatchQueue.main.async {
                        self.memberCount = response
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

struct AdminStatistic_Previews: PreviewProvider {
    static var previews: some View {
        AdminStatistic(wasteWeightTotal: .constant(0))
    }
}
