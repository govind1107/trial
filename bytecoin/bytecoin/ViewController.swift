//
//  ViewController.swift
//  bytecoin
//
//  Created by Govind Lipne on 13/03/21.
//  Copyright © 2021 Govind Lipne. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
   
  
    
    
    var coinmanager = CoinManager()

    @IBOutlet weak var ValueLbl: UILabel!
    @IBOutlet weak var UnitLbl: UILabel!
    
    @IBOutlet weak var Currency: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Currency.dataSource = self
        Currency.delegate = self
        coinmanager.delegate = self
    }

    }
    
    
    
    
    




extension ViewController : UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinmanager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinmanager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(coinmanager.currencyArray[row])
        let selectedCurrency = coinmanager.currencyArray[row]
        self.UnitLbl.text = coinmanager.currencyArray[row]
        coinmanager.getCoinPrice(for: selectedCurrency)
    }
}
extension ViewController : mydelegate {
    
    func didUpdatePrice(price: String) {
        DispatchQueue.main.async {
            self.ValueLbl.text = price
        }
        
}
}
