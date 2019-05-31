//
//  CustomizeLayout.swift
//  CustomizeCollectionLayoutProject
//
//  Created by zhifu360 on 2019/5/29.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class CustomizeLayout: UICollectionViewLayout {

    ///标准状态的Cell的高度
    let normalHeight: CGFloat = 100
    
    ///突出显示的Cell的高度
    let previousHeight: CGFloat = 200
    
    ///standardCell到featuredCell的拖动距离
    let dragOffset: CGFloat = 180
    
    var attributes = [UICollectionViewLayoutAttributes]()
    
    var previousItemIndex: Int {
        get {
            return max(0, Int(collectionView!.contentOffset.y / dragOffset))
        }
    }
    
    var nextItemOffset: CGFloat {
        get {
            return (collectionView!.contentOffset.y / dragOffset) - CGFloat(previousItemIndex)
        }
    }
    
    var width: CGFloat {
        get {
            return collectionView!.bounds.width
        }
    }
    
    var height: CGFloat {
        get {
            return collectionView!.bounds.height
        }
    }
    
    var numberOfItem: Int {
        get {
            return collectionView!.numberOfItems(inSection: 0)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        let contentH = (CGFloat(numberOfItem)*dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentH)
    }
    
    //重写方法
    override func prepare() {
        super.prepare()
        //清空属性数组
        attributes.removeAll()
        
        var frame = CGRect.zero
        var y: CGFloat = 0
        
        for item in 0..<numberOfItem {
            let indexPath = IndexPath(item: item, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            //下一个Cell都在之前的Cell之上
            attribute.zIndex = item
            //初始化时设置Cell的高度为标准高度
            var height = normalHeight
            
            if indexPath.item == previousItemIndex {
                //突出显示的Cell
                let yOffset = normalHeight * nextItemOffset
                y = collectionView!.contentOffset.y - yOffset
                height = previousHeight
            } else if indexPath.item == (previousItemIndex+1) && indexPath.item != numberOfItem {
                //高度渐变的Cell
                let maxY = y + normalHeight
                height = normalHeight + max((previousHeight - normalHeight) * nextItemOffset, 0)
                y = maxY - height
            }
            
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attribute.frame = frame
            attributes.append(attribute)
            
            //获取下一个Cell的初始y值
            y = frame.maxY
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for item in attributes {
            if item.frame.intersects(rect) {
                layoutAttributes.append(item)
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
