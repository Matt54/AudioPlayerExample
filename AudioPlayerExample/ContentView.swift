//
//  ContentView.swift
//  AudioPlayerExample
//
//  Created by Matt Pfeiffer on 1/14/21.
//

import SwiftUI

struct ContentView: View {
    var conductor = Conductor()
    
    var body: some View {
        Text("Hello, audio player!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
