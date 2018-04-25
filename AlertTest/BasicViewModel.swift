//
//  BasicViewModel.swift
//  AlertTest
//
//  Created by admin on 17/6/7.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

enum BasicAnimation {
    case BottomInBottomOut,BottomInTopOut,BottomInInsetBottomOut  //
}

class BasicViewModel:NSObject {
    //MARK: 蒙版后面的视图
    fileprivate lazy var bottomVi:UIView = {
        let vi = UIView()
        vi.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        vi.isUserInteractionEnabled = true
        vi.backgroundColor = UIColor.clear
        return vi
    }()
    //MARK: 背景蒙版
    fileprivate lazy var backgroundView:UIView = {
        let vi = UIView()
        vi.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        vi.isUserInteractionEnabled = false
        vi.backgroundColor = UIColor.black.withAlphaComponent(0.8)//backView.backgroundColor = UIColor(white: 0.3, alpha: 0.8)
        return vi
    }()
    //MARK: 弹出框视图
    fileprivate var alertVi:UIView!
    //MARK: 动画样式
    fileprivate var animationStyle:BasicAnimation!
    //MARK: 动画时间
    var animationDuration = 0.6
    //MARK: 动画执行完成后调用
    var animationDidStopClosure:(() -> Void)?
    //MARK: 距离底部边距
    var bottomInset:CGFloat = 15
    
    override init() {
        super.init()
        let window = UIApplication.shared.windows[0]
        addBackgroundView(window: window)
    }
    //MARK: WINDOW添加蒙版
    fileprivate func addBackgroundView(window:UIWindow) {
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapGestureFunc))
        backgroundView.addGestureRecognizer(tapGes)
        window.addSubview(bottomVi)
        window.addSubview(backgroundView)
    }
    //MARK: 点击蒙版移除视图方法
    @objc fileprivate func tapGestureFunc(){
        animationStop()
    }
    //MARK: 弹框上添加的手势
    @objc fileprivate func alertGestureFunc(){}
    
    func showAlertView(alertView:UIView,animation:BasicAnimation) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(alertGestureFunc))
        alertView.addGestureRecognizer(tap)
        alertView.center = CGPoint(x: backgroundView.center.x, y: UIScreen.main.bounds.height + alertView.bounds.height*0.5)
        alertView.bounds = CGRect(x: 0, y: 0, width: alertView.bounds.size.width, height: alertView.bounds.size.height)
        backgroundView.addSubview(alertView)
        
        alertVi = alertView
        animationStyle = animation
        animationStart()
    }
    //MARK: 开始动画的方法
    fileprivate func animationStart() {
        switch animationStyle! {
        case .BottomInBottomOut:
            bottomInAnimation()
        case .BottomInTopOut:
            bottomInAnimation()
        case .BottomInInsetBottomOut:
            bottomInAnimation()
        }
    }
    //MARK: 结束动画的方法
    func animationStop() {
        switch animationStyle! {
        case .BottomInBottomOut:
            bottomOutAnimation()
        case .BottomInTopOut:
            topOutAnimation()
        case .BottomInInsetBottomOut:
            bottomOutAnimation()
        }
    }
    /**---------------------------UIViewAnimation,BEGIN---------------------------**/
    //MARK: 弹框从底部进入的动画
    fileprivate func bottomInAnimation() {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn, animations: {
            if self.animationStyle == .BottomInBottomOut {
                self.alertVi.center = CGPoint(x: self.backgroundView.center.x, y: UIScreen.main.bounds.height - self.alertVi.bounds.height*0.5)
            }else if self.animationStyle == .BottomInTopOut{
                self.alertVi.center = self.backgroundView.center
            }else if self.animationStyle == .BottomInInsetBottomOut {
                self.alertVi.center = CGPoint(x: self.backgroundView.center.x, y: UIScreen.main.bounds.height - self.alertVi.bounds.height*0.5 - self.bottomInset)
            }
        }, completion: { (finished) in
            if finished { self.backgroundView.isUserInteractionEnabled = true }
        })
    }
    //MARK: 弹框从底部出去的动画
    fileprivate func bottomOutAnimation() {
        backgroundView.isUserInteractionEnabled = false
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
            self.alertVi.center = CGPoint(x: self.backgroundView.center.x, y: UIScreen.main.bounds.height + self.alertVi.bounds.height*0.5 + self.bottomInset)
        }, completion: { (finished) in
            if finished {
                self.bottomVi.removeFromSuperview()
                self.backgroundView.removeFromSuperview()
                self.animationDidStopClosure?()
            }
        })
    }
    //MARK: 弹框从顶部出去的动画
    fileprivate func topOutAnimation() {
        backgroundView.isUserInteractionEnabled = false
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
            self.alertVi.center = CGPoint(x: self.backgroundView.center.x, y: -self.alertVi.bounds.height*0.5)
        }, completion: { (finished) in
            if finished {
                self.bottomVi.removeFromSuperview()
                self.backgroundView.removeFromSuperview()
                self.animationDidStopClosure?()
            }
        })
    }
    /**---------------------------UIViewAnimation,END---------------------------**/
    
    
}

