//
//  MemberCard.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 07/05/21.
//

import SwiftUI

struct MemberCard: View {
    var body: some View {
        VStack {
            Image("Placeholder_MemberProfilePicture")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("*Member Name*")
            
        }
    }
}

struct MemberCard_Previews: PreviewProvider {
    static var previews: some View {
        MemberCard()
            .previewDevice("iPhone 11")
    }
}
