//
//  CryptoAPIApp.swift
//  CryptoAPI
//
//  Created by GREEK, DILLON L. on 4/29/24.
//

import SwiftUI

@main
struct CryptoAPIApp: App {
    @StateObject private var saveTick = TickStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(saveTick)
        }
    }
}
