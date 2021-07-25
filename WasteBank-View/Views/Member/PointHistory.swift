//
//  PointHistory.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 14/07/21.
//

import SwiftUI

struct PointHistory: View {
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    
    @State var pointTransactions : [PointTransaction] = []
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            VStack{
                HStack {
                    Text("Point")
                        .fontWeight(.heavy)
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Color.init(hex: "F9FE00"))
                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Text("\(userLoggedOnInfo.point)")
                        .fontWeight(.heavy)
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                
                ScrollView {
                    if !pointTransactions.isEmpty {
                        ForEach(pointTransactions) { transaction in
                            PointRow(pointTransaction: transaction)
                        }
                    }
                    else {
                        Text("Kamu belum memiliki history pendapatan point")
                            .fontWeight(.heavy)
                            .font(.system(size: 20))
                            .foregroundColor(Color.init(hex: "D2D2D2"))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.horizontal, 20)
                            .offset(y: 300)
                    }
                    
                    
                }
            }
            
        }
        .onAppear(perform: {
            //fetch point history
            self.fetchPointHistory()
        })
    }
    
    func fetchPointHistory() {
        print("Getting point history data...")
        guard let url = URL(string: "\(DBConnection.url)/point-transactions?users_permissions_user=\(userLoggedOnInfo.id)") else {
            print("invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let response = try? JSONDecoder().decode([PointTransaction].self, from: data) {
                    DispatchQueue.main.async {
                        self.pointTransactions = response
                        
                        self.pointTransactions.reverse()
                    }
                    
                }
                else {
                    print("JSON Decode fail")
                }
            }
            
            
        }.resume()
    }
}

struct PointHistory_Previews: PreviewProvider {
    static var previews: some View {
        PointHistory()
            .environmentObject(UserLoggedOnInfo())
    }
}
