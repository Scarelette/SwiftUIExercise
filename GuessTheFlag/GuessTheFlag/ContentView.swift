//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 李澄 on 2020/8/7.
//  Copyright © 2020 Scarelette. All rights reserved.
//

import SwiftUI

struct FlagImage: ViewModifier {
    
//    typealias Body = Image
    
    func body(content: Content) -> Content{
        content
//            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2) as! FlagImage.Content
    }

}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var correct = 6
    @State private var animationAmount = 0.0
    var alertMessage: String {
        var message = ""
        if scoreTitle == "Wrong" {
            message = "That’s the flag of \(countries[correctAnswer])! Your score is \(score)"
        } else {
            message = "Your score is \(score)"
        }
        return message
    }
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
//                        Image(self.countries[number])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
//                            .shadow(color: .black, radius: 2)
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule()).modifier(FlagImage())
                    
                    }
                    .rotation3DEffect(.degrees(self.correct == number ? self.animationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.correct == number ? 1 : 0.75)
                }
                
                Text("Your score is \(score)")
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            self.correct = number
            withAnimation {
                self.animationAmount += 360
            }
        } else {
            scoreTitle = "Wrong"
            self.correct = 6
//            self.animationAmount
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
