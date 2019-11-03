import SwiftUI

struct ContentView: View {
  private let model = SleepCalculator()
  
  @State private var wakeUpTime = defaultWakeUpTime
  @State private var amountOfSleep = 2.0
  @State private var amountOfCoffee = 0
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showAlert = false
  
  static var defaultWakeUpTime : Date {
    var component = DateComponents()
    component.hour = 4
    component.minute = 0
    
    return Calendar.current.date(from: component) ?? Date()
  }
  
  func calculateBedTime() {
    let calComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
    let hoursInSec = (calComponents.hour ?? 0) * 3600
    let minutesInSec = (calComponents.minute ?? 0) * 60
    
    do {
      let prediction = try model.prediction(wake: Double(hoursInSec + minutesInSec), estimatedSleep: amountOfSleep, coffee: Double(amountOfCoffee))
      
      let actualSleepTime = wakeUpTime - prediction.actualSleep
      
      let formatter = DateFormatter()
      formatter.timeStyle = .short
      
      alertTitle = "Your best sleep time : "
      alertMessage = formatter.string(from: actualSleepTime)
    } catch {
      alertTitle = "Error"
      alertMessage = "Couldn't predict your better sleep time :("
    }
    showAlert = true
  }
  
  var body: some View {
    NavigationView {
      Form {
        Text("When do you want to wake up ?")
        DatePicker("Please entere a time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
          .labelsHidden()
          .datePickerStyle(WheelDatePickerStyle())
        VStack(alignment: .leading, spacing: 0.0) {
          Text("Desired amount of sleep")
            .font(.headline)
          Stepper(value: $amountOfSleep, in: 4...12, step: 0.25) {
            Text("\(amountOfSleep, specifier: "%g") hours")
          }
        }
        VStack(alignment: .leading, spacing: 0) {
          Text("Daily Coffee intake")
            .font(.headline)
          Picker("Coffee Amount :", selection: $amountOfCoffee) {
            ForEach(0 ..< 8) {
              Text("\($0)")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
      }
      .navigationBarTitle(Text("Better Rest"), displayMode: .inline)
      .navigationBarItems(trailing: Button(action: calculateBedTime) {
        Text("Calculate")
      })
        .alert(isPresented: $showAlert) {
          Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
