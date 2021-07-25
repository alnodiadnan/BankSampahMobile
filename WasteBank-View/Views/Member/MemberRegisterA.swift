//
//  MemberRegisterA.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 01/07/21.
//

import SwiftUI

struct MemberRegisterA: View {
    
    @State var fullName = ""
    @State var username = ""
    
    
    @State var isShowingRegisterPageB = false
    @Binding var isShowingRegisterPage : Bool
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            NavigationLink(destination: MemberRegisterB(isShowingRegisterPageB: $isShowingRegisterPageB, isShowingRegisterPage: $isShowingRegisterPage, username: $username, fullname: $fullName), isActive: $isShowingRegisterPageB){
                EmptyView()
            }

            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    Image("Logo")
                        .resizable()
                        .frame(width: 50, height: 75, alignment: .center)
                    
                    Text("Hello!")
                        .bold()
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    
                    Text("Mari perkenalkan dirimu")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    
                    Text("")
                        .frame(width: ScreenSize.width * 0.85)
                }
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "625B39"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundColor(Color.init(hex: "FFC542"))
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        if fullName.isEmpty { Text("Nama Lengkap").foregroundColor(.gray).padding(.leading, 15) }
                        
                        TextField("Nama Lengkap", text: $fullName)
                            .padding()
                            .foregroundColor(.gray)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .underlineTextField()
                            //.padding(.top, 10)
                            .padding(.trailing, 15)
                    }
                }
                .padding(.horizontal,20)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10)
                            .foregroundColor(Color.init(hex: "625B39"))
                            .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundColor(Color.init(hex: "FFC542"))
                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.leading, 10)
                    
                    ZStack(alignment: .leading) {
                        if username.isEmpty { Text("Nama Akun").foregroundColor(.gray).padding(.leading, 15) }
                        
                        TextField("Nama Akun", text: $username)
                            .padding()
                            .foregroundColor(.gray)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .underlineTextField()
                            //.padding(.top, 10)
                            .padding(.trailing, 15)
                    }
                }
                .offset(y: -10)
                .padding(.bottom, 10)
                .padding(.horizontal,20)
                
                HStack(spacing: 10) {
                    Button(action: {
                        //Go back to Login Page
                        self.isShowingRegisterPage = false
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(15)
                                .foregroundColor(Color.init(hex: "286053"))
                                .frame(width: ScreenSize.height * 0.065, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            Image(systemName: "arrow.left")
                                .resizable()
                                .foregroundColor(Color.init(hex: "3DD598"))
                                .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                    }
                    
                    if !username.isEmpty && !fullName.isEmpty {
                        Button(action: {
                            self.isShowingRegisterPageB = true
                        }) {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(15)
                                    .foregroundColor(Color.init(hex: "40DF9F"))
                                    .frame(width: ScreenSize.width * 0.65, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                HStack {
                                    Text("Lanjut")
                                        .bold()
                                        .foregroundColor(.white)
                                    
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }
                            }
                        }
                    }
                    else {
                        ZStack {
                            Rectangle()
                                .cornerRadius(15)
                                .foregroundColor(Color.init(hex: "286053"))
                                .frame(width: ScreenSize.width * 0.65, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            HStack {
                                Text("Lanjut")
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }
                    
                    
                    //.padding()
                }

                
//                NavigationLink(destination: MemberRegister(isShowingRegisterPage: $isShowingRegisterPage), isActive: $isShowingRegisterPage) {
//                    EmptyView()
//                }
                
//                NavigationLink(destination: MemberProfile(), isActive: $isShowingMemberProfilePage) {
//                    EmptyView()
//                }
                
            }
            .navigationTitle("Pendaftaran")
            .navigationBarTitle("Pendaftaran")
            .navigationBarColor(Color.init(hex: "22343C").uiColor())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct MemberRegisterA_Previews: PreviewProvider {
    static var previews: some View {
        MemberRegisterA(isShowingRegisterPage: .constant(true))
    }
}

struct NavigationBarModifier: ViewModifier {
        
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
 
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}

extension Color {
 
    func uiColor() -> UIColor {

        if #available(iOS 14.0, *) {
            return UIColor(self)
        }

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}
