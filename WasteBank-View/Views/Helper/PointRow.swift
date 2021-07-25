//
//  PointRow.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 28/06/21.
//

import SwiftUI

struct PointRow: View {
    
    var pointTransaction : PointTransaction
    
    @State var description: String = "Correct Answer"
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(20)
                .foregroundColor(Color.init(hex: "2a7e63"))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                .frame(width: ScreenSize.width * 0.9, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(pointTransaction.name)")
                        .bold()
                        .font(.system(size: 32)) 
                        .foregroundColor(.white)
                    
                    Text("\(description)")
                        .bold()
                        .font(.system(size: 18))
                        .foregroundColor(Color.init(hex: "3ED598"))
                }
                
                Spacer()
                
                VStack {
                    Text("\(pointTransaction.amount)")
                        .bold()
                        .font(.system(size: 30))
                        .foregroundColor(Color.init(hex: "3ED598"))
                    
                    Text("PTS")
                        .bold()
                        .font(.system(size: 22))
                        .foregroundColor(Color.init(hex: "D2D2D2"))

                }
            }
            .padding(.horizontal, 35)
            .padding(.vertical)
        }
        .onAppear(perform: {
            if pointTransaction.name == "Game Point" {
                description = "\(pointTransaction.amount / 10) Correct Answer"
            }
        })
    }
}

struct PointRow_Previews: PreviewProvider {
    static var previews: some View {
        PointRow(pointTransaction: ModelData().pointTransactions[0])
    }
}
