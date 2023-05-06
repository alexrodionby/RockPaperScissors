//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Alexandr Rodionov on 3.05.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var allMoves = ["Камень", "Ножницы", "Бумага"]
    @State private var computerMove = ""
    @State private var computerScore = 0
    @State private var playerScore = 0
    @State private var gameOver = false
    @State private var moveTitle = "Начнем?"
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    HStack {
                        Text("Компьютер")
                            .frame(width: geometry.size.width / 2, height: 50, alignment: .center)
                            .font(.title)
                            .foregroundColor(.white)
                        Text("Игрок")
                            .frame(width: geometry.size.width / 2, height: 50, alignment: .center)
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    HStack {
                        Text("\(computerScore)")
                            .font(.system(size: 50))
                            .frame(width: geometry.size.width / 2, height: 50, alignment: .center)
                            .foregroundColor(.white)
                        Text("\(playerScore)")
                            .font(.system(size: 50))
                            .frame(width: geometry.size.width / 2, height: 50, alignment: .center)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text(moveTitle)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                    HStack {
                        if computerMove == "Камень" {
                            Text("🪨")
                                .font(.system(size: 100))
                        } else if computerMove == "Ножницы" {
                            Text("✂️")
                                .font(.system(size: 100))
                        } else if computerMove == "Бумага" {
                            Text("📄")
                                .font(.system(size: 100))
                        } else {
                            Text("⁉️")
                                .font(.system(size: 100))
                        }
                    }
                    Spacer()
                    HStack(spacing: 30) {
                        Button {
                            playerTapButton("Камень")
                        } label: {
                            Text("🪨")
                                .font(.system(size: geometry.size.width / 4))
                        }
                        Button {
                            playerTapButton("Ножницы")
                        } label: {
                            Text("✂️")
                                .font(.system(size: geometry.size.width / 4))
                        }
                        
                        Button {
                            playerTapButton("Бумага")
                        } label: {
                            Text("📄")
                                .font(.system(size: geometry.size.width / 4))
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Игра: Камень, ножницы, бумага.")
                .navigationBarTitleDisplayMode(.inline)
                .alert("Конец игры!", isPresented: $gameOver) {
                    Button("Начать заново") {
                        computerScore = 0
                        playerScore = 0
                        gameOver = false
                        moveTitle = "Начнем?"
                    }
                } message: {
                    if computerScore > playerScore {
                        Text("Skynet победил!")
                    } else {
                        Text("Человечество победило!")
                    }
                }
            }
            .background {
                LinearGradient(colors: [.red, .black], startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
        }
    }
    
    func playerTapButton(_ move: String) {
        computerMove = allMoves.randomElement() ?? ""
        
        switch move {
        case "Камень":
            if computerMove == move {
                moveTitle = "Одинаково"
            } else {
                checkAnswer("Бумага")
            }
        case "Ножницы":
            if computerMove == move {
                moveTitle = "Одинаково"
            } else {
                checkAnswer("Камень")
            }
        default: if computerMove == move {
            moveTitle = "Одинаково"
        } else {
            checkAnswer("Ножницы")
        }
        }
        if computerScore == 10 || playerScore == 10 {
            gameOver = true
        }
    }
    
    func checkAnswer(_ variant: String) {
        if computerMove == variant {
            computerScore += 1
            moveTitle = "+1 Skynet"
        } else {
            playerScore += 1
            moveTitle = "+1 Человечеству"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
