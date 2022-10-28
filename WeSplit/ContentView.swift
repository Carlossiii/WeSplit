//
//  ContentView.swift
//  WeSplit
//
//  Created by Carlos Vinicius on 25/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    // A computed property that returns the result of what is the total for each people
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // A computed property that returns the total amount with the addition of some tip percentage chosen
    var totalWithTip: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    // A computed property that takes the current state of the currency code on the device
    var currencyType: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyType)
                        .keyboardType(.decimalPad)
                    // Tracks if the "Done" button above the keyboard is pressed, hiding the keyboard if so
                        .focused($amountIsFocused)
                    
                    // Creates a list to select how many people to split the check
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach (2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker ("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0)%")
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyType)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(totalWithTip, format: currencyType)
                } header: {
                    Text("Total amount with tip")
                }
                // A thernary modifier to the section, changing the color based on the tipPercentage
                .foregroundColor(tipPercentage == 0 ? .red : .accentColor)
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    // Hides the keyboard
                    Button("Done") {
                        amountIsFocused = false

                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
