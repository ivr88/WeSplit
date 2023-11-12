import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    let tipPercentages = [0, 5, 10, 15, 20]
    var totaPerperson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker ("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text ("\($0) people")
                        }
                    }
                }
                
                Section ("How much tip do you want to leave") {
                    Picker ("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text ($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text (totaPerperson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
