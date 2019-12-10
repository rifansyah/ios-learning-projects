
import SwiftUI

struct AddItemView: View {
    @State private var name = ""
    @State private var type = ""
    @State private var amount = ""
    
    @ObservedObject var expenses: Expenses
    
    @Environment(\.presentationMode) var presentationMode
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Add name of your expense", text: $name)
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                
                Picker("Type", selection: $type) {
                    ForEach(self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                Spacer()
            
            }
        .padding()
        .navigationBarTitle(Text("Add Expense"))
            .navigationBarItems(trailing: Button(action: {
                if let actualAmount = Int(self.amount) {
                    let expense = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(expense)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Save")
            })
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(expenses: Expenses())
    }
}
