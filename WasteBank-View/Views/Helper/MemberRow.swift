//
//  MemberRow.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 07/05/21.
//

import SwiftUI

struct MemberRow: View {
    var member : Member
    @State var formattedJoinDate = "*Date*"
    
    var body: some View {
        ZStack {
            Color.init(hex: "22343C")
                .ignoresSafeArea()
            
            HStack {
    //            MemberProfilePicture(image: member.profilePicture)
    //                .frame(width: 75, height: 75)
                
                MemberProfilePicture(image: Image("Placeholder_MemberProfilePicture"))
                    .frame(width: 75, height: 75)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(member.fullname)")
                        .fontWeight(.heavy)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    
                    Text("Bergabung sejak \(formattedJoinDate)")
                        //.font(.subheadline)
                        .foregroundColor(.gray)
                    
//                    Rectangle()
//                        .frame(width: 250, height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .foregroundColor(.gray)
//                        .padding(.top, 10)
                }
                .padding(.leading, 10)
                
                //Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
                    .padding(.leading, 20)
            }
            .padding()
        }
        .onAppear(perform: {
            self.formattedJoinDate = String(member.createdAt.prefix(10))
        })
    }
}

struct MemberRow_Previews: PreviewProvider {
    static var members = ModelData().members
    
    static var previews: some View {
        Group {
            MemberRow(member: members[0])
            MemberRow(member: members[1])
//            MemberRow()
//            MemberRow()
        }
        //.previewDevice("iPhone 11")
        .previewLayout(.fixed(width: 400, height: 90))
    }
}
