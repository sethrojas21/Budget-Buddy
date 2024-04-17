//
//  ContentView.swift
//  iExpense
//
//  Created by Seth Rojas on 6/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isAddViewShown = false
    @StateObject var expenses = Expenses()
    
    static var preferedCurrency = Locale.current.currency?.identifier ?? "USD"
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(item.type)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: ContentView.preferedCurrency))
                            .foregroundColor(.accentColor)
                    }
                }
                .onDelete(perform: removeItems)
                HStack{
                    Text("Total Cost:")
                        .foregroundColor(.primary)
                        .font(.headline)
                    Spacer()
                    Text(expenses.totalCost, format: .currency(code: ContentView.preferedCurrency))
                        .foregroundColor(.accentColor)
                }
            }.toolbar {
                EditButton()
                
                Button {
                    isAddViewShown = true
                } label: {
                    Image(systemName: "plus")
                }

            }
            .sheet(isPresented: $isAddViewShown){
                AddView(expenses: expenses)
            }
            .navigationTitle("iExpenses")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
