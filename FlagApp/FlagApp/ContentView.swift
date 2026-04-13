//
//  ContentView.swift
//  Flag Game
//
//  Created by Rajabaliyev01 on 11/04/26.
//

import SwiftUI

struct ContentView: View {
    @State private var Countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco","Poland", "Russia","Spain","Nigeria", "UK", "US"] .shuffled()
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    @State private var winnerTitle: String = "You Won!"
    @State private var ShowWinner: Bool = false
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.25, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.52, green: 0.10, blue: 0.35), location: 0.3),
            ], center: .top, startRadius: 400, endRadius: 600)
                .ignoresSafeArea()
          
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Country's Flag!")
                    .foregroundStyle(.cyan)
                    .font(.title.bold())
                VStack(spacing: 30) {
                    VStack (spacing: 20) {
                        Text("Tap the flag of")
                        
                            .foregroundStyle(.secondary)
                            .font(.title.bold())
                        Text(Countries[correctAnswer])
                            .foregroundStyle(.primary)
                            .font(.largeTitle.weight(.semibold, ))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagtapped(number)
                        } label: {
                            Image(Countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.ultraThinMaterial)
                .cornerRadius(30)
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.brown)
                    .font(.title.bold())
                if score == 3 {
                    Text("\(winnerTitle)")
                }
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle,  isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
            
        } message: {
            Text("Your score is: \(score)")
        }

        .alert("You have \(score)", isPresented: $ShowWinner) {

            Button("Restart") {
                score = 0
                askQuestion()
            }
        } message: {
            Text("You Won! 🎉")
            
        }
    }
    func flagtapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
                  if score == 7 {
                      ShowWinner = true
                  } else {
                      showingScore = true
                  }
        } else {
            scoreTitle = "Wrong"
            showingScore = true

        }
    }
    func askQuestion() {
        Countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
}
 #Preview {
    ContentView()
}
