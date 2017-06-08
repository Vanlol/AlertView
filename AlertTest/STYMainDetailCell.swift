//
//  STYMainDetailCell.swift
//  mlmstylist
//
//  Created by admin on 16/12/7.
//  Copyright © 2016年 美啦美. All rights reserved.
//

import UIKit

protocol STYMainDetailCellDelegate:NSObjectProtocol {
    func qureBtnClick()
}

class STYMainDetailCell: UITableViewCell {
    
    weak var delegate:STYMainDetailCellDelegate?
    
    //阴影View
    @IBOutlet weak var shadowView: UIView!{
        didSet{
            shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
            shadowView.layer.shadowColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0).cgColor
            shadowView.layer.shadowOpacity = 1
            shadowView.layer.cornerRadius = 20
            shadowView.layer.masksToBounds = false
        }
    }
    
    //底部包含view
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = 20
            containerView.layer.masksToBounds = true
        }
    }
    //预约时间label
    @IBOutlet weak var appointTimeLabel: UILabel!
    //追加订单标示
    @IBOutlet weak var goonOrderLab: UILabel!
    //显示产品view
    @IBOutlet weak var productView: UIView!
    
    //用户昵称label
    @IBOutlet weak var nickNameLabel: UILabel!
    //订单金额label
    @IBOutlet weak var orderMoneyLabel: UILabel!
    //拒绝按钮
    @IBOutlet weak var refuseButton: UIButton!{
        didSet{
            refuseButton.isExclusiveTouch = true
            refuseButton.layer.cornerRadius = 4
            refuseButton.layer.masksToBounds = true
            refuseButton.layer.borderWidth = 1.0
            refuseButton.layer.borderColor = UIColor.orange.cgColor
        }
    }
    //接受按钮
    @IBOutlet weak var acceptbutton: UIButton!{
        didSet{
            acceptbutton.isExclusiveTouch = true
            acceptbutton.layer.cornerRadius = 4
            acceptbutton.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //拒绝按钮
    @IBAction func refuseBtnClick(_ sender: UIButton) {
        
    }
    //接单按钮
    @IBAction func acceptBtnClick(_ sender: UIButton) {
        delegate?.qureBtnClick()
    }
    
    
}
