//
//  RestaurantList.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 21/05/21.
//

import SwiftUI

struct Restaurant : Codable {
    var id : Int
    var name : String
    var description : String
}

struct RestaurantList: View {
    @State var restaurants = [Restaurant]()
    
    var body: some View {
        VStack {
            List(restaurants, id: \.id) { item in
                VStack(alignment: .leading) {
                    Text(item.name)
                        .multilineTextAlignment(.center)
                        .frame(width: ScreenSize.width)
                    Text(item.description)
                        .multilineTextAlignment(.center)
                }
            }.onAppear(perform: {
                loadRestaurantData()
            })
            
            Button(action: {
                print("Post Restaurant Button Tapped")
                //POST
                self.postRestaurant()
            }) {
                Text("Post Restaurant")
            }
        }
    }
    
    func loadRestaurantData() {
//        let searchField = "description"
//        let queryItems = [URLQueryItem(name: searchField + "_contains", value: "Welcome")]
//        var urlComps = URLComponents(string: "http://localhost:1337/restaurants")
//        urlComps?.queryItems = queryItems
//        let urlResult = urlComps?.url
//        print(urlResult)
//
//        let request = URLRequest(url: urlResult!)
        
        guard let url = URL(string: "http://localhost:1337/restaurants") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Restaurant].self, from: data) {
                    DispatchQueue.main.async {
                        self.restaurants = response
                    }
                    return
                }
            }
        }.resume()
    }
    
    func postRestaurant() {
        let jsonBody = ["name": "Pochajang", "description": "Punya kakaknya Eibiel"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "http://localhost:1337/restaurants") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let responseJSON = responseJSON as? [String: Any] {
                print("JSON RESPONSE: \n\(responseJSON)")
            }
        }.resume()
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantList()
    }
}


