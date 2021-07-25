//
//  MemberProfile.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 25/05/21.
//

import SwiftUI

struct MemberProfile: View {
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    
    //@Binding var isShowingMemberProfilePage : Bool
    
    @State var isShowingEditProfilePage : Bool = false
    @State var formattedJoinDate: String = ""
    
    @State var isShowingPointHistory = false
    
    @Binding var tabSelection: Int
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.init(hex: "22343C")
                    .ignoresSafeArea()
                
                NavigationLink(destination: MemberEditProfile(isShowingEditProfile: $isShowingEditProfilePage), isActive: $isShowingEditProfilePage) {
                    EmptyView()
                }
                
                NavigationLink(destination: PointHistory(), isActive: $isShowingPointHistory) {
                    EmptyView()
                }
                
                VStack(spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.init(hex: "3ED598"))
                            .frame(width: ScreenSize.width * 0.9, height: userLoggedOnInfo.type == "Member" ? ScreenSize.height * 0.2 : ScreenSize.height * 0.125, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        MemberProfilePicture(image: Image("Placeholder_MemberProfilePicture"))
                            .frame(width: 120, height: 120)
                            .offset(y: userLoggedOnInfo.type == "Member" ? -80 : -60)
                            .onTapGesture {
                                self.tabSelection = 2
                            }
                        
                        VStack(spacing: 0) {
                            Text("\(userLoggedOnInfo.fullname)")
                                .font(.system(size: 24))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.top, userLoggedOnInfo.type == "Member" ? 75 : 45)
                                .onTapGesture {
                                    self.tabSelection = 2
                                }
                            
                            if userLoggedOnInfo.type == "Member" {
                                Rectangle()
                                    .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.001, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .padding(.top, 10)
                                    .foregroundColor(.white)
                                
                                
                                Button(action: {
                                    //Move to Point History Page
                                    self.isShowingPointHistory.toggle()
                                    
                                }) {
                                    HStack {
                                        
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(Color.init(hex: "F9FE00"))
                                            
                                            Text("\(userLoggedOnInfo.point)")
                                                .fontWeight(.heavy)
                                                .font(.system(size: 20))
                                                .foregroundColor(.white)
                                                .padding(.trailing, 20)
                                        }
                                    }
                                }
                                .padding(.top, 10)
                                
                                
                            }
                            
                        }
                        
                    }
                    .offset(y: 15)
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("")
                            .frame(width: ScreenSize.width)
                        
                        //Username
                        HStack {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(Color.init(hex: "2e846a"))
                                    .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .foregroundColor(Color.init(hex: "3dd598"))
                                    .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding(.leading, 10)
                            
                            ZStack(alignment: .leading) {
                                
                                Text("\(userLoggedOnInfo.username)")
                                    .fontWeight(.heavy)
                                    .padding()
                                    .foregroundColor(.white)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                //.underlineTextField()
                                //.padding(.top, 10)
                                //.padding(.trailing, 0)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        //Email
                        HStack {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(Color.init(hex: "2e846a"))
                                    .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image(systemName: "envelope")
                                    .resizable()
                                    .foregroundColor(Color.init(hex: "3dd598"))
                                    .frame(width: 25, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding(.leading, 10)
                            
                            ZStack(alignment: .leading) {
                                
                                Text("\(userLoggedOnInfo.email)")
                                    .fontWeight(.heavy)
                                    .padding()
                                    .foregroundColor(.white)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    //.underlineTextField()
                                    
                                    
                                    //.padding(.top, 10)
                                    .padding(.trailing, 15)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        //Phone Number
                        HStack {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(Color.init(hex: "2e846a"))
                                    .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image(systemName: "phone.fill")
                                    .resizable()
                                    .foregroundColor(Color.init(hex: "3dd598"))
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding(.leading, 10)
                            
                            ZStack(alignment: .leading) {
                                
                                Text("\(userLoggedOnInfo.phoneNumber)")
                                    .fontWeight(.heavy)
                                    .padding()
                                    .foregroundColor(.white)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    //.padding(.top, 10)
                                    .padding(.trailing, 15)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        //Address
                        HStack {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(Color.init(hex: "2e846a"))
                                    .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .foregroundColor(Color.init(hex: "3dd598"))
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding(.leading, 10)
                            
                            ZStack(alignment: .leading) {
                                
                                Text("\(userLoggedOnInfo.address)")
                                    .fontWeight(.heavy)
                                    .padding()
                                    .foregroundColor(.white)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    //.padding(.top, 10)
                                    .padding(.trailing, 15)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        //Gender
                        HStack {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(Color.init(hex: "2e846a"))
                                    .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image(systemName: "person.2.fill")
                                    .resizable()
                                    .foregroundColor(Color.init(hex: "3dd598"))
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding(.leading, 10)
                            
                            ZStack(alignment: .leading) {
                                
                                Text("\(userLoggedOnInfo.gender)")
                                    .fontWeight(.heavy)
                                    .padding()
                                    .foregroundColor(.white)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    //.padding(.top, 10)
                                    .padding(.trailing, 15)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        //BirthDate
                        HStack {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(Color.init(hex: "2e846a"))
                                    .frame(width: 45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Image(systemName: "calendar")
                                    .resizable()
                                    .foregroundColor(Color.init(hex: "3dd598"))
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding(.leading, 10)
                            
                            ZStack(alignment: .leading) {
                                
                                Text("\(userLoggedOnInfo.birthDate)")
                                    .fontWeight(.heavy)
                                    .padding()
                                    .foregroundColor(.white)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    //.padding(.top, 10)
                                    .padding(.trailing, 15)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        
                    }
                    
                    
                    
                    
                    Button(action: {
                        self.logOut()
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(15)
                                .foregroundColor(Color.init(hex: "793438"))
                                .frame(width: ScreenSize.width * 0.65, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            HStack {
                                Text("Logout")
                                    .bold()
                                    .foregroundColor(.white)
                                
                            }
                        }
                    }
                    
                    //                VStack {
                    //                    MemberProfilePicture(image: Image("Placeholder_MemberProfilePicture"))
                    //                        .frame(width: ScreenSize.width * 0.25, height: ScreenSize.width * 0.25)
                    //
                    //                    //Text(String(userLoggedOnInfo.id))
                    //    //                    .font(.system(size: 16))
                    //    //                    .scaledToFit()
                    //    //                    .minimumScaleFactor(0.01)
                    //    //                    .lineLimit(1)
                    //
                    //                    Text(userLoggedOnInfo.fullname)
                    //                        .font(.system(size: 16))
                    //                        .scaledToFit()
                    //                        .minimumScaleFactor(0.01)
                    //                        .lineLimit(1)
                    //
                    //                    Text("Email: \(userLoggedOnInfo.email)")
                    //                        //.font(.system(size: 16))
                    //                        .font(.system(size: 14))
                    //                        .scaledToFit()
                    //                        .minimumScaleFactor(0.01)
                    //                        .lineLimit(1)
                    //
                    //                    Text("Joined since : \(formattedJoinDate)")
                    //                        //.font(.system(size: 16))
                    //                        .font(.system(size: 14))
                    //                        .scaledToFit()
                    //                        .minimumScaleFactor(0.01)
                    //                        .lineLimit(1)
                    //
                    //                    //Text("Role : \(userLoggedOnInfo.type)")
                    //                        //.font(.system(size: 16))
                    //    //                    .font(.system(size: 14))
                    //    //                    .scaledToFit()
                    //    //                    .minimumScaleFactor(0.01)
                    //    //                    .lineLimit(1)
                    //    //
                    //
                    //                    Button(action: {
                    //                        self.logOut()
                    //                    }) {
                    //                        Text("Logout")
                    //                            .font(.system(size: 14))
                    //                    }
                    //
                    
                    //
                    //                }
                    //                .background(RoundedRectangle(cornerRadius: 20)
                    //                    .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.275)
                    //                    //.frame(width: ScreenSize.width * 0.9)
                    //                            .foregroundColor(.gray))
                    //                .frame(width: ScreenSize.width * 0.9)
                    //                .navigationBarBackButtonHidden(true)
                    .navigationTitle("")
                    .navigationBarTitle("")
                    .navigationBarColor(Color.init(hex: "22343C").uiColor())
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing:
                                            HStack {
                                                Button(action: {
                                                    print("Edit profile button pressed...")
                                                    self.isShowingEditProfilePage = true
                                                }) {
                                                    Image(systemName: "square.and.pencil")
                                                }
                                            }
                    )
                    .onAppear() {
                        //self.getLoginInfoFromUserDefault()
                        
                        formattedJoinDate = String(userLoggedOnInfo.joinDate.prefix(10))
                    }
                }
            }
        }
        
        
    }
    
    func logOut() {
        print("Logout!")
        
        UserDefaults.standard.set(0, forKey: "loggedId")
        
        UserDefaults.standard.set("", forKey: "loggedUsername")
        
        UserDefaults.standard.set("", forKey: "loggedFullname")
        
        UserDefaults.standard.set("", forKey: "loggedEmail")
        
        UserDefaults.standard.set("", forKey: "loggedJoinDate")
        
        UserDefaults.standard.set("", forKey: "loggedAddress")
        
        UserDefaults.standard.set("", forKey: "loggedGender")
        
        UserDefaults.standard.set("", forKey: "loggedType")
        
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
        UserDefaults.standard.set("false", forKey: "isLoggedInString")
        
        self.getLoginInfoFromUserDefault()
        self.tabSelection = 3
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
        
        userLoggedOnInfo.type = UserDefaults.standard.string(forKey: "loggedType")!
        
        userLoggedOnInfo.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}

struct MemberProfile_Previews: PreviewProvider {
    static var previews: some View {
        MemberProfile(tabSelection: .constant(2))
            .environmentObject(UserLoggedOnInfo())
        
        MemberProfile(tabSelection: .constant(2))
            .environmentObject(UserLoggedOnInfo())
            .previewDevice("iPhone 8")
    }
}
