//
//  TICK.swift
//  CryptoAPI
//
//  Created by GREEK, DILLON L. on 4/29/24.
//

import Foundation

private var accessToken = "Xmw8lxEKguztuo+9iUWN1A==M2OgF0K47gNJiQAb"

struct TICK: Identifiable, Codable{
   
    var symbol: String
    var price: String
    var id:UUID{
        return UUID()
    }
    init(){
        symbol = ""
        price = ""
    }
    init(symbol: String){
        self.symbol = symbol
        self.price = ""

    }
    func updatePrice(symbol: String) async -> String {
        print("Update Price ", symbol)
        do {
            let tick = try await getTICK(tickInput: symbol)
            
            print("Update Price ", symbol)
            return tick.price
        } catch {
            print(error)
            return ""
        }
    }
    
    func getTICK(tickInput: String) async throws -> TICK {
        guard let url = URL(string: "https://api.api-ninjas.com/v1/cryptoprice?symbol=\(tickInput)")
                else{
                    throw TICKError.invalidURL
                }
        
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
        request.setValue(accessToken, forHTTPHeaderField: "X-Api-Key")
        
                let (data, _) = try await URLSession.shared.data(for:request)
        
                do {
                    //parse Json data to tick
                    let tick = try JSONDecoder().decode(TICK.self, from: data)
                    print("getTICK ", tick)
                    return tick
                } catch {
                    throw TICKError.decodingFailed
                }
            
    }
    //Error handling
    enum TICKError: Error {
        case emptyInput
        case invalidURL
        case decodingFailed
    }
}


