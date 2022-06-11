//
//  ContentView.swift
//  iExpense
//
//  Created by Olibo moni on 31/03/2022.
//

import SwiftUI

//class User: ObservableObject {
//    @Published var firstName = "Bill"
//    @Published var lastName = "Baggins"
//}

struct User: Codable {
    var firstName: String
    var lastName: String
}


struct ContentView: View {
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//    @AppStorage("tapCount") private var tapCount = 0 //UserDefaults.standard.integer(forKey: "Tap")
//    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
               
                Section("Business") {
                    
                }
                
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .accessibilityElement()
                                .accessibilityHint(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(item.amount < 10 ? .red : .black)
                            .background(item.amount < 100  ? .clear : .blue)
                        
                    }.accessibilityElement(children: .combine)
                       // .accessibilityHint(item.type)
                    
                    
                }
                    .onDelete(perform: removeItems)
                
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5.0)
//                    expenses.items.append(expense)
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
            .background(.red)
    }
    
}

//    NavigationView {
//        VStack{
//            List {
//                ForEach(numbers, id: \.self) {
//                    Text("Row \($0)")
//                }
//                .onDelete(perform: removeRows)
//            }
//            Button("Add Number") {
//                numbers.append(currentNumber)
//                currentNumber += 1
//            }
//        }
//        .navigationTitle("onDelete()")
//        .toolbar {
//            EditButton()
//        }
//    }
//}
//func removeRows(at offsets: IndexSet){
//    numbers.remove(atOffsets: offsets)
//}
