//
//  ArticleBankSampah.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 25/06/21.
//

import SwiftUI

struct ArticleBankSampah: View {
    @State var isShowingReadMore = false
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.init(hex: "2a7e63"))
                .padding()
            
            VStack {
                Text("Apa Sih Bank Sampah Itu?")
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.top, 20)
                
                
                Image("ArticleBankSampah-2")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("Bank sampah adalah suatu tempat yang digunakan untuk mengumpulkan sampah yang sudah dipilah-pilah. Hasil dari pengumpulan sampah yang sudah dipilah akan disetorkan ke tempat pembuatan kerajinan dari sampah atau ke tempat pengepul sampah. Bank sampah dikelola menggunakan sistem seperti perbankkan yang dilakukan oleh petugas sukarelawan. Penyetor adalah warga yang tinggal di sekitar lokasi bank serta mendapat buku tabungan seperti menabung di bank.")
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
            ArticleBankSampahExt(isShowingReadMore: $isShowingReadMore)
        }
    }
}

struct ArticleBankSampah_Previews: PreviewProvider {
    static var previews: some View {
        ArticleBankSampah()
    }
}

struct ArticleBankSampahExt : View {
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
                    
                    Text("Apa Sih Bank Sampah Itu?")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(Color.white)
                        .padding()
                }
                
                Text("Bank sampah adalah suatu tempat yang digunakan untuk mengumpulkan sampah yang sudah dipilah-pilah. Hasil dari pengumpulan sampah yang sudah dipilah akan disetorkan ke tempat pembuatan kerajinan dari sampah atau ke tempat pengepul sampah. Bank sampah dikelola menggunakan sistem seperti perbankkan yang dilakukan oleh petugas sukarelawan. Penyetor adalah warga yang tinggal di sekitar lokasi bank serta mendapat buku tabungan seperti menabung di bank. \n\nLatar belakang Bank sampah berdiri karena adanya keprihatinan masyarakat akan lingkungan hidup yang semakin lama semakin dipenuhi dengan sampah baik organik maupun anorganik. Sampah yang semakin banyak tentu akan menimbulkan banyak masalah, sehingga memerlukan pengolahan seperti membuat sampah menjadi bahan yang berguna. Pengelolaan sampah dengan sistem bank sampah ini diharapkan mampu membantu pemerintah dalam menangani sampah dan meningkatkan ekonomi masyarakat. \n\nTujuan utama pendirian bank sampah adalah untuk membantu menangani pengolahan sampah di Indonesia. Tujuan bank sampah selanjutnya adalah untuk menyadarkan masyarakat akan lingkungan yang sehat, rapi, dan bersih.")
                    .padding([.leading, .bottom, .trailing], 30)
                    .foregroundColor(Color.white)
            }
        }
    }
}
