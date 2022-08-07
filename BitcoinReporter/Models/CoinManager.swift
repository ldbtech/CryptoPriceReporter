//
//  CoinManager.swift
//  BitcoinReporter
//
//  Created by Ali Daho on 8/7/22.
//

import Foundation

class CoinManager : ObservableObject{
    let baseURL : String = "https://rest.coinapi.io/v1/exchangerate"
    let apikey = "PUT API KEY HERE"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    @Published var crypto : CryptoModel?
    
    func fetchData(cryptoSymbol : String, currency : String){
        let urlString = "\(baseURL)/\(cryptoSymbol)/\(currency)?apikey=\(apikey)"
        print("Ali Daho =>", urlString)
        print(urlString)
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let decodedData = try decoder.decode(CryptoData.self, from: safeData)
                            let lastPrice = decodedData.rate
                            self.crypto = CryptoModel(rate : lastPrice)
                            
                        }catch{
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
}
