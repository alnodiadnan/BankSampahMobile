//
//  AdminSaveRequestList.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 23/07/21.
//

import SwiftUI

struct AdminSaveRequestList: View {
    @State var saveRequestList : [SaveRequestHeader] = []
    @State var searchText = ""
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            ScrollView {
                if saveRequestList.isEmpty {
                    
                }
                else  {
                    SearchBar(text: $searchText, autoCapital: true)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    
                    VStack(spacing: 20){
                        ForEach(saveRequestList.filter({ searchText.isEmpty ? true : $0.usersPermissionsUser.fullname.uppercased().contains(searchText.uppercased()) })) { request in
                            AdminSaveRequestRow(request: request, saveRequestList: $saveRequestList)
                        }
                    }
                    
                }
               
            }
        }
        .onAppear(perform: {
            self.fetchAdminSaveRequest()
        })
    }
    
    func fetchAdminSaveRequest() {
        print("Getting admin save request data...")
        guard let url = URL(string: "\(DBConnection.url)/save-request-headers?status_contains=menunggu") else {
            print("invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let response = try? JSONDecoder().decode([SaveRequestHeader].self, from: data) {
                    DispatchQueue.main.async {
                        self.saveRequestList = response
                        
                        self.saveRequestList.reverse()
                    }
                    
                }
                else {
                    print("JSON Decode fail")
                }
            }
            
            
        }.resume()
    }
}

struct AdminSaveRequestList_Previews: PreviewProvider {
    static var previews: some View {
        AdminSaveRequestList()
    }
}
