//
//  MemberProfilePicture.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 07/05/21.
//

import SwiftUI

struct MemberProfilePicture: View {
    var image: Image

    var body: some View {
        image
            .resizable()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.init(hex: "3ED598"), lineWidth: 2))
            .shadow(radius: 7)
            //.frame(width: 75, height: 75)
    }
}

struct MemberProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        MemberProfilePicture(image: Image("Placeholder_MemberProfilePicture"))
    }
}
