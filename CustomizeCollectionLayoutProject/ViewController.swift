//
//  ViewController.swift
//  CustomizeCollectionLayoutProject
//
//  Created by zhifu360 on 2019/5/29.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
        setButtonView()
    }

    func setPage() {
        title = "演示"
    }

    func setButtonView() {
        let btns = ["高度渐变风格","LOL卡片风格"]
        let btnW: CGFloat = 150
        let btnH: CGFloat = 50
        let verticalMargin: CGFloat = 33
        
        for i in 0..<btns.count {
            let btn = UIButton(frame: CGRect(x: (ScreenSize.width - btnW)/2, y: 200+CGFloat(i)*(btnH+verticalMargin), width: btnW, height: btnH))
            btn.setTitle(btns[i], for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = RandomColor()
            btn.layer.cornerRadius = 3
            btn.tag = i
            btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
            view.addSubview(btn)
        }
    }
    
    @objc func btnAction(_ btn: UIButton) {
        if btn.tag == 0 {
            //高度渐变风格
            navigationController?.pushViewController(FirstViewController(), animated: true)
        } else {
            //LOL卡片风格
            navigationController?.pushViewController(SecondViewController(), animated: true)
        }
    }
    
}

