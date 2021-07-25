//
//  Home.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 24/05/21.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    
//    @State var isShowingMemberList : Bool = false
//    @State var isShowingSellHistory : Bool = false
    @State var searchText = ""
    
    @State var revenueTotal : Double = 0
    @State var amountTotal : Double = 0
    @State var wasteWeightTotal : Double = 0
    
    @State var savingList = [Saving]()
    @State var wasteList = [Waste]()
    
    @State var isShowingCreateSaveRequest = false
    @State var isShowingSaveRequestHistory = false
    @State var isExtending = false
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(hex: "22343C")
                    .ignoresSafeArea()
                
                NavigationLink(destination: MemberCreateSaveRequest(isPresented: $isShowingCreateSaveRequest), isActive: $isShowingCreateSaveRequest) {
                    EmptyView()
                }
                
                NavigationLink(destination: MemberSaveRequestHistory(), isActive: $isShowingSaveRequestHistory) {
                    EmptyView()
                }
                
                //ScreenSize.height * 0.42
                ScrollView {
                    ZStack {
                        VStack {
                            Color.init(hex: "25C685")
                                .frame(height: 385)
                                .offset(y: isExtending ? -100 : -100)
                                

                            Spacer()
                        }
                        .ignoresSafeArea()
                        
                        VStack {
                            if(userLoggedOnInfo.isLoggedIn) {
                                VStack() {
                                    HStack {
                                        Text("Hello,")
                                            .foregroundColor(.white)
                                            //.multilineTextAlignment(.leading)
                                            .font(.system(size: 36))
                                        
                                        if (userLoggedOnInfo.type == "Member") {
                                            Spacer()
                                            
                                            Button(action: {
                                                self.isShowingCreateSaveRequest.toggle()
                                            }){
                                                Image(systemName: "plus")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(Color.init(hex: "30444E"))
                                            }
                                            .padding(.trailing, 10)
                                            
                                            Button(action: {
                                                self.isShowingSaveRequestHistory.toggle()
                                            }) {
                                                Image(systemName: "list.triangle")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(Color.init(hex: "30444E"))
                                            }
                                            .padding(.trailing, 10)
                                            
                                        }
                                        
                                    }
                                    .frame(width: ScreenSize.width * 0.9, alignment: .leading)
                                        
                                    Text("\(userLoggedOnInfo.fullname)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 30))
                                        .bold()
                                        .frame(width: ScreenSize.width * 0.9, alignment: .leading)
                                    
                                    WasteBankInfo()
                                        .padding(.bottom, 15)
                                }
                                .padding([.top, .leading, .trailing])
                                .offset(y: userLoggedOnInfo.type == "Member" ? -15 : 0)
                                //.frame(width: ScreenSize.width * 0.9, alignment: .leading)
                                
                            }
                            else {
                                Text("Login terlebih dahulu!")
                                    .padding()
                            }
                            
                            VStack(spacing: 20){
                                if(userLoggedOnInfo.isLoggedIn && userLoggedOnInfo.type == "Member") {
                                    MemberStatistic(revenueTotal: $revenueTotal, amountTotal: $amountTotal)
                                    
                                    SearchBar(text: $searchText, autoCapital: true)
                                        //.padding(.top, 30)
                                        .padding(.horizontal, 15)
                                    
                                    ForEach(savingList.filter({ searchText.isEmpty ? true : $0.type.contains(searchText) })) { saving in
                                        NavigationLink(destination: SavingDetail(savingSelected: saving)) {
                                            SavingRow(saving: saving)
                                        }
                                    }
                                    
                                    if savingList.isEmpty {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 15)
                                                .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(Color.init(hex: "30444E"))
                                            
                                            Text("Anda belum memiliki tabungan sampah")
                                                .fontWeight(.heavy)
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(1)
                                        }
                                    }
                                }
                                else if (userLoggedOnInfo.isLoggedIn && userLoggedOnInfo.type == "Admin"){
//                                    WasteBankInfo()
//                                        .padding(.bottom, 15)
                                    
                                    AdminStatistic(wasteWeightTotal: $wasteWeightTotal)
                                    
                                    SearchBar(text: $searchText, autoCapital: true)
                                        //.padding(.top, 10)
                                        .padding(.horizontal, 15)
                                    
                                    ForEach(wasteList.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { waste in
                                        WasteRow(waste: waste, wasteList: $wasteList, isExtending: $isExtending)
                                    }
                                }
                            }
                            
                            
                            Spacer()
                        }
                        .navigationTitle("Home")
                        .navigationBarTitle("Home")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarHidden(true)
                        .onAppear(perform: {
                            print("--onAppear Homepage")
                            self.getLoginInfoFromUserDefault()
                            
                            //Fetch Saving data from database
                            if(userLoggedOnInfo.isLoggedIn && userLoggedOnInfo.type == "Member") {
                                self.fetchMemberSavingData()
                            }
                            else if (userLoggedOnInfo.isLoggedIn && userLoggedOnInfo.type == "Admin"){
                                self.fetchAdminSavingData()
                            }
                            else {
                                savingList = [Saving]()
                            }
                            
                            
            //                print("isLoggedInString: \(UserDefaults.standard.string(forKey: "isLoggedInString") as Any)")
            //
            //                print("isLoggedIn: \(UserDefaults.standard.bool(forKey: "isLoggedIn"))")
            //
            //
            //                if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            //
            //                    print("Udah Login")
            //                }
                    })
                    }
                }
            }
            
        }
        
    }
    
    func getLoginInfoFromUserDefault() {
        userLoggedOnInfo.id = UserDefaults.standard.integer(forKey: "loggedId")
        
        userLoggedOnInfo.fullname = UserDefaults.standard.string(forKey: "loggedFullname")!
        
        userLoggedOnInfo.fullname = UserDefaults.standard.string(forKey: "loggedFullname")!
        
        userLoggedOnInfo.username = UserDefaults.standard.string(forKey: "loggedUsername")!
        
        userLoggedOnInfo.email = UserDefaults.standard.string(forKey: "loggedEmail")!
        
        userLoggedOnInfo.address
            = UserDefaults.standard.string(forKey: "loggedAddress")!
        
        userLoggedOnInfo.gender = UserDefaults.standard.string(forKey: "loggedGender")!
        
        userLoggedOnInfo.joinDate = UserDefaults.standard.string(forKey: "loggedJoinDate")!
        
        userLoggedOnInfo.birthDate = UserDefaults.standard.string(forKey: "loggedBirthDate")!
        
        userLoggedOnInfo.point = UserDefaults.standard.integer(forKey: "loggedPoint")
        
        userLoggedOnInfo.type = UserDefaults.standard.string(forKey: "loggedType")!
        
        userLoggedOnInfo.phoneNumber = UserDefaults.standard.string(forKey: "loggedPhoneNumber")! 
        
        userLoggedOnInfo.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func fetchMemberSavingData() {
        print("Getting Member's Saving...")
        
        let searchField = "users_permissions_user.id"
        let queryItems = [URLQueryItem(name: searchField, value: String(userLoggedOnInfo.id))]
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
                        
                        revenueTotal = 0
                        amountTotal = 0
                        for saving in savingList {
                            revenueTotal += saving.earning
                            amountTotal += saving.amount
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
    
    func fetchAdminSavingData() {
        print("Masuk")
        guard let url = URL(string: "\(DBConnection.url)/wastes") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Waste].self, from: data) {
                    DispatchQueue.main.async {
                        self.wasteList = response
                        //print(membersList)
                        print("Fetch Admin selesai")
                        
                        //For admin Statistic
                        wasteWeightTotal = 0
                        for waste in wasteList {
                            wasteWeightTotal = wasteWeightTotal + waste.totalSavingAmount
                        }
                    }
                    return
                }
                else {
                    print("JSON Decode Fail!")
                }
                
            }
            
            
        }.resume()
    
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            print("Mulai klasifikasi...")
//            if adminSavingList.isEmpty {
//                adminSavingList.append(savingList[0])
//            }
//
//            //Akumulasi amount masing2 saving
//            for saving in self.savingList {
//    //                            print(saving.type)
//    //                            print(adminSavingList)
//                var found = false
//                for index in 0..<adminSavingList.count {
//                    if saving.type == adminSavingList[index].type {
//                        adminSavingList[index].amount += saving.amount
//                        found = true
//                        break
//                    }
//                }
//
//                if !found {
//                    adminSavingList.append(saving)
//                }
//
//            }
//        }
    }
}

struct Home_Previews: PreviewProvider {
    static var savings = ModelData().savings
    
    static var previews: some View {
        Home(savingList: savings, tabSelection: .constant(0))
            .environmentObject(UserLoggedOnInfo())
        
//        Home(savingList: savings, tabSelection: .constant(0))
//            .environmentObject(UserLoggedOnInfo())
//            .previewDevice("iPhone 8")
    }
}


