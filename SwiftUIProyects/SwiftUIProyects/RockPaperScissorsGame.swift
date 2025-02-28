//
//  RockPaperScissorsGame.swift
//  SwiftUIProyects
//
//  Created by Flaminia Castaño on 27/02/2025.
//

import SwiftUI

struct RockPaperScissorsGame: View {
    let moves = ["✊", "✋", "✌️"] // Rock, Paper, Scissors
    
    @State private var appMove = Int.random(in: 0...2)
    @State private var playerScore = 0
    @State private var appScore = 0
    @State private var roundResult: String? = nil
    @State private var selectedMove: Int? = nil
    @State private var gameFinished = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Piedra, papel o tijera!")
                .font(.largeTitle.bold())
            Text("El que llega a 5 puntos primero, gana ✨")
                .font(.subheadline)
                        
            if let result = roundResult, let playerMove = selectedMove {
                VStack {
                    Text("Tu elección:")
                    Text(moves[playerMove])
                        .font(.system(size: 80))
                    
                    Text("La elección de la app:")
                    Text(moves[appMove])
                        .font(.system(size: 80))
                    
                    Text(result)
                        .font(.title)
                        .padding()
                        .background(result.contains("Ganaste") ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                        .padding()
                    if !gameFinished {
                        Button("Siguiente ronda") {
                            newRound()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .font(.title2)
                    }
                }
            } else {
                Text("Elegí una opción:")
                    .font(.title2)
                HStack {
                    ForEach(0..<3) { index in
                        Button(action: {
                            playerChose(index)
                        }) {
                            Text(moves[index])
                                .font(.system(size: 80))
                                .padding()
                        }
                    }
                }
            }
            Text("Puntos tuyos: \(playerScore)")
                .font(.title2)
            Text("Puntos de la app: \(appScore)")
                .font(.title2)
        }
        if gameFinished {
            Button("Jugar de nuevo") {
                restartGame()
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .font(.title2)
        }
    }
    
    func playerChose(_ playerMove: Int) {
        selectedMove = playerMove
        // El índice 0 es Roca, 1 es Papel, 2 es Tijera
        // Las reglas: 0 vence a 2, 1 vence a 0, 2 vence a 1
        let winningMoves = [2, 0, 1]
        let isWin = winningMoves[playerMove] == appMove
        let isDraw = appMove == playerMove
        
        if isDraw {
            roundResult = "Es un empate 😐"
        } else if isWin {
            playerScore += 1
            roundResult = "Ganaste 🎉"
        } else {
            appScore += 1
            roundResult = "Perdiste 😞"
        }
        
        if playerScore == 5 || appScore == 5 {
            gameFinished = true
        }
    }
    
    func newRound() {
        appMove = Int.random(in: 0...2)
        roundResult = nil
        selectedMove = nil
    }
    
    func restartGame() {
        playerScore = 0
        appScore = 0
        gameFinished = false
        roundResult = nil
        selectedMove = nil
        appMove = Int.random(in: 0...2)
    }
}

#Preview {
    RockPaperScissorsGame()
}
