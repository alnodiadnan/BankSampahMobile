//
//  TestNavigationView.swift
//  WasteBank-View
//
//  Created by Alnodi Adnan on 24/05/21.
//

import SwiftUI

struct TestNavigationView: View {
    var body: some View {
        FirstView()
    }
}

struct FirstView: View {
    var body: some View {
        NavigationView {
            Text("First view")
                .navigationBarTitle(Text("First view"), displayMode: .inline)
                .navigationBarItems(trailing:
                    NavigationLink("To second", destination: SecondView())
                )
        }
    }
}
struct SecondView: View {
    @State var isNavigationLinkActive = false
    var body: some View {
        VStack {
            Text("Second view")
            NavigationLink("To third", destination: ThirdView(), isActive: $isNavigationLinkActive)
                .hidden()
        }
        .navigationBarTitle(Text("Second view"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button("To third", action: {
                isNavigationLinkActive = true
            })
        )
    }
}
struct ThirdView: View {
    @State var isNavigationLinkActive = false
    var body: some View {
        VStack {
            Text("Third view")
            NavigationLink("To fourth", destination: FourthView(), isActive: $isNavigationLinkActive)
                .hidden()
        }
        .navigationBarTitle(Text("Third view"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button("To fourth", action: {
                isNavigationLinkActive = true
            })
        )
    }
}
struct FourthView: View {
    var body: some View {
        Text("Fourth view")
            .navigationBarTitle(Text("Fourth view"), displayMode: .inline)
    }
}

struct TestNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TestNavigationView()
    }
}
