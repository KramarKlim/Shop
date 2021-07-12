//
//  ItemViewController.swift
//  Shop
//
//  Created by Клим on 12.07.2021.
//

import UIKit

class ItemViewController: UIViewController {
    
    let pickerViewInfo = PickerViewInformation()
    
    let countPickerView = UIPickerView()
    let sizePickerView = UIPickerView()
    
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    var image: UIImage?
    var name: String?
    var price: Int?
    
    @IBOutlet var sizeTextField: UITextField!
    @IBOutlet var countTextField: UITextField!
    
    @IBOutlet var itemImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstSetting()
        pickerViewSettings()
        priceToLabel()
        
    }
    
    @IBAction func countTextFieldAction(_ sender: Any) {
        priceToLabel()
    }
    
    @IBAction func saveAction() {
        guard let size = sizeTextField.text else { return }
        if size.isEmpty {
            showAlert(title: "Не указан размер", message: "Укажите размер")
        } else {
            DataBase.shared.saveItem(name: nameLabel.text, count: countTextField.text, size: sizeTextField.text, price: priceLabel.text)
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    private func firstSetting() {
        nameLabel.text = name
        itemImage.image = image
        doneButton.layer.cornerRadius = 10
    }
    
    private func pickerViewSettings() {
        countPickerView.dataSource = self
        countPickerView.delegate = self
        
        sizePickerView.dataSource = self
        sizePickerView.delegate = self
        
        countTextField.inputView = countPickerView
        countTextField.textAlignment = .center
        
        
        sizeTextField.inputView = sizePickerView
        sizeTextField.textAlignment = .center
        
        sizePickerView.tag = 1
        countPickerView.tag = 2
    }
    
    private func priceToLabel() {
        let allPrice = Int(countTextField.text!) ?? 0
        priceLabel.text = String(price! * allPrice) + " " + "рублей"
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension ItemViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1: return pickerViewInfo.size.count
        case 2:  return pickerViewInfo.count.count
        default: return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1: return String(pickerViewInfo.size[row])
        case 2: return String(pickerViewInfo.count[row])
        default: return "No information"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            sizeTextField.text = String(pickerViewInfo.size[row])
            sizeTextField.resignFirstResponder()
        case 2:
            countTextField.text = String(pickerViewInfo.count[row])
            countTextField.resignFirstResponder()
        default: break
        }
    }
    
}
