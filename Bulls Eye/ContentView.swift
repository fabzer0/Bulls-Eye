//
//  ContentView.swift
//  BullsEye
//
//  Created by Fabish Apeli on 10/09/2019.
//  Copyright © 2019 Fabish Apeli. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var currentScore = 0
    @State var rounds = 1
    
    struct LableStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .modifier(Shadow())
                .modifier(FontStyle())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.red)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct FontStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 20))
        }
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            // The target row
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LableStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            // The slider row
            HStack {
                Text("1").modifier(LableStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LableStyle())
            }
            Spacer()
            // The button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("Hit Me!")
                    .modifier(ButtonStyle())
                    
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text("\(alertTitle())"),
                    message: Text(
                        "The slider's value is \(sliderValueRounded()). " +
                        "You scored \(score()) points this round."
                    ),
                    dismissButton: .default(Text("Awesome!")) {
                        self.currentScore += self.score()
                        self.target = Int.random(in: 1...100)
                        self.rounds += 1
                    })
            }
            .background(Image("Button-2"))
            Spacer()
            // The score row
            HStack {
                Button(action: {
                    self.resetGame()
                }) {
                    HStack {
                        Image("StartOverIcon-1")
                        Text("Start over")
                        .modifier(ButtonStyle())
                    }
                }
                .background(Image("Button-2"))
                Spacer()
                Text("Total Score:").modifier(LableStyle())
                Text("\(currentScore)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LableStyle())
                Text("\(rounds)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon-1")
                        Text("Info")
                        .modifier(ButtonStyle())
                        
                    }
                }
                .background(Image("Button-2"))
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background-1"), alignment: .center)
        .navigationBarTitle("Bulls Eye")
    }
    
    func score() -> Int {
        let score = 100 - amountOff()
        let bonus: Int
        if amountOff() == 0 {
            bonus = 100
        } else if amountOff() == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return score + bonus
    }
    
    func amountOff() -> Int {
        abs(target -  sliderValueRounded())
    }
    
    func sliderValueRounded() -> Int {
        Int(sliderValue.rounded())
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect 🥳"
        } else if difference < 5 {
            title = "You almost had it 🤭"
        } else if difference <= 10 {
            title = "Not bad 🤥"
        } else {
            title = "Are you even trying? 😏"
        }
        return title
    }
    
    func resetGame() {
        sliderValue = 50.0
        target = Int.random(in: 1...100)
        currentScore = 0
        rounds = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

