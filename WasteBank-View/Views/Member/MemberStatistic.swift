//
//  MemberStatistic.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 07/07/21.
//

import SwiftUI

struct MemberStatistic: View {
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    
    @Binding var revenueTotal : Double
    @Binding var amountTotal : Double
    
    //@Binding var savingList : [Saving]
    
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
                        
                        Text("Pendapatan : Rp \(revenueTotal.formattedWithSeparator)")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.init(hex: "36AE7E"))
                            .frame(width: 15, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text("Total sampah : \(String(format: "%.2f", amountTotal)) kg")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.init(hex: "36AE7E"))
                            .frame(width: 15, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text("Point : \(userLoggedOnInfo.point) pts")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                }
                .padding(.trailing, 40)
                
                
                Image(systemName: "chart.bar.xaxis")
                    .resizable()
                    .foregroundColor(Color.init(hex: "36AE7E"))
                    .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                    .padding(.leading, 20)
            }
        }
        .onAppear(perform: {
            

        })
    }
}

struct MemberStatistic_Previews: PreviewProvider {
    static var previews: some View {
        MemberStatistic(revenueTotal: .constant(0), amountTotal: .constant(0))
            .environmentObject(UserLoggedOnInfo())
    }
}
