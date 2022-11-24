//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Daksh Nakra on 11/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = Array(repeating: "", count: 9)
    @State private var xTurn = true
    @State private var gameOver = false
    @State private var winMessage = ""
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .fontWeight(.bold)
                .font(.title)
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(120), spacing: 15), count: 3), spacing: 15) {
                ForEach(0..<9){ index in
                    ZStack {
                        Color.purple
                        Color.gray
                            .opacity(moves[index] == "" ? 1 : 0)
                        Text(moves[index])
                            .font(.system(size: 90))
                            .fontWeight(.heavy)
                    }
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
                    .onTapGesture {
                        withAnimation(.default) {
                            if moves[index] == "" {
                                moves[index] = xTurn ? "X" : "O"
                                xTurn.toggle()
                            }
                        }
                    }
                    .rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                }
            }
        }
        .preferredColorScheme(.dark)
        .alert(isPresented: $gameOver) {
            Alert(title: Text(winMessage), dismissButton: .destructive(Text("Play Again?"),
                                                                       action: {
                withAnimation {
                    moves = Array(repeating: "", count: 9)
                    gameOver = false
                    xTurn = true
                }
            }))
        }
        .onChange(of: moves) {
            newValue in checkForWinner()
        }
        .padding()
    }
    private func checkForWinner() {
        // rows
        checkLine(a: 0, b: 1, c: 2) // top row
        checkLine(a: 3, b: 4, c: 5) // middle row
        checkLine(a: 6, b: 7, c: 8) // bottom row
        // columns
        checkLine(a: 0, b: 3, c: 6) // left column
        checkLine(a: 1, b: 4, c: 7) // middle column
        checkLine(a: 2, b: 5, c: 8) // right column
        // diagonals
        checkLine(a: 0, b: 4, c: 8) // top-left to bottom-right
        checkLine(a: 2, b: 4, c: 6) // top-right to bottom-left
        // check for a tie
        if !(gameOver || moves.contains("")) {
            winMessage = "Cat's Game! Tied!"
            gameOver = true
        }
    }
    private func checkLine(a: Int, b: Int, c: Int) {
        if moves [a] != "" && moves[a] == moves[b] && moves[b] == moves [c] {
            winMessage = "The \(moves[a]) side has won!"
            gameOver = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
