//
//  AboutView.swift
//  Bulls Eye
//
//  Created by Fabish Apeli on 11/09/2019.
//  Copyright © 2019 Fabish Apeli. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct BodyStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    
    struct HeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bulls Eye 🎯")
                    .modifier(HeadingStyle())
                
                Text(
                    "This is Bulls Eye, the game where you can win points and earn fame by dragging a slider."
                ).modifier(BodyStyle())
                
                Text(
                    "Your goal is to place a slider as close as possible to the target value. The closer you are, the more points you score.").modifier(BodyStyle())
                
                Text("Enjoy!").modifier(BodyStyle())
            }
            .navigationBarTitle("About Bulls Eye")
            .background(beige)
        }.background(Image("Background-2"))
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
