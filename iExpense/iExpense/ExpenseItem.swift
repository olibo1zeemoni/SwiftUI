//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Olibo moni on 02/04/2022.
//

import Foundation

struct ExpenseItem : Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
