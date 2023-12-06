//
//  AccountsScreen.swift
//  AccountsDemo
//
//  Created by SD on 06/12/23.
//

import SwiftUI

struct AccountsScreen: View {
    @EnvironmentObject private var settings: Settings
    @State private var accounts: [Account] = []
    var body: some View {
        NavigationStack {
            accountListView
                .navigationTitle("Accounts")
                .toolbar {
                    //Xcode15 can use .topBarTrailing instead of .navigationBarTrailing
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Quit") {
                            settings.doLogout()
                        }.tint(.red)
                    }
                }
                .task {
                    if accounts.isEmpty {
                        accounts = MockJson.fetchUserAccount()
                    }
                }
        }
    }
    
    var accountListView: some View {
        List(accounts) { account in
            NavigationLink(destination: {
                TransactionHistoryScreen(accountId: String(account.id))
            }, label: {
                AccountInfoCell(account: account)
            })
        }
        .listStyle(.grouped)
    }
}

struct AccountInfoCell: View {
    let account: Account
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("# \(account.accountNumber)")
                    .fontWeight(.semibold)
                Text(account.displayName)
                    .foregroundStyle(.gray)
            }.frame(maxWidth: .infinity, alignment: .leading)
            Text(account.balance.formatted)
                .foregroundStyle(.blue)
        }
        
    }
}

struct AccountsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountsScreen()
    }
}

//Can use macros in Xcode15 instead of PreviewProvider
/*#Preview {
    AccountsScreen()
}*/
