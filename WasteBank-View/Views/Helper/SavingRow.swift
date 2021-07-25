//
//  SavingRow.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 03/06/21.
//

import SwiftUI

struct SavingRow: View {
    var saving : Saving
    //let formattedAmount = String(format: "%.2f", saving.amount)
    @State var showingDetail = false
    
    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
        }) {
            ZStack {
                NavigationLink(destination: SavingDetail(savingSelected: saving), isActive: $showingDetail){
                    EmptyView()
                }
                
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: ScreenSize.width * 0.9, height: ScreenSize.height * 0.1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.init(hex: "30444E"))
                
                VStack {
                    HStack {
                        //                Rectangle()
                        //                    .fill(Color.black)
                        //                    .frame(width: ScreenSize.width * 0.15, height: ScreenSize.height * 0.075)
                        //                    .padding(.leading, 10)
                        
                        Image("Waste_\(saving.type)")
                            .resizable()
                            .frame(width: ScreenSize.width * 0.15, height: ScreenSize.height * 0.065)
                            //.padding(.leading, )
                            //.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 10)
                        
                        VStack(spacing: 15) {
                            HStack {
                                Text(saving.type)
                                    .foregroundColor(.white)
                                    .padding(.leading, 20)
                                
                                Text("\(String(format: "%.2f", saving.amount)) Kg")
                                    .bold()
                                    .padding(.leading, 70)
                                    //.padding(.trailing, 20)
                                    .foregroundColor(.white)
                            }
                            
                            HStack {
                                Image(systemName: "creditcard")
                                    .foregroundColor(.white)
                                
                                Text("Rp")
                                    .foregroundColor(.white)
                                
                                Text("\(saving.earning.formattedWithSeparator)")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .offset(x: -5)
                            }
                        }
                        
                        
                        
                        
                        //Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding(.leading, 20)
                        
                    }
                    .padding()
                    //                    .onTapGesture {
                    //                        self.showingDetail.toggle()
                    //                    }
                }
            }
        }
        
        
    }
}

struct SavingRow_Previews: PreviewProvider {
    static var savings = ModelData().savings
    
    static var previews: some View {
        SavingRow(saving: savings[1])
        
        SavingRow(saving: savings[0])
            .previewDevice("iPhone 8")
    }
}
