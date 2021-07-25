//
//  AddBalance.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 15/05/21.
//

import SwiftUI

struct AddBalance: View {
    @Binding var isPresented : Bool
    @State var isShowingAddCard : Bool = false
    @State var balanceList = [Balance]()
    @State var updateList = true
    @Binding var memberSelected : Member
    
    @Binding var savingList : [Saving]
    @State var wasteList = [Waste]()
    
    @State var showingAlert = false
    
    var body: some View {
        ZStack{
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            VStack {
                Text("Setor Sampah")
                    .font(.system(size: 28))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                Text("Tanggal : \(Date().string(format: "dd-MM-yyyy"))")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    //.padding()
                
                //List temporary balance
                if updateList {
                    ForEach(0..<balanceList.count, id: \.self) { index in
                        BalancePreview(balance: balanceList[index], balanceList: $balanceList, indexSelected: index, updateList: $updateList)
                    }
                }
                
                Button(action: {
                    self.isShowingAddCard = true
                }) {
                    ZStack{
//                        BalancePreview(balance: Balance(name: "", amount: 0), balanceList: .constant([Balance]()), updateList: $updateList)
//                            .opacity(0)
//                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.init(hex: "30444E"))
                            .frame(width: ScreenSize.width * 0.75, height: ScreenSize.height * 0.15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        VStack {
                            Text("*Tambah Jenis Sampah*")
                                .padding()
                            
                            Image(systemName: "plus")
                        }
                    }
                    
                }
                .padding(.top, 15)
                .padding([.leading, .bottom, .trailing])
                
                Button(action: {
                    //Update saldo ke database
                    self.updateBalance()
                    
                    
                }) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(15)
                            .foregroundColor(Color.init(hex: "40DF9F"))
                            .frame(width: ScreenSize.width * 0.65, height: ScreenSize.height * 0.065, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        HStack {
                            Text("Setor")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                
            }
            
            if isShowingAddCard {
                
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.9)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                
                VStack{
                    
                    AddBalanceCard(isShowingAddCard: $isShowingAddCard, balanceList: $balanceList, updateList: $updateList)
                        .padding(.top, 20)
                    
                }
            }
            
        }
        .onAppear(perform: {
            self.fetchWasteData()
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Penambahan Saldo Berhasil!"), message: Text("Tekan 'OK' untuk melanjutkan"), dismissButton: .default(Text("OK")) {
                self.isPresented = false
            })
        }
        
    }
    
    func fetchWasteData() {
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
                        
                    }
                    return
                }
                else {
                    print("JSON Decode Fail!")
                }
                
            }
        }.resume()
    }
    
    func updateBalance() {
        var duplicatedSaving = false
        
        for (_, balance) in balanceList.enumerated() {
            duplicatedSaving = false
            for (_, saving) in savingList.enumerated() {
                if balance.name == saving.type {
                    duplicatedSaving = true
                    
                    let jsonBody : [String : Any] = ["amount": (saving.amount + balance.amount)]
                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
                    
                    guard let url = URL(string: "\(DBConnection.url)/savings/\(saving.id)") else {
                        print("Invalid URL")
                        return
                    }
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "PUT"
                    request.httpBody = jsonData
                    
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data, error == nil else {
                            print(error?.localizedDescription ?? "No data")
                            return
                        }
                        
//                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let response = response as? HTTPURLResponse {
                            print("Update Saving Status code:  \(response.statusCode)")
                        }
                        
//                        if let responseJSON = responseJSON as? [String: Any] {
//                            print("Update Saving JSON Response: \n\(responseJSON)")
//                        }
                        
                        self.createTransactionHistory(savingId: saving.id, balance: balance)
                        self.updateWasteTotalBalance(id: saving.waste!.id, amountAddition: balance.amount)
                        
                    }.resume()
                    
                    break
                }
            }
            
            if !duplicatedSaving {
                //Create new saving for current member
                
                //Get waste ID for reference
                var wasteID : Int?
                for waste in wasteList {
                    if balance.name == waste.name {
                        wasteID = waste.id
                    }
                }
                
                let jsonBody : [String : Any] = ["type": balance.name, "amount" : balance.amount, "users_permissions_user": ["id" : memberSelected.id], "waste" : ["id" : wasteID!]]
                
                let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
                
                guard let url = URL(string: "\(DBConnection.url)/savings") else {
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
                    
                    if let response = response as? HTTPURLResponse {
                        print("Status code:  \(response.statusCode)")
                    }
                    
                    if let responseJSON = responseJSON as? [String: Any] {
                        print("Create Saving JSON Response: \n\(responseJSON)")
                        
//                        print("New saving ID: \(String(describing: responseJSON["id"]))")
                        
                        //Decode dulu ke model Saving
                        if let responseJSONDecoded = try? JSONDecoder().decode(Saving.self, from: data) {
                            DispatchQueue.main.async {
                                print("Hasil Decode: \n\(responseJSONDecoded)")
                                
                                self.createTransactionHistory(savingId: responseJSONDecoded.id, balance: balance)
                                
                                self.updateWasteTotalBalance(id: wasteID!, amountAddition: balance.amount)
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
    }
    
    func createTransactionHistory(savingId : Int, balance: Balance) {
        print("Creating Transaction History...")
        let jsonBody : [String : Any] = ["amount": balance.amount, "type" : "Setor", "saving" : ["id" : savingId], "earning" : 0]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "\(DBConnection.url)/saving-transactions") else {
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
            
            if let response = response as? HTTPURLResponse {
                print("Create Transaction status code:  \(response.statusCode)")
            }
            
//            if let responseJSON = responseJSON as? [String: Any] {
//                print("Create Transaction History JSON Response: \n\(responseJSON)")
//            }
            
            self.fetchMemberSavingData()
        }.resume()
    }
    
    func fetchMemberSavingData() {
        print("Updating Member's Savings...")
        
        let searchField = "users_permissions_user.id"
        let queryItems = [URLQueryItem(name: searchField, value: String(memberSelected.id))]
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
                    }
                    return
                }
                else {
                    print("JSON Decode Fail!")
                }
            }
        }.resume()
    }
    
    func updateWasteTotalBalance(id : Int, amountAddition: Double) {
        var oldAmount : Double?
        
        for waste in wasteList {
            if waste.id == id {
                oldAmount = waste.totalSavingAmount
            }
        }
        
        let newAmount = amountAddition + oldAmount!
        let jsonBody : [String : Any] = ["totalSavingAmount" : newAmount]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        guard let url = URL(string: "\(DBConnection.url)/wastes/\(id)") else {
            print("Invalid URL")
            return
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
            
            if let response = response as? HTTPURLResponse {
                print("Update total amount status code:  \(response.statusCode)")
                
                if response.statusCode == 200 {
                    self.showingAlert = true
                }
            }
            
            
        }.resume()
    }
}



