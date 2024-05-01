//
//  ContentView.swift
//  CryptoAPI
//
//  Created by GREEK, DILLON L. on 4/29/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //access token is needed
    
    @State var tickInput = ""
    @State var isShowingTickInfo = false
    @EnvironmentObject private var saveTick: TickStore
    
    
    var body: some View {
        ZStack{
            //Color.black.ignoresSafeArea()
            VStack{
                Text("Watchlist")
                    .font(.title)
                List{
                    ForEach(saveTick.storedtick){
                        saveTick in
                        HStack{
                            Text(saveTick.symbol)
                            Text(String(format: "%.2f", Double(saveTick.price) ?? 0.00))
                        }
                    }
                }.refreshable {
                    await saveTick.loadStats()
                }
                
                TextField("Enter Crypto Ticker", text: $tickInput)
                             .padding()
                             .multilineTextAlignment(.center)
                             .cornerRadius(5)
                Button(action: {
                   Task {
                        do {
                            saveTick.addToken(tick: tickInput)
                            await saveTick.loadStats()
                        } catch {
                            print(error)
                        }
                    }
                }, label: {
                    Label.init("Add to Watchlist", systemImage: "magnifyingglass")
                        .padding()
                        .padding()
                })
            
            }
          
        }.onAppear(perform: {
            Task {
                do {
                    await saveTick.loadStats()
                   
                }
            }
        })
        
    }

}
#Preview {
    ContentView()
        .environmentObject(TickStore())
}

