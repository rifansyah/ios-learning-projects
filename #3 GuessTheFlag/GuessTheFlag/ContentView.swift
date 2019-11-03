import SwiftUI

struct ContentView: View {
  private let endStage = 10
  
  @State private var flagImageNames = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var stage = 1
  @State private var score = 0
  @State private var selectedFlag = Int.random(in: 0 ..< 3)
  @State private var showResult = false
  
  var selectedFlagText : String {
    return flagImageNames[selectedFlag]
  }
  
  func newQuestion() {
    selectedFlag = Int.random(in: 0 ..< 3)
    flagImageNames = flagImageNames.shuffled()
  }
  
  func flagTapped(_ number: Int) {
    if (number == selectedFlag) {
      score += 1
    }
    if (stage == endStage) {
      showResult = true
      return
    }
    stage += 1
    newQuestion()
  }
  
  func newGame() {
    selectedFlag = Int.random(in: 0 ..< 3)
    flagImageNames = flagImageNames.shuffled()
    score = 0
    stage = 1
  }
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .bottom, endPoint: .top)
        .edgesIgnoringSafeArea(.all)
      VStack(spacing: 10) {
        Text("\(stage) / \(endStage)")
          .foregroundColor(.white)
        Text("Tap the flag to guess")
          .foregroundColor(.white)
        Text(selectedFlagText)
          .font(.largeTitle)
          .fontWeight(.bold)
          .foregroundColor(.white)
        Spacer().frame(height: 20)
        ForEach(0 ..< 3) { number in
          Button(action: {
            self.flagTapped(number)
          }) {
            Image(self.flagImageNames[number])
              .renderingMode(.original)
              .clipShape(Capsule())
              .overlay(Capsule().stroke(Color.black, lineWidth: 2))
              .shadow(color: .black, radius: 2)
          }
          Spacer().frame(height: 10)
        }
      }
    }
    .alert(isPresented: $showResult) {
      Alert(title: Text("The game is over"), message: Text("Your score : \(score) / \(endStage) correct"), dismissButton: .default(Text("New Game"), action: {
        self.newGame()
      }))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
