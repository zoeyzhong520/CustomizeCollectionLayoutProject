//
//  FirstViewController.swift
//  CustomizeCollectionLayoutProject
//
//  Created by zhifu360 on 2019/5/29.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {

    ///创建UICollectionView
    lazy var collectionView: UICollectionView = {
        let layout = CustomizeLayout()
        let collect = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collect.backgroundColor = UIColor.clear
        collect.delegate = self
        collect.dataSource = self
        collect.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: BaseReuseIdentifier)
        if #available(iOS 11, *) {
            collect.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        return collect
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    func setPage() {
        title = "高度渐变风格"
        view.addSubview(collectionView)
//        navigationController?.delegate = self
    }

}

extension FirstViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseReuseIdentifier, for: indexPath)
        cell.backgroundColor = RandomColor()
        return cell
    }
    
}

extension FirstViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.setNavigationBarHidden(viewController.isKind(of: self.classForCoder), animated: true)
    }
    
}
