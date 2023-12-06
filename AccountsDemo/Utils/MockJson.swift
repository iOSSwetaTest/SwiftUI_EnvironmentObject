//
//  APIManager.swift
//  AccountsDemo
//
//  Created by SD on 06/12/23.
//

import Foundation

enum MockJson: String {
    case accounts = "listOfAccounts"
    case transactions = "accountTransactions"
}

extension MockJson {
    
    private func generate<C: Codable>(ofType type: C.Type) -> C? {
        Helper.loadJson(fileName: self.rawValue, type: type)
    }
    
    
}

extension MockJson {
    
    static func fetchUserAccount() -> [Account] {
        MockJson.accounts.generate(ofType: [Account].self) ?? []
    }
    
    static func getTransactionHistory(accountId: String) -> [TransactionHistory] {
        guard let data = Helper.getDataFromJson(fileName: MockJson.transactions.rawValue) else {
            return []
        }
        guard let jsonArray = data.getJsonObject(of: [[String: Any]].self) else {
            return []
        }
        guard let historyJson = jsonArray.first(where: {
            $0.keys.contains(accountId)
        }) else {
            return []
        }
        guard let activityArray = historyJson[accountId] as? [Any] else {
            return []
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: activityArray)
            return try JSONDecoder().decode([TransactionHistory].self, from: data)
        } catch {
            print(error)
        }
        return []
    }
}


