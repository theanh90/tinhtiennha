//
//  ViewController.swift
//  TinhTienNha
//
//  Created by AnhBui on 3/12/19.
//  Copyright © 2019 AnhBui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var houseMonthTextField: UITextField!
    @IBOutlet weak var electricMonthTextField: UITextField!
    @IBOutlet weak var networkMoneyTextField: UITextField!
    @IBOutlet weak var electricMoneyTextField: UITextField!
    @IBOutlet weak var waterMoneyTextField: UITextField!
    @IBOutlet weak var haMemberCountTextField: UITextField!
    @IBOutlet weak var haMoreTextField: UITextField!
    @IBOutlet weak var huongMemberCountTextfield: UITextField!
    @IBOutlet weak var huongMoreTextField: UITextField!
    @IBOutlet weak var haMoreButton: UIButton!
    @IBOutlet weak var huongMoreButton: UIButton!
    @IBOutlet weak var huongNoteTextView: UITextView!
    @IBOutlet weak var haNoteTextView: UITextView!
    @IBOutlet weak var commonNoteTextView: UITextView!
    

    // MARK: - Custom Properties
    let bag = DisposeBag()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRx()
    }
    
    // MARK: - IBAction
    @IBAction func goToResultScreen(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultVC")
            as! ResultVC
        let param = CalculatorMoneyModel()
        param.electricMonth = Int(electricMonthTextField.text!) ?? 0
        param.houseMonth = Int(houseMonthTextField.text!) ?? 0
        param.networkMoney = Int(networkMoneyTextField.text!) ?? 0
        param.waterMoney = Int(waterMoneyTextField.text!) ?? 0
        param.electricMoney = Int(electricMoneyTextField.text!) ?? 0
        param.notify = commonNoteTextView.text
        param.huongMemberCount = Int(huongMemberCountTextfield.text!) ?? 0
        param.huongMoreMoney = Int(huongMoreTextField.text!) ?? 0
        param.huongNote = huongNoteTextView.text
        param.hoangAnhMemberCount = Int(haMemberCountTextField.text!) ?? 0
        param.hoangAnhMoreMoney = Int(haMoreTextField.text!) ?? 0
        param.hoangAnhNote = haNoteTextView.text
        
        var huongMore = Int(huongMoreTextField.text!) ?? 0
        if !huongMoreButton.isSelected {
            huongMore = huongMore.toNegative()
        }
        param.huongMoreMoney = huongMore
        
        var haMore = Int(haMoreTextField.text!) ?? 0
        if !haMoreButton.isSelected {
            haMore = haMore.toNegative()
        }
        param.hoangAnhMoreMoney = haMore        
        
        vc.calculateModel = param
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupRx() {
        haMoreButton.rx.controlEvent(.touchUpInside)
            .subscribe { [weak self] (event) in
                guard let `self` = self else { return }
                self.haMoreButton.isSelected = !self.haMoreButton.isSelected
        }
        .disposed(by: bag)
        
        huongMoreButton.rx.controlEvent(.touchUpInside)
            .subscribe { [weak self] (event) in
                guard let `self` = self else { return }
                self.huongMoreButton.isSelected = !self.huongMoreButton.isSelected
            }
            .disposed(by: bag)
    }
    
    // MARK: - Support method
    private func setupUI() {
        // Nav
        self.navigationController?.isNavigationBarHidden = true
        
        // button
        haMoreButton.setImage(UIImage(named: "minus"), for: .normal)
        haMoreButton.setImage(UIImage(named: "plus"), for: .selected)
        huongMoreButton.setImage(UIImage(named: "minus"), for: .normal)
        huongMoreButton.setImage(UIImage(named: "plus"), for: .selected)
        
        // Input default value
        let format = DateFormatter()
        format.dateFormat = "M"
        let currentMonth = format.string(from: Date())
        houseMonthTextField.text = currentMonth
        electricMonthTextField.text = "\(Int(currentMonth)! - 1)"
    }

}

