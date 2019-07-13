//
//  CalculatorMoneyModel.swift
//  TinhTienNha
//
//  Created by AnhBui on 3/13/19.
//  Copyright © 2019 AnhBui. All rights reserved.
//

import UIKit

class CalculatorMoneyModel: NSObject {
    var electricMonth: String = ""
    var houseMonth: Int = 0
    var networkMoney: Int = 0
    var waterMoney: Int = 0
    var electricMoney: Int = 0
    var notify: String?
    
    //   Huong
    var huongMemberCount: Int = 0
    var huongMoreMoney: Int = 0
    var huongNote: String?
    
    //   Hoang Anh
    var hoangAnhMemberCount: Int = 0
    var hoangAnhMoreMoney: Int = 0
    var hoangAnhNote: String?
    
    // Me
    var meMemberCount: Int = 0
    
    // air condition electric
    var electricAirOld: Int = 0
    var electricAirNew: Int = 0
    var electricTotal: Int = 0
}
