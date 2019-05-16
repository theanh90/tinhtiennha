//
//  ResultVC.swift
//  TinhTienNha
//
//  Created by AnhBui on 3/12/19.
//  Copyright © 2019 AnhBui. All rights reserved.
//

import UIKit

let MONEY_PER_MONTH = 1200000
let NUMBER_PERSON_HOST = 3 // Anh - Giang - Ngan

enum SegmentTab {
    case tabLeft
    case tabRight
}

class ResultVC: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var electricMonthLabel: UILabel!
    @IBOutlet weak var houseMonthLabel: UILabel!
    @IBOutlet weak var networkMoney: UILabel!
    @IBOutlet weak var waterMoney: UILabel!
    @IBOutlet weak var electricMoney: UILabel!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var huongLabel: UILabel!
    @IBOutlet weak var huongNote: UILabel!
    @IBOutlet weak var hoangAnhLabel: UILabel!
    @IBOutlet weak var hoangAnhNote: UILabel!
    @IBOutlet weak var notifyLabel: UILabel!
    @IBOutlet weak var totalPersonLabel: UILabel!
    @IBOutlet weak var electricWaterPerPersonLabel: UILabel!
    
    // air condition electric
    @IBOutlet weak var kwTotalNumber: UILabel!
    @IBOutlet weak var kwAirOld: UILabel!
    @IBOutlet weak var kwAirNew: UILabel!
    @IBOutlet weak var kwAirPercent: UILabel!
    @IBOutlet weak var kwAirMoney: UILabel!
    @IBOutlet weak var airConditionMoney: UILabel!
    
    // MARK: - Custom Properties
    public var calculateModel: CalculatorMoneyModel!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - IBAction
    @IBAction func closeScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gotoTest(_ sender: Any) {
        let viewC = SegmentAppointmentViewController()
        self.navigationController?.pushViewController(viewC, animated: true)
    }
    
    // MARK: - Support method
    private func setupUI() {
        // nav
        self.navigationController?.isNavigationBarHidden = true
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        self.titleLabel.text = formatter.string(from: Date())
        
        // Background color
        let gradient = Common.makeGradient(forView: self.view,
                                           startColor: UIColor.hexStringToUIColor("#ECEDF1"),
                                           endColor: UIColor.hexStringToUIColor("#E6C4E7"))
        self.view.layer.insertSublayer(gradient, at: 0)
        
        // ===== Real data
        // Air condition
        if calculateModel.electricAirNew <= 0 || calculateModel.electricAirOld <= 0 ||
            calculateModel.electricTotal <= 0 {
            return
        }
        
        let airKwNum = Double(calculateModel.electricAirNew - calculateModel.electricAirOld)
        let airPercentTotal = airKwNum/Double(calculateModel.electricTotal)
        let airMoneyTotal = Double(calculateModel.electricMoney) * airPercentTotal
        kwTotalNumber.text = "\(calculateModel.electricTotal) kw"
        kwAirOld.text = "\(calculateModel.electricAirOld) kw"
        kwAirNew.text = "\(calculateModel.electricAirNew) kw"
        kwAirPercent.text = String(format: "%.0f kw (%.2f%%)", airKwNum, airPercentTotal * 100)
        kwAirMoney.text = "\(formatNumberToMoney(Int(airMoneyTotal)))"
        airConditionMoney.text = kwAirMoney.text
        
            // common
        let total = calculateModel.networkMoney  + calculateModel.waterMoney +
                    calculateModel.electricMoney - Int(airMoneyTotal)
        let totalPerson = NUMBER_PERSON_HOST + calculateModel.huongMemberCount + calculateModel.hoangAnhMemberCount
        let electricWaterPerPerson = total / totalPerson
        
        totalPersonLabel.text = "\(totalPerson)"
        electricWaterPerPersonLabel.text = formatNumberToMoney(total) + " / \(totalPerson) = " + formatNumberToMoney(electricWaterPerPerson)
        electricMonthLabel.text = "Tiền điện nước tháng \(calculateModel.electricMonth)"
        houseMonthLabel.text = "Tiền nhà tháng \(calculateModel.houseMonth)"
        networkMoney.text = formatNumberToMoney(calculateModel.networkMoney)
        waterMoney.text = formatNumberToMoney(calculateModel.waterMoney)
        electricMoney.text = formatNumberToMoney(calculateModel.electricMoney)
        totalMoney.text = formatNumberToMoney(total)
        notifyLabel.text = calculateModel.notify
        
            // c Huong
        let huongMonth = (MONEY_PER_MONTH +
                            (calculateModel.huongMemberCount * electricWaterPerPerson) +
                            calculateModel.huongMoreMoney) + Int(airMoneyTotal)
        var huongMore = ""
        if calculateModel.huongMoreMoney != 0 {
            if calculateModel.huongMoreMoney > 0 {
                huongMore = " + \(formatNumberToMoney(calculateModel.huongMoreMoney)) "
            } else {
                huongMore = " - \(formatNumberToMoney(abs(calculateModel.huongMoreMoney))) "
            }
        }
        huongLabel.text = "(" + formatNumberToMoney(electricWaterPerPerson) +
                            " * \(calculateModel.huongMemberCount)) + \(formatNumberToMoney(MONEY_PER_MONTH)) + " +
                            "\(formatNumberToMoney(Int(airMoneyTotal)))" +
                            huongMore + " = " + formatNumberToMoney(huongMonth)
        huongNote.text = calculateModel.huongNote
        
            // a Hoang Anh
        let haMonth = (MONEY_PER_MONTH +
                        (calculateModel.hoangAnhMemberCount * electricWaterPerPerson) +
                        calculateModel.hoangAnhMoreMoney)
        var haMore = ""
        if calculateModel.hoangAnhMoreMoney != 0 {
            if calculateModel.hoangAnhMoreMoney > 0 {
                haMore = " + \(formatNumberToMoney(calculateModel.hoangAnhMoreMoney)) "
            } else {
                haMore = " - \(formatNumberToMoney(abs(calculateModel.hoangAnhMoreMoney))) "
            }
        }
        hoangAnhLabel.text = "(" + formatNumberToMoney(electricWaterPerPerson) +
                                " * \(calculateModel.hoangAnhMemberCount)) + \(formatNumberToMoney(MONEY_PER_MONTH))" +
                                haMore +
                                " = " + formatNumberToMoney(haMonth)
        hoangAnhNote.text = calculateModel.hoangAnhNote
    }
    
    private func formatNumberToMoney(_ money: Int) -> String {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        
        let result = numberFormatter.string(from: NSNumber(integerLiteral: money))
        return result ?? ""
    }

}

// make number is negative
extension Int {
    func toNegative() -> Int {
        return self * -1
    }
}
