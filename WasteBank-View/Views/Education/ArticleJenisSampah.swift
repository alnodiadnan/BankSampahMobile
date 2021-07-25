//
//  ArticleJenisSampah.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 26/06/21.
//

import SwiftUI

struct ArticleJenisSampah: View {
    @State var isShowingReadMore = false
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.init(hex: "2a7e63"))
                .padding()
            
            VStack {
                Text("Udah Tau Jenis Sampah Belum?")
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.top, 30)
                
                
                Image("ArticleJenisSampah-2")
                    .resizable()
                    .frame(width: 250, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
               
                Text("1.Sampah Organik - Dapat Diurai (Degradable)\n\n2. Sampah Anorganik - Tidak Terurai (Undegradable)\n\n3. Bahan Berbahaya dan Beracun (B3)")
                    .bold()
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
            ArticleJenisSampahExt(isShowingReadMore: $isShowingReadMore)
        }
    }
}

struct ArticleJenisSampah_Previews: PreviewProvider {
    static var previews: some View {
        ArticleJenisSampah()
    }
}

struct ArticleJenisSampahExt : View {
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
                    
                    Text("Udah Tau Jenis Sampah Belum?")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(Color.white)
                        .padding()
                }
                
                Text("Sampah Organik - dapat diurai (degradable)\nyaitu sampah yang mudah membusuk seperti sisa makanan, sayuran, daun-daun kering, dan sebagainya. Sampah ini dapat diolah lebih lanjut menjadi kompos.\n\nContohnya: Daun, kayu, kulit telur, bangkai hewan, bangkai tumbuhan, kotoran hewan dan manusia, Sisa makanan, Sisa manusia. kardus, kertas dan lain-lain.\n\nSampah Anorganik - tidak terurai (undegradable)\nyaitu sampah yang tidak mudah membusuk, seperti plastik wadah pembungkus makanan, kertas, plastik mainan, botol dan gelas minuman, kaleng, kayu, dan sebagainya. Sampah ini dapat dijadikan sampah komersial atau sampah yang laku dijual untuk dijadikan produk laiannya. Beberapa sampah anorganik yang dapat dijual adalah plastik wadah pembungkus makanan, botol dan gelas bekas minuman, kaleng, kaca, dan kertas, baik kertas koran, HVS, maupun karton.\n\nBahan Berbahaya dan Beracun (B3)\nyaitu limbah dari bahan-bahan berbahaya dan beracun seperti limbah rumah sakit, limbah pabrik dan lain-lain.")
                    .padding([.leading, .bottom, .trailing], 30)
                    .foregroundColor(Color.white)
            }
        }
    }
}
