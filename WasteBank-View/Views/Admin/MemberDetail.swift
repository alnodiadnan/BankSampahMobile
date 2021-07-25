//
//  MemberDetail.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 10/05/21.
//

import SwiftUI

struct MemberDetail: View {
    @EnvironmentObject var modelData : ModelData
    @State var showAddBalanceModalView : Bool
    //@State private var isShowingNavBar : Bool = false
    
    @State var savingList : [Saving] = []
    @State var member : Member
    
    @State var totalEarning : Double = 0
    @State var formattedJoinDate : String = ""
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.init(hex: "3ED598"))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                        .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    MemberProfilePicture(image: Image("Placeholder_MemberProfilePicture"))
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        .frame(width: 120, height: 120)
                        .offset(y: -80)
                        
                    VStack {
                        Text("\(member.fullname)")
                            .fontWeight(.heavy)
                            .font(.system(size: 26))
                            .foregroundColor(.white)
                        
                        Text("Bergabung sejak \(formattedJoinDate)")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                            //.foregroundColor(Color.init(hex: "9aa49d"))
                        
                        HStack {
                            Image(systemName: "creditcard")
                                .foregroundColor(Color.init(hex: "262f56"))
                            
                            Text("Rp \(totalEarning.formattedWithSeparator)")
                        }
                        .padding(.top, 5)
                    }
                    .padding(.top, 60)
                }
                .padding(.top, 60)
                
                
                ForEach(savingList){ saving in
                    SavingRow(saving: saving)
                }
                
                if savingList.isEmpty {
                    Text("Belum memiliki tabungan sampah")
                        .fontWeight(.heavy)
                        .font(.system(size: 28))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.top, 100)
                }
                //.offset(y: 30)
                
                Spacer()
            }
            .navigationBarItems(trailing:
                Button(action: {
                    print("Add Balance button was tapped")
                    showAddBalanceModalView = true
                }){
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showAddBalanceModalView) {
                AddBalance(isPresented: $showAddBalanceModalView, memberSelected: $member, savingList: $savingList)
            }
            //.navigationBarTitleDisplayMode(.automatic)
            //        .navigationBarHidden(isShowingNavBar)
            //        .statusBar(hidden: isShowingNavBar)
            .onAppear(perform: {
                totalEarning = 0
                formattedJoinDate = String(member.createdAt.prefix(10))
                
                self.fetchMemberSavingData()
        })
        }
        
    }
    
    func fetchMemberSavingData() {
        print("Getting Member's Saving...")
        
        let searchField = "users_permissions_user.id"
        let queryItems = [URLQueryItem(name: searchField, value: String(member.id))]
        var urlComps = URLComponents(string: "\(DBConnection.url)/savings")
        urlComps?.queryItems = queryItems
        let urlResult = urlComps?.url
        print("URL fetch saving: \(String(describing: urlResult))")
        
        let request = URLRequest(url: urlResult!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Saving].self, from: data) {
                    DispatchQueue.main.async {
                        self.savingList = response
                        //print(membersList)
                        
                        //Count totalEarning
                        for saving in savingList {
                            self.totalEarning += saving.earning
                        }
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



struct MemberDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MemberDetail(showAddBalanceModalView: false, member: ModelData().members[0])
                .previewDevice("iPhone 11")
//
//            MemberDetail(showAddBalanceModalView: false, member: ModelData().members[1])
        }
    }
}

struct SavingRowB: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.gray)
            
            HStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: ScreenSize.width * 0.15, height: ScreenSize.height * 0.075)
                
                
                Text("*Balance*")
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
            }
            .padding(25)
        }
    }
}