struct AddBalanceCard: View {
    @State var balanceValue : String = "0"
    var wasteList = ["Kaleng", "Kertas", "Plastik"]
    @State var selectedWaste : String = "Kaleng"
    @State var selectedWasteIndex : Int = 0
    
    @Binding var isShowingAddCard : Bool
    @Binding var balanceList : [Balance]
    @Binding var updateList : Bool
    
    var body: some View {
        VStack {
            HStack {
                Image("Waste_\(wasteList[selectedWasteIndex])")
                    .resizable()
                    .frame(width: ScreenSize.height * 0.1, height: ScreenSize.height * 0.1)
                    //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .padding([.top, .leading, .bottom])
                
                
                VStack {
                    DropdownPicker(title: "Jenis Sampah :", selection: $selectedWasteIndex, selectionString: $selectedWaste, options: wasteList)
                        .padding(.trailing)
                    
                    HStack {
                        //                    Button(action: {
                        //                        if Double(self.balanceValue)! > 0 {
                        //                            self.balanceValue = String(Double(balanceValue)! - 1)
                        //                        }
                        //                    }) {
                        //                        Image(systemName: "minus.circle")
                        //                    }
                        
                        VStack(spacing: 3) {
                            TextField("", text: $balanceValue)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                            
                            //                        Rectangle()
                            //                            .frame(height: 1)
                            //                            .foregroundColor(.black)
                            //                            .padding(.leading, 16)
                            //                            .padding(.trailing, 16)
                        }
                        .frame(width: 50)
                        .padding(.all, 3)
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(5)
                        
                        Text("/ Kg")
                        
                        //                    Button(action: {
                        //                        self.balanceValue = String(Double(balanceValue)! + 1)
                        //                    }) {
                        //                        Image(systemName: "plus.circle")
                        //                    }
                    }
                }
            }
            //.cornerRadius(30)
            //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                if Double(balanceValue) != 0 {
                    var duplicatedWaste = false
                    
                    for (index, balance) in balanceList.enumerated() {
                        if balance.name == selectedWaste {
                            duplicatedWaste = true
                            balanceList[index].amount += Double(balanceValue)!
                            break
                        }
                        
                    }
                    
                    //Masukin temp saldo ke list
                    if !duplicatedWaste {
                        self.balanceList.append(Balance(name: selectedWaste, amount: Double(balanceValue)!))
                        
                    }
                    self.updateList.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.updateList.toggle()
                    }
                    
                }
                //print(balanceList)
                self.isShowingAddCard = false
            }) {
                Text("Confirm")
            }
            .padding(5)
            //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            .padding([.leading, .bottom, .trailing], 10)
        }
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
        .padding(.horizontal)
    }
}

