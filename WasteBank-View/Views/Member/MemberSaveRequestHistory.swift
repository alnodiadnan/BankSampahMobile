//
//  MemberSaveRequestHistory.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 23/07/21.
//

import SwiftUI

struct MemberSaveRequestHistory: View {
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    
    @State var saveRequestList : [SaveRequestHeader] = []
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            VStack{
                
                Text("Permintaan Setoran\nSampah")
                    .fontWeight(.heavy)
                    .font(.system(size: 34))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                ScrollView {
                    if !saveRequestList.isEmpty {
                        ForEach(saveRequestList) { request in
                            MemberSaveRequestRow(request: request)
                                .padding(.top, 10)
                        }
                    }
                    
                    else {
                        Text("Kamu belum memiliki permintaan setoran sampah")
                            .fontWeight(.heavy)
                            .font(.system(size: 20))
                            .foregroundColor(Color.init(hex: "D2D2D2"))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.horizontal, 20)
                            .offset(y: 300)
                    }
                }
                
            }
            
        }
        .onAppear(perform: {
            //fetch save request
            self.fetchMemberSaveRequest()
        })
    }
    
    func fetchMemberSaveRequest() {
        print("Getting member save request data...")
        guard let url = URL(string: "\(DBConnection.url)/save-request-headers?users_permissions_user.id=\(userLoggedOnInfo.id)") else {
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

struct MemberSaveRequestHistory_Previews: PreviewProvider {
    static var previews: some View {
        MemberSaveRequestHistory()
            .environmentObject(UserLoggedOnInfo())
    }
}
