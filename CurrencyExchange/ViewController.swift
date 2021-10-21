//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by Sally Wang on 10/20/21.
//

import UIKit
import SwiftSpinner
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    let baseUrl = (Bundle.main.infoDictionary?["BASE_URL"] as? String)!
    let accessKey = (Bundle.main.infoDictionary?["ACCESS_KEY"] as? String)!
    var pickerData : [String] = ["USD", "GBP", "JPY", "EUR", "CNY"]
    var fromCurrency : String = ""
    var toCurrency : String = ""

    @IBOutlet weak var toPicker: UIPickerView!
    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var resultLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fromPicker.delegate = self
        self.fromPicker.dataSource = self
        self.toPicker.delegate = self
        self.toPicker.dataSource = self
        print(baseUrl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fromPicker.selectRow(0, inComponent: 0, animated: true)
        self.toPicker.selectRow(0, inComponent: 0, animated: true)
        fromCurrency = pickerData[0]
        toCurrency = pickerData[0]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
            case fromPicker:
            fromCurrency = pickerData[row]
            case toPicker:
                toCurrency = pickerData[row]
            default:
                break
        }
    }

    @IBAction func convertBtn(_ sender: Any) {
        getCurrencyRate(fromCurrency, toCurrency)
    }
    
    func getCurrencyRate(_ from: String, _ to: String) {
        let url = baseUrl + "?access_key=" + accessKey + "&symbols=" + from + "," + to
        print(url)
        SwiftSpinner.show("Getting latest currency rate");
        AF.request(url).responseJSON { response in
            SwiftSpinner.hide()
            
            switch response.result {
            case .success(let value):
                let responseSucessResult = value as! [String:Any]
                let error = responseSucessResult["error"]
                let success = responseSucessResult["success"]
                if error != nil {
                    print(error!)
                    return
                } else if success != nil {
                    let rates = responseSucessResult["rates"] as! [String:Double]
                    let fromToRate = Float(rates[to]!/rates[from]!)
                    self.resultLbl.text = "1 \(from) = \(fromToRate) \(to)"
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}

