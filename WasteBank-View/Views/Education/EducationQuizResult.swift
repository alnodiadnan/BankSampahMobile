//
//  EducationQuizResult.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 12/07/21.
//

import SwiftUI

struct EducationQuizResult: View {
    
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    
    @State var pointEarned : Int = 0
    
    @Binding var trueCount : Int
    @Binding var falseCount : Int
    
    @Binding var isShowingQuiz : Bool
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.init(hex: "fe565e"))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                        .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.225, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    VStack {
                        Text("Permainan telah selesai!")
                            .fontWeight(.heavy)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .frame(maxWidth: ScreenSize.width * 0.75)
                            .padding(.top, 60)
                        
                        HStack {
                            Image("QuizLogo")
                                .resizable()
                                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.trailing, 30)
                            
                            Image("TrueLogo")
                                .resizable()
                                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            Text("\(trueCount)")
                                .fontWeight(.heavy)
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                            
                            Image("FalseLogo")
                                .resizable()
                                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding(.leading, 30)
                            
                            Text("\(falseCount)")
                                .fontWeight(.heavy)
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 20)
                        .padding(.trailing, 30)
                        
                        
                    }
                    
                    
                }
                
                RewardCard(trueCount: $trueCount, falseCount: $falseCount)
                
                //User Profile
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.init(hex: "3ED598"))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                        .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    MemberProfilePicture(image: Image("Placeholder_MemberProfilePicture"))
                        .frame(width: 120, height: 120)
                        .offset(y: -80)
                        .onTapGesture {
                            //self.tabSelection = 2
                        }
                    
                    VStack(spacing: 0) {
                        Text("\(userLoggedOnInfo.fullname)")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 75)
                            .onTapGesture {
                                //self.tabSelection = 2
                            }
                        
                        Rectangle()
                            .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.001, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.top, 10)
                            .foregroundColor(.white)
                        
                        HStack {
//                            HStack {
//                                Image("Placeholder")
//                                    .resizable()
//                                    .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//
//                                Text("#Medal")
//                                    .bold()
//                                    .foregroundColor(.white)
//                            }
//                            //.padding(.trailing, 30)
//
//                            Rectangle()
//                                .frame(width: ScreenSize.width * 0.002, height: 65, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                .padding(.horizontal, 30)
                            
                            HStack {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.init(hex: "F9FE00"))
                                
                                Text("\(userLoggedOnInfo.point)")
                                    .fontWeight(.heavy)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                
                                Text("+\(pointEarned)").fontWeight(.heavy)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.init(hex: "FF464F"))
                            }
                            .padding(.top, 10)
                            
                        }
                    }
                }
                .padding(.top, 40)
                
                //Button keluar
                Button(action: {
                    //Update point user
                    self.updateUserPoint()
                    
                    self.isShowingQuiz = false
                }) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(15)
                            .foregroundColor(Color.init(hex: "40DF9F"))
                            .frame(width: ScreenSize.width * 0.65, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        HStack {
                            Text("Keluar")
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .onAppear() {
            self.pointEarned = trueCount * 10
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func updateUserPoint() {
        let jsonBody : [String : Any] = ["point" : (userLoggedOnInfo.point + pointEarned)]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "\(DBConnection.url)/users/\(userLoggedOnInfo.id)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                print("Update Point status code:  \(response.statusCode)")
                
                if response.statusCode == 200 {
                    
                    //Create Point History
                    self.createPointHistory()
                    
                    //Refresh Login Data
                    UserDefaults.standard.set((userLoggedOnInfo.point + pointEarned), forKey: "loggedPoint")
                    
                    userLoggedOnInfo.point = UserDefaults.standard.integer(forKey: "loggedPoint")
                    
                }
            }
        }.resume()
    }
    
    func createPointHistory() {
        let jsonBody : [String : Any] = ["name" : "Game Point", "amount" : pointEarned, "users_permissions_user" : ["id" : userLoggedOnInfo.id]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "\(DBConnection.url)/point-transactions") else {
            return
        }
        
        print("Create Point History URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                print("Create Point History status code:  \(response.statusCode)")
                
                if response.statusCode == 200 {
                    
                }
            }
            
        }.resume()
    }
}

struct EducationQuizResult_Previews: PreviewProvider {
    static var previews: some View {
        EducationQuizResult(trueCount: .constant(1), falseCount: .constant(1), isShowingQuiz: .constant(true))
            .environmentObject(UserLoggedOnInfo())
    }
}

struct RewardCard : View {
    @Binding var trueCount : Int
    @Binding var falseCount : Int
    
    var body: some View {
        ZStack {
            Rectangle()
                //.border(Color.gray, width: 3)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 1))
                .foregroundColor(Color.init(hex: "2a7e63"))
                .frame(width: ScreenSize.width * 0.9, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            HStack{
                VStack(alignment: .leading) {
                    Text("Game Point")
                        .bold()
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                    
                    Text("\(trueCount) Jawaban Benar")
                        .bold()
                        .font(.system(size: 16))
                        .foregroundColor(Color.init(hex: "3ED598"))
                }
                
                Spacer()
                
                VStack {
                    Text("\(trueCount * 10)")
                        .bold()
                        .font(.system(size: 30))
                        .foregroundColor(Color.init(hex: "3ED598"))
                    
                    Text("PTS")
                        .bold()
                        .font(.system(size: 22))
                        .foregroundColor(Color.init(hex: "D2D2D2"))

                }
            }
            .padding(.horizontal, 35)
            .padding(.vertical)
        }
        
    }
}
