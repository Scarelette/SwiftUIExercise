//
//  ContentView.swift
//  WeSplit
//
//  Created by 李澄 on 2020/8/5.
//  Copyright © 2020 Scarelette. All rights reserved.
//

import SwiftUI

struct TotalAmount: ViewModifier {
    
    func body(content: Content) -> some View {
        content.foregroundColor(.red)
    }
}

struct ContentView: View {
    @State private var numberOfPeople = ""
    @State private var checkAmount = ""
    @State private var tipPercenatge = 2
    @State private var tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercenatge])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandValue = orderAmount + tipValue
        return grandValue
    }
    
    var totalPerson: Double {
        let numOfPeople = Double(numberOfPeople) ?? 0
        let personCount = Double(numOfPeople + 2.0)
        let amountPerPerson = totalAmount / personCount
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
//                    Picker("Number Of People", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) pelple")
//                        }
//                    }
                    TextField("Number Of People", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much do you want?")) {
                    Picker("tip Percentage", selection: $tipPercenatge) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
//                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount Per Person")) {
                    Text("$\(totalAmount)")
                }
                
                Section(header: Text("Total Amount")) {
                    if tipPercenatge == 4 {
                        Text("$\(totalPerson)")
                          .modifier(TotalAmount())
                    } else {
                        Text("$\(totalPerson)")
                    }
                }
                
            }
        .navigationBarTitle("MySplit")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
