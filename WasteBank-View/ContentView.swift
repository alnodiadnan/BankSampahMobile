//
//  ContentView.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 07/05/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    @State var tabSelection = 0
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.init(hexString: "30444E")
        //UITabBar.appearance().barTintColor = UIColor.gray
    }
    
    var body: some View {
        //MemberList(members: ModelData().members)
        //MemberLogin()
        TabView (selection: $tabSelection) {
            if(userLoggedOnInfo.isLoggedIn){
                Home(tabSelection: $tabSelection)
                    .tabItem {
                        Label("Beranda", systemImage: "house")
                        //Image(systemName: "house")
                            
                    }
                    .tag(0)
            }
            
            
            if (userLoggedOnInfo.isLoggedIn && userLoggedOnInfo.type == "Admin") {
                AdminMenu(tabSelection: $tabSelection)
                    .tabItem {
                        Label("Admin", systemImage: "square.grid.2x2")
                    }
                    .tag(4)
            }
            else if userLoggedOnInfo.isLoggedIn {
                EducationMain(tabSelection: $tabSelection)
                    .tabItem {
                        Label("Belajar", systemImage: "circle")
                    }
                    .tag(1)
            }
            
            
            
            if (userLoggedOnInfo.isLoggedIn) {
                MemberProfile(tabSelection: $tabSelection)
                    .tabItem {
                        Label("Profil", systemImage: "person.crop.square")
                    }
                    .tag(2)
            }
            else {
                MemberLogin(tabSelection: $tabSelection)
                    .tabItem {
                        Label("Login", systemImage: "person.crop.square")
                    }
                    .tag(3)
            }
                
        }
        .onChange(of: tabSelection, perform: { value in
            print("Tab selected: \(tabSelection)")
            
            if (tabSelection == 0){
                //Pop home tab to RootView
                
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserLoggedOnInfo())
    }
}


extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
