//
//  TransactionHistoryScreen.swift
//  AccountsDemo
//
//  Created by SD on 06/12/23.
//

import SwiftUI

struct TransactionHistoryScreen: View {
    let accountId: String
    @State private var history: [TransactionHistory] = []
    var body: some View {
        List(history) { data in
            Section(content: {
                ForEach(data.activity) { activity in
                    TransactionActivityCell(activity: activity)
                }
            }, header: {
                Text(data.date).listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            })
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Transaction History")
        .task {
            if history.isEmpty {
                history = MockJson.getTransactionHistory(accountId: accountId)
            }
        }
    }
}

struct TransactionActivityCell: View {
    let activity: TransactionActivity
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(activity.description)
                    .font(.subheadline)
                Text("Balance: \(activity.balance.formatted)")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }.frame(maxWidth: .infinity, alignment: .leading)
            Group {
                if let depositAmount = activity.depositAmount {
                    Text("+ \(depositAmount.formatted)")
                        .foregroundStyle(.green)
                } else if let withdrawalAmount = activity.withdrawalAmount {
                    Text("- \(withdrawalAmount.formatted)")
                        .foregroundStyle(.red)
                }
            }.fontWeight(.semibold)
        }
    }
}

struct TransactionHistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryScreen(accountId: "10")
    }
}

//Can use macros in Xcode15 instead of PreviewProvider
/*#Preview {
    NavigationStack {
        TransactionHistoryScreen(accountId: "10")
    }
}*/
