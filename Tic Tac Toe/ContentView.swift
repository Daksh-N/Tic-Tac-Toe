//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Daksh Nakra on 11/22/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .fontWeight(.bold)
                .font(.title)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
