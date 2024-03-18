//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblBitcoin: UILabel!
    @IBOutlet weak var pickerCurrency: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //setting pickerview datasource/delegate to self
        pickerCurrency.dataSource = self
        pickerCurrency.delegate = self
        
        
        coinManager.delegate = self
        
        //getting data related to first selected
        if pickerCurrency.numberOfRows(inComponent: 0) > 0 {
            coinManager.getCoinPrice(for: coinManager.currencyArray[0])
        }
    }

    // numberOfComponenets means how many columns we need in our pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // number of row we need in our pickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    //insert data in our PickerView for each row this method will be called with different row and component value. row is row  and component is column
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    // everytime user select a new value, row number of seleted value will be catch here
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(coinManager.currencyArray[row])
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
    
//    updates the UI once we get data from api call
    func didUpdateBitcoin(_ coinManager: CoinManager, coinData: CoinData) {
        DispatchQueue.main.async{
            self.lblCurrency.text = coinData.asset_id_quote
            self.lblBitcoin.text = String(format: "%.2f", coinData.rate)
            self.imgIcon.image = self.imgIcon.image == UIImage(systemName: "bitcoinsign.square.fill") ?  UIImage(systemName: "bitcoinsign.square") :  UIImage(systemName: "bitcoinsign.square.fill")
        }
    }
    
    func didFailWithError(_ coinManager: CoinManager, error: Error) {
        print(error.localizedDescription)
    }
}

