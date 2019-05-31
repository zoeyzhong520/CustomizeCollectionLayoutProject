//
//  SecondViewController.swift
//  CustomizeCollectionLayoutProject
//
//  Created by zhifu360 on 2019/5/31.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController {

    ///创建UICollectionView
    lazy var collectionView: UICollectionView = {
        let layout = CustomizeFlowLayout()
        let collect = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collect.backgroundColor = UIColor.clear
        collect.delegate = self
        collect.dataSource = self
        collect.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: BaseReuseIdentifier)
        return collect
    }()
    
    ///数据源
    let dataArray = ["1","2","3","4","5","6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    func setPage() {
        title = "LOL卡片风格"
        view.addSubview(collectionView)
//        navigationController?.delegate = self
    }

}

extension SecondViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseReuseIdentifier, for: indexPath)
        let backImg = UIImageView(image: UIImage(named: "\(dataArray[indexPath.row]).jpg"))
        backImg.layer.cornerRadius = 3
        backImg.clipsToBounds = true
        backImg.frame = cell.bounds
        cell.contentView.addSubview(backImg)
        return cell
    }
    
}

extension SecondViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.setNavigationBarHidden(viewController.isKind(of: self.classForCoder), animated: true)
    }
    
}