struct AddBalance_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            AddBalance(isPresented: .constant(true), balanceList: ModelData().balances, memberSelected: .constant(ModelData().members[0]), savingList: .constant([Saving]()))
            AddBalance(isPresented: .constant(true), balanceList: ModelData().balances, memberSelected: .constant(ModelData().members[0]), savingList: .constant([Saving]()))
                .previewDevice("iPhone 8")
        }
    }
}

struct DropdownPicker: View {
    
    var title: String
    @Binding var selection: Int
    @Binding var selectionString: String
    var options: [String]
    
    @State private var showOptions: Bool = false
    
    var body: some View {
        ZStack {
            // Static row which shows user's current selection
            
            HStack {
                Text(title)
                //Spacer()
                Text(options[selection])
                    .foregroundColor(Color.black.opacity(0.6))
                Image(systemName: "chevron.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
            }
            .opacity(showOptions ? 0 : 1)
            .font(Font.custom("Avenir Next", size: 16).weight(.medium))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white)
            .onTapGesture {
                // show the dropdown options
                withAnimation(Animation.spring().speed(2)) {
                    showOptions = true
                }
            }
            
            
            // Drop down options
            if showOptions {
                
                HStack(alignment: .center, spacing: 4) {
                    Text(title)
                        .font(Font.custom("Avenir Next", size: 16).weight(.semibold))
                        .foregroundColor(.black)
                    VStack(alignment: .center,spacing: 10) {
                        //Spacer()
                        ForEach(options.indices, id: \.self) { i in
                            if i == selection {
                                Text(options[i])
                                    .font(.system(size: 12))
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.black.opacity(0.2))
                                    .cornerRadius(4)
                                    .onTapGesture {
                                        // hide dropdown options - user selection didn't change
                                        withAnimation(Animation.spring().speed(2)) {
                                            showOptions = false
                                        }
                                    }
                            } else {
                                Text(options[i])
                                    .font(.system(size: 12))
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .onTapGesture {
                                        // update user selection and close options dropdown
                                        withAnimation(Animation.spring().speed(2)) {
                                            selectionString = options[i]
                                            selection = i
                                            showOptions = false
                                        }
                                    }
                            }
                            //Spacer()
                        }
                    }
                    .padding(.vertical, 2)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                //.background(Color.black)
                .foregroundColor(.black)
                .transition(.opacity)
                
            }
            
        }
    }
}

struct BalancePreview : View {
    @State var balance = Balance(name: "*Waste Name", amount: 0)
    @Binding var balanceList : [Balance]
    var indexSelected : Int = 0
    
    @Binding var updateList : Bool
    
    var body: some View {
        ZStack {
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color.init(hex: "30444E"))
                    .frame(width: ScreenSize.width * 0.75, height: ScreenSize.height * 0.15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Image("Waste_\(balance.name)")
                        .resizable()
                        .frame(width: ScreenSize.height * 0.1, height: ScreenSize.height * 0.1)
                        .padding([.top, .bottom])
                    
                    VStack {
                        Text(balance.name)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .frame(minWidth: 100)
                        
                        Text("\(String(balance.amount)) Kg")
                            .foregroundColor(.white)
                            .padding(.all, 3)
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(5)
                    }
                    
                    Button(action: {
                        //print("Waste removed: \(balanceList[indexSelected])")
                        
                        self.balanceList.remove(at: indexSelected)
                        //print("Waste list: \(balanceList)")
                        self.updateList.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.updateList.toggle()
                        }
                    }) {
                        Image(systemName: "trash")
                        
                    }
                    .padding(.horizontal)
                    
                }
                //.cornerRadius(30)
                //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                
            }
//            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
            .padding([.top, .leading, .trailing])
            //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        }
    }
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}


extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
