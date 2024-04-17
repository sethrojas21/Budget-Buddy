//
//  AddView.swift
//  iExpense
//
//  Created by Seth Rojas on 6/28/23.
//

import SwiftUI

struct AddView: View {
    @State var name: String = ""
    @State var type: String = "Personal"
    @State var amount: Double = 0.0
    
    let types = ["Business", "Personal"]
    
    @ObservedObject var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self){ type in
                        Text(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: ContentView.preferedCurrency))
                    .keyboardType(.decimalPad)
            }
            .toolbar{
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
            .navigationTitle("Add New Expense")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
