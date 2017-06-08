//
//  SecondView.swift
//  AlertTest
//
//  Created by admin on 17/6/8.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class SecondView: UIView {
    
    var viewMod:BasicViewModel!
    var btnClickClosure:((String,SecondView) -> Void)?
    
    func initFromNib(backClosure:@escaping ((String,SecondView) -> Void)) -> SecondView {
        let vi = UINib(nibName: "SecondView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SecondView
        vi.btnClickClosure = backClosure
        vi.viewMod = BasicViewModel()
        vi.viewMod.showAlertView(alertView: vi, animation: .BottomInTopOut)
        return vi
    }
    
    
}
