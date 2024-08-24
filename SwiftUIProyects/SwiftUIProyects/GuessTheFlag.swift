//
//  GuessTheFlag.swift
//  SwiftUIProyects
//
//  Created by Flaminia Castaño on 24/08/2024.
//

import SwiftUI

struct GuessTheFlag: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showimgScore = false
    @State private var alertTitle = ""
    @State private var score = 0
    private var correctAnswerText = "You've earned 10 points!"
    private var wrongAnswerText = "You’ve lost 5 points"
    @State private var alertText = ""
    @State private var rounds = 1
    @State private var showFinishGame = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.0, green: 0.3, blue: 0.6), location: 0.3),
                .init(color: Color(red: 0.4, green: 0.8, blue: 0.6), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(color: .white, radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(alertTitle, isPresented: $showimgScore) {
            Button("Continue") {
                if rounds < 8 {
                    askQuestion()
                    rounds += 1
                } else {
                    alertTitle = "You finished the game with a score of \(score)."
                    showFinishGame = true
                }
            }
        } message: {
            Text("\(alertText)")
        }
        .alert(alertTitle, isPresented: $showFinishGame) {
            Button("Start again") {
                score = 0
                showFinishGame = false
                showimgScore = false
                rounds = 1
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            alertTitle = "Correct"
            score += 10
            alertText = correctAnswerText
        } else {
            alertTitle = "Wrong"
            score -= 5
            alertText = wrongAnswerText
        }
        showimgScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    GuessTheFlag()
}
