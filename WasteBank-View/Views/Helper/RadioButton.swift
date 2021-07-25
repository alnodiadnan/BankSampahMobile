//
//  RadioButton.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 31/05/21.
//

import SwiftUI

struct RadioButton: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked: Bool
    let callback: (String) -> ()
    
    init(id: String, label: String, size: CGFloat = 22, color: Color = Color.gray, textSize: CGFloat = 16, isMarked: Bool = false, callback: @escaping (String) -> ()) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action: {
            self.callback(self.id)
        }) {
            HStack(spacing: 5) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    //.foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                    
                
                Text(label)
                    .font(Font.system(size: textSize))
                    //.foregroundColor(.gray)
                
            }
            .foregroundColor(self.color)
        }.foregroundColor(Color.white)
    }
}

enum Gender: String {
    case male = "Laki-laki"
    case female = "Perempuan"
}

struct GenderRadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
        HStack(spacing: 20){
            radioMaleMajority
            radioFemaleMajority
        }
    }
    
    var radioMaleMajority: some View {
        RadioButton(id: Gender.male.rawValue, label: Gender.male.rawValue, isMarked: selectedId == Gender.male.rawValue ? true : false, callback: radioGroupCallback)
    }
    
    var radioFemaleMajority: some View {
        RadioButton(id: Gender.female.rawValue, label: Gender.female.rawValue, isMarked: selectedId == Gender.female.rawValue ? true : false, callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

struct EditGenderRadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
        HStack(spacing: 20){
            radioMaleMajority
            radioFemaleMajority
        }
    }
    
    var radioMaleMajority: some View {
        RadioButton(id: Gender.male.rawValue, label: Gender.male.rawValue, isMarked: selectedId == Gender.male.rawValue ? true : false, callback: radioGroupCallback)
    }
    
    var radioFemaleMajority: some View {
        RadioButton(id: Gender.female.rawValue, label: Gender.female.rawValue, isMarked: selectedId == Gender.female.rawValue ? true : false, callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
//        RadioButton(id: "x", label: "Male") { id in
//            print("\(id)")
//        }
        GenderRadioButtonGroups { selected in
            print("Selected Gender Id: \(selected)")
        }
    }
}
