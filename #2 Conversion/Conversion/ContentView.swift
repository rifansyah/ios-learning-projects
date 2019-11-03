import SwiftUI

struct ContentView: View {
  private let conversionTypes = ["temp", "length", "time", "volume"]
  private let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
  private let lengthUnits = ["meters", "kilometers", "feet"]
  private let timeUnits = ["seconds", "minutes", "hours"]
  private let volumeUnits = ["milliliters", "liters", "cups"]
  
  @State private var selectedConversionType = 0
  @State private var selectedFromIndex = 0
  @State private var selectedToIndex = 0
  @State private var fromText = ""
  @State private var toText = ""
  
  var getConversionUnits : [String] {
    switch conversionTypes[selectedConversionType] {
      case "temp":
        return temperatureUnits
      case "length":
        return lengthUnits
      case "time":
        return timeUnits
      case "volume":
        return volumeUnits
      default:
        return []
    }
  }
  
  var fromInputToBase : Double {
    switch getConversionUnits[selectedFromIndex] {
    case "Fahrenheit":
      return ((Double(fromText) ?? 0) * 5 / 9) - 32
    case "Kelvin":
      return (Double(fromText) ?? 0) - 273
    case "kilometers":
      return (Double(fromText) ?? 0) * 1000
    case "feet":
      return (Double(fromText) ?? 0) / 3.2808
    case "minutes":
      return (Double(fromText) ?? 0) * 60
    case "hours":
      return (Double(fromText) ?? 0) * 3600
    case "liters":
      return (Double(fromText) ?? 0) * 1000
    case "cups":
      return (Double(fromText) ?? 0) / 0.0042268
    default:
      return Double(fromText) ?? 0
    }
  }
  
  var fromBaseToOutput : Double {
    switch getConversionUnits[selectedToIndex] {
      case "Fahrenheit":
        return fromInputToBase * 1.8 + 32
      case "Kelvin":
        return fromInputToBase + 273
      case "kilometers":
        return fromInputToBase / 1000
      case "feet":
        return fromInputToBase * 3.2808
      case "minutes":
        return fromInputToBase / 60
      case "hours":
        return fromInputToBase / 3600
      case "liters":
        return fromInputToBase / 1000
      case "cups":
        return fromInputToBase * 0.0042268
      default:
        return fromInputToBase
    }
  }

  var body: some View {
      NavigationView {
        Form {
          Section(header: Text("Select conversion unit : ")) {
            Picker("Select conversion unit : ", selection: $selectedConversionType) {
              ForEach (0 ..< conversionTypes.count) {
                Text("\(self.conversionTypes[$0])")
              }
            }.pickerStyle(SegmentedPickerStyle())
          }
          
          Section(header: Text("From")) {
            HStack {
              TextField("Value", text: $fromText)
                .keyboardType(.decimalPad)
              Divider()
              Picker("", selection: $selectedFromIndex) {
                ForEach (0 ..< getConversionUnits.count) {
                  Text("\(self.getConversionUnits[$0])")
                }
              }
                .frame(width: 100)
            }
          }
          
          Section(header: Text("To")) {
            HStack {
              Text("\(fromBaseToOutput)")
              Spacer()
              Divider()
              Picker("", selection: $selectedToIndex) {
                ForEach (0 ..< getConversionUnits.count) {
                  Text("\(self.getConversionUnits[$0])")
                }
              }
                .frame(width: 100)
            }
          }
      }
      .navigationBarTitle("Covert it", displayMode: .inline)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
