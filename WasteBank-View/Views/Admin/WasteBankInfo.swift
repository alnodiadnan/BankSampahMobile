//
//  WasteBankInfo.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 06/07/21.
//

import SwiftUI

struct WasteBankInfo: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .frame(width: ScreenSize.width * 0.85, height: ScreenSize.height * 0.18)
            
            HStack(spacing: 20){
                Image("ArticleBankSampah")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.init(hex: "25C685"), lineWidth: 2))
                    .shadow(radius: 7)
                    
                VStack(alignment: .leading) {
                    Text("Bank Sampah\nGAWE RUKUN")
                        .bold()
                        .font(.system(size: 20))
                    
                    Text("Alamat:\nJl. Camar, Kunciran Indah,\nKecamatan Pinang,\nKota Tangerang, Banten")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
        }
    }
}

struct WasteBankInfo_Previews: PreviewProvider {
    static var previews: some View {
        WasteBankInfo()
    }
}
