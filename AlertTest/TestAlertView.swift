//
//  TestAlertView.swift
//  AlertTest
//
//  Created by admin on 17/6/7.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class TestAlertView: UIView {
    
    var viewMod:BasicViewModel!
    var btnClickClosure:((String,TestAlertView) -> Void)?
    
    func initFromNib(backClosure:@escaping ((String,TestAlertView) -> Void)) -> TestAlertView {
        let vi = UINib(nibName: "TestAlertView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! TestAlertView
        vi.btnClickClosure = backClosure
        vi.viewMod = BasicViewModel()
        vi.viewMod.showAlertView(alertView: vi, animation: .BottomInTopOut)
        return vi
    }
    
    @IBAction func closeBtnClick(_ sender: Any) {
        viewMod.animationStop()
        viewMod.animationDidStopClosure = {() -> Void in
            self.btnClickClosure!("cancleId",self)
        }
    }
    
    @IBAction func qureBtnClick(_ sender: Any) {
        viewMod.animationStop()
        viewMod.animationDidStopClosure = {() -> Void in
            self.btnClickClosure!("okId",self)
        }
    }
    
    
}
