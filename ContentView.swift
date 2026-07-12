//  ContentView.swift
//  Milestone-Projects1-3
//  Created on 07/09/26.
import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(.black)
            .buttonStyle(.glassProminent)
            .padding(.all, 5)
    }
}
extension View {
    func buttonModifier() -> some View {
        modifier(ButtonModifier())
    }
}

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors", "Rock"]
    
    @State private var playerWins = false
    @State private var currentChoice = Int.random(in: 0..<3)
    
    @State private var isCorrect = false
    @State private var score = 0
    @State private var currentQuestion = 1
    
    @State private var scoreBanner = ""
    @State private var showingFinalScore = false
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(colors: [.blue, .green, .orange], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Rock, Paper, Scissors")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Score: \(score)/10")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                    }
                    .padding(.bottom, 8)
                    
                    VStack {
                        Text("Computer selected: \(moves[currentChoice])")
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                            .font(.title)
                        
                        VStack {
                            if playerWins {
                                Text("You Win")
                                    .font(.title)
                            } else {
                                Text("You Lost")
                                    .font(.title)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    //rock = 0
                    // paper = 1
                    // scissors = 2
                    VStack {
                        Button { //rock
                            if playerWins && currentChoice == 2 {
                                correctAnswer()
                            } else if !playerWins && currentChoice == 1 {
                                correctAnswer()
                            }
                            else {
                                wrongAnswer()
                            }
                            
                            if currentQuestion == 10 {
                                showingFinalScore = true
                            } else {
                                nextQuestion()
                            }
                        } label: {
                            Text("Select: \(moves[0]) ✂️")
                                .buttonModifier()
                        }
                       
                        Button { //paper
                            if playerWins && currentChoice == 0 {
                                correctAnswer()
                            } else if !playerWins && currentChoice == 2 {
                                correctAnswer()
                            } else {
                                wrongAnswer()
                            }
                            
                            if currentQuestion == 10 {
                                showingFinalScore = true
                            } else {
                                nextQuestion()
                            }
                        } label: {
                            Text("Select: \(moves[1]) 🗒️")
                                .buttonModifier()
                        }
                        
                        Button { //scissors
                            if playerWins && currentChoice == 1 {
                                correctAnswer()
                            } else if !playerWins && currentChoice == 0 {
                                wrongAnswer()
                            } else {
                                correctAnswer()
                            }
                            if currentQuestion == 10 {
                                showingFinalScore = true
                            } else {
                                nextQuestion()
                            }
                        } label: {
                            Text("Select: \(moves[2]) 🪨")
                                .buttonModifier()
                        }
                    }
                    .alert("Your score is \(score)", isPresented: $showingFinalScore) {
                        Button("Continue", role: .confirm) {
                            resetGame()
                        }
                    } message: {
                        Text("Great Game! Tap Continue to play again")
                    }
                    
                    Spacer()
                    
                }
            }
        }
    }
    
    func correctAnswer() {
        isCorrect = true
        score += 1
    }
    
    func bothCorrect() {
        isCorrect = false
        score += 0
    }
    
    func wrongAnswer() {
        isCorrect = false
        score -= 1
    }
    
    func nextQuestion() {
        currentQuestion += 1
        currentChoice = Int.random(in: 0..<moves.count)
        playerWins.toggle()
    }
    
    func ifPlayerWinsTheGame() {
        if score == 10 {
            scoreBanner = "You Win!"
        }
    }
    
    func resetGame() {
        if currentQuestion == 10 {
            currentQuestion = 1
            score = 0
            currentChoice = Int.random(in: 0..<3)
            playerWins = Bool.random()
        }
    }
}

#Preview {
    ContentView()
}
