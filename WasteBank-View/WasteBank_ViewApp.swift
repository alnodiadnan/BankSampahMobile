//
//  WasteBank_ViewApp.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 07/05/21.
//

import SwiftUI

@main
struct WasteBank_ViewApp: App {
    var userLoggedOnInfo = UserLoggedOnInfo()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userLoggedOnInfo)
            //SavingDetail(savingSelected: <#Binding<Saving>#>)
        }
    }
}
