//
//  AdminMenu.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 22/06/21.
//

import SwiftUI

struct AdminMenu: View {
    @EnvironmentObject var userLoggedOnInfo : UserLoggedOnInfo
    
    @State var isShowingMemberList : Bool = false
    @State var isShowingSellHistory : Bool = false
    
    @State var anggotaActive = true
    @State var penjualanActive = false
    @State var requestActive = false
    
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(hex: "22343C")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 10) {
    //                    Text("ADMINISTRASI")
    //                        .font(.system(size: 40))
    //                        .bold()
    //                        .padding(.top)
    //
    //                    Text("Bank Sampah Gawe Rukun")
    //                        .font(.system(size: 32))
    //                        .bold()
                        
                        HStack(spacing: 15) {
                            ZStack {
    //                            Image("Placeholder")
    //                                .resizable()
    //                                .frame(width: 85, height: 85)
                                Rectangle()
                                    .cornerRadius(20)
                                    .foregroundColor(anggotaActive ? Color.init(hex: "3ED598") : Color.init(hex: "30444E"))
                                    .frame(width: 120, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Text("Anggota")
                                    .foregroundColor(anggotaActive ? .white : .gray)
                            }
                            .onTapGesture {
                                //self.isShowingMemberList.toggle()
                                
                                self.anggotaActive = true
                                self.penjualanActive = false
                                self.requestActive = false
                                
                            }
                            
                            ZStack {
    //                            Image("Placeholder")
    //                                .resizable()
    //                                .frame(width: 85, height: 85)
    //
    //                            Text("Penjualan")
                                Rectangle()
                                    .cornerRadius(20)
                                    .foregroundColor(penjualanActive ? Color.init(hex: "3ED598") : Color.init(hex: "30444E"))
                                    .frame(width: 120, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Text("Penjualan")
                                    .foregroundColor(penjualanActive ? .white : .gray)
                                
                                
                            }
                            .onTapGesture {
                                //self.isShowingSellHistory.toggle()
                                
                                self.anggotaActive = false
                                self.penjualanActive = true
                                self.requestActive = false
                            }
                            
                            ZStack {
    //                            Image("Placeholder")
    //                                .resizable()
    //                                .frame(width: 85, height: 85)
    //
    //                            Text("Permintaan Setor")
                                
                                
                                Rectangle()
                                    .cornerRadius(20)
                                    .foregroundColor(requestActive ? Color.init(hex: "3ED598") : Color.init(hex: "30444E"))
                                    .frame(width: 120, height: 85, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Text("Permintaan")
                                    .foregroundColor(requestActive ? .white : .gray)
                            }
                            .onTapGesture {
                                //self.isShowingSellHistory.toggle()
                                
                                self.anggotaActive = false
                                self.penjualanActive = false
                                self.requestActive = true
                            }
                        }
                        .padding(.top, 30)
                        //.padding(.horizontal, )
                        
                        
                        if anggotaActive {
                            MemberList(membersList: ModelData().members)
                        }
                        else if penjualanActive {
                            SellHistory(sellTransactionList: ModelData().sellTransactions)
                        }
                        else if requestActive {
                            AdminSaveRequestList()
                        }
                    }
                    
                    NavigationLink(destination: MemberList(), isActive: $isShowingMemberList) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: SellHistory(), isActive: $isShowingSellHistory) {
                        EmptyView()
                    }
                }
                .navigationTitle("Menu Admin")
                .navigationBarTitleDisplayMode(.inline)
            }

        }
    }
}

struct AdminMenu_Previews: PreviewProvider {
    static var previews: some View {
        AdminMenu(tabSelection: .constant(4))
            .environmentObject(UserLoggedOnInfo())
    }
}
