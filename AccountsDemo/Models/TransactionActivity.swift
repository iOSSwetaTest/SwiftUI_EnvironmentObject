//
//  TransactionActivity.swift
//  AccountsDemo
//
//  Created by SD on 06/12/23.
//

import Foundation

struct TransactionHistory: Codable, Identifiable {
    var id: String {
        date
    }
    let date: String
    let activity: [TransactionActivity]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.activity = container.decodeArray(TransactionActivity.self, forKey: .activity)
    }
}

struct TransactionActivity: Codable, Identifiable {
    let id: Int
    let date: String
    let description: String
    let withdrawalAmount: Amount?
    let depositAmount: Amount?
    let balance: Amount
    let uid: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case description
        case withdrawalAmount = "withdrawal_amount"
        case depositAmount = "deposit_amount"
        case balance
        case uid = "transaction_uid"
    }
}
