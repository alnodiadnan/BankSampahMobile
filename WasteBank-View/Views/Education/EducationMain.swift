//
//  EducationMain.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 24/06/21.
//

import SwiftUI

struct EducationMain: View {
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    
    @State var isShowingArticleBankSampah = false
    @State var isShowingArticleJenisSampah = false
    @State var isShowingArticlePengolahanSampah = false
    @State var isShowingPointHistory = false
    @State var isShowingQuiz = false
    
    @State var scaleXY : CGFloat = 1
    
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(hex: "22343C")
                    .ignoresSafeArea()
                
                NavigationLink(destination: ArticleBankSampah(), isActive: $isShowingArticleBankSampah) {
                    EmptyView()
                }
                
                NavigationLink(destination: ArticleJenisSampah(), isActive: $isShowingArticleJenisSampah) {
                    EmptyView()
                }
                
                NavigationLink(destination: ArticlePengolahanSampah(), isActive: $isShowingArticlePengolahanSampah) {
                    EmptyView()
                }
                
                NavigationLink(destination: EducationQuiz(isShowingQuiz: $isShowingQuiz), isActive: $isShowingQuiz) {
                    EmptyView()
                }
                
                NavigationLink(destination: PointHistory(), isActive: $isShowingPointHistory) {
                    EmptyView()
                }
                
                ScrollView {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(Color.init(hex: "3ED598"))
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image("ArticleBankSampah")
                                    .resizable()
                                    .opacity(0.85)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    //.scaledToFit()
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Text("Apa sih bank\nsampah itu?")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding(.top, 100)
                            }
                            .onTapGesture {
                                self.isShowingArticleBankSampah.toggle()
                            }
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(Color.init(hex: "3ED598"))
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image("ArticleJenisSampah")
                                    .resizable()
                                    .opacity(0.85)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    //.scaledToFit()
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Text("Udah tau jenis\nsampah belum?")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding(.top, 100)
                            }
                            .onTapGesture {
                                self.isShowingArticleJenisSampah.toggle()
                            }
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(Color.init(hex: "3ED598"))
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image("ArticlePengolahanSampah")
                                    .resizable()
                                    .opacity(0.85)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    //.scaledToFit()
                                    .frame(width: ScreenSize.width * 0.38, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Text("Tau gak sampah\nbisa diolah?")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding(.top, 100)
                            }
                            .onTapGesture {
                                self.isShowingArticlePengolahanSampah.toggle()
                            }
                            
                            
                        }
                        .padding()
                        .padding(.bottom, 50)
                    }
                    
                    //Text("-Diluar ScrollView-")
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.init(hex: "3ED598"))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                            .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        MemberProfilePicture(image: Image("Placeholder_MemberProfilePicture"))
                            .frame(width: 120, height: 120)
                            .offset(y: -80)
                            .onTapGesture {
                                self.tabSelection = 2
                            }
                        
                        VStack(spacing: 0) {
                            Text("\(userLoggedOnInfo.fullname)")
                                .font(.system(size: 24))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.top, 75)
                                .onTapGesture {
                                    self.tabSelection = 2
                                }
                            
                            Rectangle()
                                .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.001, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.top, 10)
                                .foregroundColor(.white)
                            
                            HStack {
//                                HStack {
//                                    Image("Placeholder")
//                                        .resizable()
//                                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//
//                                    Text("#Medal")
//                                        .bold()
//                                        .foregroundColor(.white)
//                                }
//                                //.padding(.trailing, 30)
//
//                                Rectangle()
//                                    .frame(width: ScreenSize.width * 0.002, height: 65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                    .padding(.horizontal, 30)
                                Button(action: {
                                    self.isShowingPointHistory.toggle()
                                }){
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.init(hex: "F9FE00"))
                                        
                                        Text("\(userLoggedOnInfo.point)")
                                            .fontWeight(.heavy)
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding([.top, .trailing], 10)
                            }
                        }
                    }
                    
                    //Play Game Button
                    Button(action: {
                        self.isShowingQuiz.toggle()
                        self.scaleXY = 1
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.init(hex: "fe565e"))
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                                .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            HStack {
                                VStack(spacing: 25) {
                                    Text("Mari Bermain!")
                                        .fontWeight(.heavy)
                                        .font(.system(size: 22))
                                        .foregroundColor(.white)
                                    
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .scaleEffect(scaleXY)
                                        //.animation(Animation.easeIn(duration: 3).repeatForever().speed(4))
                                        .animation(.easeInOut(duration: 0.5).repeatForever(), value: scaleXY)
                                        .onAppear() {
                                            if scaleXY > 1.2 {
                                                scaleXY = 1
                                            }
                                            scaleXY += 0.3
                                        }
                                }
//                                .onAppear(perform: {
//                                    sca
//                                })
                                
                                Image("QuizLogo")
                                    .resizable()
                                    .frame(width: 180, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            
                        }
                    }
                    .padding(.top, 20)
                }
                .navigationTitle("Education")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(Color.init(hex: "22343C").uiColor())
                //.navigationBarColor(backgroundColor: UIColor.init(hexString: "22343C"), titleColor: .white)
            }
        }
        .foregroundColor(.black)
    }
}

struct EducationMain_Previews: PreviewProvider {
    static var previews: some View {
        EducationMain(tabSelection: .constant(1))
            .environmentObject(UserLoggedOnInfo())
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


