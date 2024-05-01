//
//  tickClass.swift
//  CryptoAPI
//
//  Created by GREEK, DILLON L. on 5/1/24.
//

import Foundation
import SwiftUI

class TickStore: ObservableObject{
    @Published var storedtick: [TICK] = [TICK(symbol: "btcusd"), TICK(symbol: "ltcusd"), TICK(symbol: "xrpusd")]
    func loadStats() async {
        load()
        for i in 0..<storedtick.count {
            let symbol = storedtick[i].symbol
            let updatedPrice = await storedtick[i].updatePrice(symbol: symbol)
            DispatchQueue.main.async {
                self.storedtick[i].price = updatedPrice
                print(self.storedtick[i])
            }
        }
    }
    func addToken(tick: String) {
        let newtick = TICK(symbol: tick)
        storedtick.append(newtick)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(storedtick) {
            UserDefaults.standard.set(encodedData, forKey: "savedTicks")
        }
    }
    
    func load() {
        if let savedData = UserDefaults.standard.data(forKey: "savedTicks") {
            let decoder = JSONDecoder()
            if let decodedActivities = try? decoder.decode([TICK].self, from: savedData) {
                storedtick = decodedActivities
            }
        }
    }
}

