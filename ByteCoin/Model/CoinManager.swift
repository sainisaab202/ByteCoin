//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdateBitcoin(_ coinManager: CoinManager, coinData: CoinData)
    func didFailWithError(_ coinManager: CoinManager, error: Error)
}

struct CoinManager {
    
    let bitcoinURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let APIKey = "E22B9478-4833-4267-B213-FF2C3FD4AC56"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String){
        
        let url = bitcoinURL + "/" + currency + getAPIString()
        
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String){
        //1: Create a URL
        if let URL = URL(string: urlString){
            
            //2: Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3: Give URLSession a task
//            let task = session.dataTask(with: URL, completionHandler: handle(data:response:error:))
            
//            with closure
            let task = session.dataTask(with: URL) { (data, response, error) in
                if error != nil{
                    print(error!)
                    delegate?.didFailWithError(self, error: error!)
                    return
                }
                
                if let safeData = data{
                    
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
                    
                    if let coinData = parseJSON(safeData){
                        
//                        update the UIcomponents here
//                        print(rate)
                        
                        delegate?.didUpdateBitcoin(self, coinData: coinData)
                    }else {
                        print("Parsing error...")
                    }
                    
                }
            }
            
            
            //4: Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinData?{
        
        let decorder = JSONDecoder()
        do{
            let decodedData = try decorder.decode(CoinData.self, from: data)
            
//            print(decodedData)
             
            return decodedData
        }catch{
            //print(error)
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }

    /**
     Will return the base URL with the API KEY
     */
    private func getAPIString() -> String{
        return "?apikey=" + APIKey
    }
}
