//
//  MemberSaveRequestRow.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 23/07/21.
//

import SwiftUI

struct MemberSaveRequestRow: View {
    var request : SaveRequestHeader
    
    @State var formattedRequestDate = "*Date*"
    
    @State var statusColorHex : String = ""
    
    @State var wasteCount : Int = 0
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            ZStack {
                Rectangle()
                    .cornerRadius(20)
                    .foregroundColor(Color.init(hex: "30444E"))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                    .frame(width: ScreenSize.width * 0.9, height: 90 + CGFloat(wasteCount * 30), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                VStack {
                    Text("\(String(request.status).uppercased())")
                        .fontWeight(.heavy)
                        .foregroundColor(Color.init(hex: statusColorHex))
                        .font(.system(size: 18))
                        .padding(.bottom, 5)
                        .frame(width: ScreenSize.width * 0.8)
                    
                    
                    Text("\(formattedRequestDate)")
                        .foregroundColor(Color.init(hex: "2a7e63"))
                        .fontWeight(.heavy)
                        .font(.system(size: 16))
                    
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
                }
                

            }
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
}

struct MemberSaveRequestRow_Previews: PreviewProvider {
    static var previews: some View {
        MemberSaveRequestRow(request: ModelData().saveRequestHeaders[0])
    }
}
