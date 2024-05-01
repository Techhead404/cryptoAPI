//
//  tickClass.swift
//  CryptoAPI
//
//  Created by GREEK, DILLON L. on 5/1/24.
//

import Foundation

class TickStore: ObservableObject{
    @Published var storedtick: [TICK] = [TICK(symbol: "btcusd", price: "0"), TICK(symbol: "ltcusd", price: "0"), TICK(symbol: "xrpusd", price: "0")]
    func loadStats() async {}
    func addToken(tick: String) {}
}
