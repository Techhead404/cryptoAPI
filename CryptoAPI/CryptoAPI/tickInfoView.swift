//
//  tickInfoView.swift
//  CryptoAPI
//
//  Created by GREEK, DILLON L. on 4/29/24.
//

import SwiftUI
struct tickInfoView: View {
    @Binding var tick: TICK
    
    @State private var isShowingMap = false
    
    var body: some View {
        ZStack {
            //Color.black.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Coin:")
                        Text(tick.symbol ?? "")
                }
                HStack {
                    Text("Coin:")
                    Text(tick.price ?? "")
                }
               

            }
            .padding()
          
        }
    }
}
