//
//  User.swift
//  AccountsDemo
//
//  Created by SD on 06/12/23.
//

import Foundation

struct Account: Codable, Identifiable {
    let id: Int
    let displayName: String
    let accountNumber: String
    let balance: Amount
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName    = "display_name"
        case accountNumber  = "account_number"
        case balance
    }
}

