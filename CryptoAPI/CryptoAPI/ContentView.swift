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
    @State var tick: TICK = TICK()
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
                            Text(saveTick.price)
                        }
                    }
                        
                    
                }
                TextField("Enter Crypto Ticker", text: $tickInput)
                             .padding()
                             .multilineTextAlignment(.center)
                             .cornerRadius(5)
                Button(action: {
                   Task {
                        do {
                            tick = try await getTICK()
                            isShowingTickInfo.toggle()
                            tickInput = tick.symbol ?? "LTCBTC"
                            print(tick)
                        } catch {
                            print(error)
                        }
                    }
                }, label: {
                    Label.init("Add to Watchlist", systemImage: "magnifyingglass")
                        .padding()
                        .padding()
                })
            
            }.sheet(isPresented: $isShowingTickInfo, content: {
                tickInfoView(tick: $tick)
            })
          
        }.onAppear(perform: {
            Task {
                do {
                    tick = try await getTICK()
                    tickInput = tick.symbol ?? ""
                }
            }
        })
        
    }

}
#Preview {
    ContentView()
        .environmentObject(TickStore())
}

