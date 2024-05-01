//
//  TICK.swift
//  CryptoAPI
//
//  Created by GREEK, DILLON L. on 4/29/24.
//

import Foundation

struct TICK: Identifiable, Codable{
    private var accessToken = "Xmw8lxEKguztuo+9iUWN1A==M2OgF0K47gNJiQAb"
    let symbol: String
    var price: String
    var id:UUID{
        return UUID()
    }
    init(){
        symbol = ""
        price = ""
    }
    init(symbol: String, price: String){
        self.symbol = symbol
        self.price = price
        
            
    }
    func updatePrice(symbol: String)-> String{
        var price = ""
        Task{
            do{
                price = try await getTICK(tickInput: symbol).price
            } catch{
                
            }
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


