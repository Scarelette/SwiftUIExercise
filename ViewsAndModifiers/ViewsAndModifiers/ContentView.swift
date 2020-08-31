//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 李澄 on 2020/8/8.
//  Copyright © 2020 Scarelette. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.title)
            Text("Hello, World!")
            Text("Hello, World!")
            Text("Hello, World!")
        }
        .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
