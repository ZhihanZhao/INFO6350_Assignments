//
//  ViewController.swift
//  currencyConvert
//
//  Created by 赵芷涵 on 10/21/21.
//

import UIKit
import SwiftSpinner
import SwiftyJSON
import Alamofire

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var firstPickerView: UIPickerView!
    @IBOutlet weak var secondPickerView: UIPickerView!
    @IBOutlet weak var lblResault: UILabel!
    
    var currency = ["EUR","USD","CAD","JPY"]
    var baseURL = "http://api.exchangeratesapi.io/v1/latest?access_key=5d31b19e72b1593b8e0edf2caeb33987&symbols=USD,CAD,JPY"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstPickerView.delegate = self
        self.firstPickerView.dataSource = self
        self.secondPickerView.delegate = self
        self.secondPickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency[row]
    }
    
    
    @IBAction func getRate(_ sender: Any) {
        var fromCountry = currency[firstPickerView.selectedRow(inComponent: 0)]
        var toCountry = currency[secondPickerView.selectedRow(inComponent: 0)]
        
        AF.request(baseURL).response{ response in
            if response.error != nil{
                print(response.error)
                return;
            }
            let result = JSON(response.data!)
            print(result)
            let EUR:Double = 1.0
            let USD:Double = result["rates"]["USD"].doubleValue
            let CAD:Double = result["rates"]["CAD"].doubleValue
            let JPY:Double = result["rates"]["JPY"].doubleValue
            var firstRate:Double
            var secondRate:Double
            
            if fromCountry == "EUR"{
                 firstRate = EUR
            }else if fromCountry == "USD"{
                 firstRate = USD
            }else if fromCountry == "CAD"{
                 firstRate = CAD
            }else{
                 firstRate = JPY
            }
            
            if toCountry == "EUR"{
                 secondRate = EUR
            }else if toCountry == "USD"{
                 secondRate = USD
            }else if toCountry == "CAD"{
                 secondRate = CAD
            }else{
                 secondRate = JPY
            }
            
            self.lblResault.text = " rate is \(secondRate/firstRate)"

            
        }
        
    }

}
