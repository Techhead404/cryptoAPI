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
            VStack{
                Text("Watchlist")
                    .font(.title)
                List{
                    ForEach(saveTick.storedtick){
                        saveTick in
                        HStack{
                            Text(saveTick.symbol)
                            Spacer()
                            Text(String(format: "%.2f", Double(saveTick.price) ?? 0.00))
                                .padding(.trailing, 8)
                                .foregroundColor(.green)
                        }
                    }
                }.refreshable {
                    await saveTick.loadStats()
                }
                
                TextField("Trading Pair", text: $tickInput)
                             .padding()
                             .multilineTextAlignment(.center)
                             .cornerRadius(10)
                             .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                             .padding()
                            
                Button(action: {
                   Task {
                        do {
                            saveTick.addToken(tick: tickInput)
                            await saveTick.loadStats()
                        }
                    }
                }, label: {
                    Label.init("Add to Watchlist", systemImage: "square.and.arrow.up")
                        .padding()
                        .padding()
                }).buttonStyle(.bordered)
            
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

