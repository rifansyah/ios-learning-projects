import SwiftUI

struct ContentView: View {
  private let tipPercentages = [0, 10, 15, 20, 25, 30, 50]
  private let numberOfPeoples = [2,3,4,5,6,7,8]
  @State private var amount = ""
  @State private var numberOfPeople = 0
  @State private var selectedTipPercentage = 0
  
  var totalPerPerson : Double {
    let peopleCount = Double(numberOfPeoples[numberOfPeople])
    let tipLeaved = Double(tipPercentages[selectedTipPercentage])
    let cost = Double(amount) ?? 0
    return (cost + tipLeaved) / peopleCount
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
            Text("Cost per person : $\(totalPerPerson, specifier: "%.2f")")
        }
        Section {
            TextField("Amount :",text: $amount)
                .keyboardType(.decimalPad)
            
            Picker("Number of people", selection: $numberOfPeople) {
                ForEach (0 ..< numberOfPeoples.count) {
                    Text("\(self.numberOfPeoples[$0])")
                }
            }
        }
        Section(header: Text("How much tip you want to leave : ")) {
            Picker("Select tip percentage", selection: $selectedTipPercentage) {
                ForEach (0 ..< tipPercentages.count) {
                    Text("\(self.tipPercentages[$0])")
                }
            }
                .pickerStyle(SegmentedPickerStyle())
        }
      }
      .navigationBarTitle("WeSplit", displayMode: .inline)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
