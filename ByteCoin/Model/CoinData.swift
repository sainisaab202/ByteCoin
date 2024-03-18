//
//  CoinData.swift
//  ByteCoin
//
//  Created by GurPreet SaiNi on 2024-03-18.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable{
//    let time: Date
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
