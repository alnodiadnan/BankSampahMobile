//
//  MemberListImageTest.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 24/05/21.
//

import SwiftUI
import Combine
import Foundation

struct MemberListImageTest: View {
    @State var memberList = MemberTest()
    //@State var url = URL(string: "")!
    
    var body: some View {
        VStack {
            List(memberList, id: \.id) { item in
                HStack {
                    if (item.profilePicture?.url != nil) {
                        AsyncImage(url: URL(string: "http://localhost:1337\(item.profilePicture!.url)")!,
                                   placeholder: { Text("Loading ...") },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(width: 75, height: 75)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 7)
                    }
                    else {
                        //Placeholder Image
                    }
                    
                    
                    Text(item.username)
                        .multilineTextAlignment(.center)
                        //.frame(width: ScreenSize.width)
                }
            }.onAppear(perform: {
                getMembersWithImage()
            })
        }
    }
    
    func getMembersWithImage() {
        guard let url = URL(string: "http://localhost:1337/users-with-images") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([MemberTestElement].self, from: data) {
                    DispatchQueue.main.async {
                        self.memberList = response
                    }
                    return
                }
            }
            else {
                //print(error?.localizedDescription)
            }
        }.resume()
    }
    
    func loadProfilePicture(url : String) {
        
    }
}

struct MemberListImageTest_Previews: PreviewProvider {
    static var previews: some View {
        MemberListImageTest()
    }
}

