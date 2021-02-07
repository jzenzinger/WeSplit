//
//  ContentView.swift
//  WeSplit
//
//  Created by Jiří Zenzinger on 07.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    
    let tips = [0, 5, 10, 15, 20, 25]
    
    var body: some View {
        ZStack {
            NavigationView {
                Form {
                    Section(header: Text("Input section")) {
                        TextField("Amount", text: $checkAmount)
                            .keyboardType(.decimalPad)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2 ..< 100) {
                                Text("\($0) people")
                            }
                        }
                    }
                    Section(header: Text("How much tip do you want to leave?")) {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(0 ..< tips.count) {
                                Text("\(self.tips[$0]) %")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Total amount")) {
                        Text("\(totalCheck, specifier: "%.2f") $")
                    }
                    Section(header: Text("Amount per person")) {
                        Text("\(totalPerPerson, specifier: "%.2f") $")
                    }
                }
                .navigationBarTitle("WeSplit")
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tips[tipPercentage])
        let amount = Double(checkAmount) ?? 0
        
        let tipValue = amount / 100 * tipSelection
        let grandTotal = amount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var totalCheck: Double {
        let tipSelection = Double(tips[tipPercentage])
        let amount = Double(checkAmount) ?? 0
        
        let tipValue = amount / 100 * tipSelection
        let grandTotal = amount + tipValue
        
        return grandTotal
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
