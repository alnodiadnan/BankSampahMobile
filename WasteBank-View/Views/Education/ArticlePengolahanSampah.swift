//
//  ArticlePengolahanSamoah.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 26/06/21.
//

import SwiftUI

struct ArticlePengolahanSampah: View {
    @State var isShowingReadMore = false
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.init(hex: "2b7e63"))
                .padding()
            
            VStack {
                Text("Tau Gak Sampah Bisa Diolah?")
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.top, 30)
                
                Image("ArticlePengolahanSampah")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("Daur ulang adalah proses untuk menjadikan suatu bahan bekas menjadi bahan baru dengan tujuan mencegah adanya sampah yang sebenarnya dapat menjadi sesuatu yang berguna.")
                    //.scaledToFill()
                    //.multilineTextAlignment(NSTextAlignment.justified)
                    .padding(30)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Button(action: {
                    self.isShowingReadMore.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.init(hex: "40DF9F"))
                            .frame(width: ScreenSize.width * 0.85,height: ScreenSize.height * 0.075, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text("Baca lebih lanjut...")
                            .bold()
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.bottom, 50)

            }
            //.padding(.bottom, 50)
        }
        .sheet(isPresented: $isShowingReadMore) {
            ArticlePengolahanSampahExt(isShowingReadMore: $isShowingReadMore)
        }
    }
}

struct ArticlePengolahanSampah_Previews: PreviewProvider {
    static var previews: some View {
        ArticlePengolahanSampah()
    }
}

struct ArticlePengolahanSampahExt : View {
    @Binding var isShowingReadMore : Bool
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.init(hex: "2a7e63"))
                .padding()
            
            VStack {
                HStack {
                    Button(action: {
                        self.isShowingReadMore.toggle()
                    }) {
                        Image(systemName: "chevron.left")
                            //.resizable()
                            //.frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                    Text("Tau Gak Sampah Bisa Diolah?")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(Color.white)
                        .padding()
                }
                
                Text("Daur ulang adalah proses untuk menjadikan suatu bahan bekas menjadi bahan baru dengan tujuan mencegah adanya sampah yang sebenarnya dapat menjadi sesuatu yang berguna, mengurangi penggunaan bahan baku yang baru, mengurangi penggunaan energi, mengurangi polusi, kerusakan lahan, dan emisi gas rumah kaca jika dibandingkan dengan proses pembuatan barang baru. Daur ulang adalah salah satu strategi pengelolaan sampah padat yang terdiri atas kegiatan pemilahan, pengumpulan, pemprosesan, pendistribusian dan pembuatan produk/material bekas pakai, dan komponen utama dalam manajemen sampah modern dan bagian ketiga dalam proses hierarki sampah 4R (Reduce, Reuse, Recycle, and Replace). \n\nMaterial yang bisa didaur ulang terdiri dari sampah kaca, plastik, kertas, logam, tekstil, dan barang elektronik. Meskipun mirip, proses pembuatan kompos yang umumnya menggunakan sampah biomassa yang bisa didegradasi oleh alam, tidak dikategorikan sebagai proses daur ulang. Daur ulang lebih difokuskan kepada sampah yang tidak bisa didegradasi oleh alam secara alami demi pengurangan kerusakan lahan. Secara garis besar, daur ulang adalah proses pengumpulan sampah, penyortiran, pembersihan, dan pemprosesan material baru untuk proses produksi.")
                    .padding([.leading, .bottom, .trailing], 30)
                    .foregroundColor(Color.white)
            }
        }
    }
}
