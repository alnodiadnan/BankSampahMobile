//
//  MemberList.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 09/05/21.
//

import SwiftUI

struct MemberList: View {
    @EnvironmentObject var modelData : ModelData
    //var members : [Member]
    @State var membersList = [Member]()
    @State var searchText = ""
    
    var body: some View {
        VStack {
            
            SearchBar(text: $searchText, autoCapital: true)
                .padding(.top, 10)
                .padding(.horizontal, 20)
            
            VStack(spacing: 5) {
                ForEach(membersList.filter({ searchText.isEmpty ? true : $0.fullname.uppercased().contains(searchText.uppercased()) })) { member in
                    if (member.type == "Member") {
                        NavigationLink(destination: MemberDetail(showAddBalanceModalView: false, member: member)) {
                            MemberRow(member: member)
                        }
                        
                        Rectangle()
                            .frame(width: 280, height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.gray)
                            .padding(.leading, 85)
                            //.offset(y: -20)
                        //Divider()
                    }
                }
            }
            
            Spacer()
        }
        .onAppear(perform: {
            getRegisteredMembers()
            //self.membersList.filter({ searchText.isEmpty ? true : $0.username.contains(searchText) })
        })
        .navigationBarTitle("Menu Admin", displayMode: .inline)
        //.navigationTitle("Member List")

    }
    
    func getRegisteredMembers() {
        print("Getting registered members...")
        
        guard let url = URL(string: "\(DBConnection.url)/users") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Member].self, from: data) {
                    DispatchQueue.main.async {
                        self.membersList = response
                        //print(membersList)
                    }
                    return
                }
                else {
                    print("JSON Decode Fail!")
                }
            }
        }.resume()
    }
}

struct MemberList_Previews: PreviewProvider {
    static var previews: some View {
        MemberList(membersList: ModelData().members)
            .previewDevice("iPhone 11")
    }
}
