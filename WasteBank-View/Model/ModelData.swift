//
//  ModelData.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 09/05/21.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var members: [Member] = load("Dummy_Member.json")
    @Published var savings: [Saving] = load("Dummy_Saving.json")
    @Published var balances: [Balance] = load("Dummy_Balance.json")
    @Published var savingTransactions: [SavingTransaction] = load("Dummy_SavingTransaction.json")
    @Published var sellTransactions: [SellTransaction] = load("Dummy_SellTransaction.json")
    @Published var pointTransactions : [PointTransaction] = load("Dummy_PointTransaction.json")
    @Published var wastes: [Waste] = load("Dummy_Waste.json")
    @Published var saveRequestHeaders : [SaveRequestHeader] = load("Dummy_SaveRequestHeader.json")
}

func load<T : Decodable>(_ filename: String) -> T {
    let data : Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle, error : \(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self): \(error)")
    }
}
