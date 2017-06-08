//
//  ViewController.swift
//  AlertTest
//
//  Created by admin on 17/6/7.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var contentTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        contentTableView.register(UINib(nibName: "STYMainDetailCell", bundle: nil), forCellReuseIdentifier: "STYMainDetailCellID")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource, STYMainDetailCellDelegate{
    
    func qureBtnClick() {
        let vo = TestAlertView()
        _ = vo.initFromNib(backClosure: { (btnId, alertVi) in
            if btnId == "cancleId" {
                print("cancleId")
            }else if btnId == "okId" {
                print("okId")
                
                let new = SecondView()
                _ = new.initFromNib(backClosure: { (btnId, alertVi) in })
                
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "STYMainDetailCellID") as! STYMainDetailCell
        cell.delegate = self
        return cell
    }
    
    
}

