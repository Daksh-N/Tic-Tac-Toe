//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Daksh Nakra on 11/22/22.
//

// When you get to this again, Start at step 8: Determine all winning possibilities

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
            Alert(title: Text(winMessage))
        }
        .onChange(of: moves) {
            newValue in checkForWinner()
        }
        .padding()
    }
    private func checkForWinner() {
        if moves [0] != "" && moves[0] == moves[1] && moves[1] == moves [2] {
            winMessage = "The \(moves[0]) side has won!"
            gameOver = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
