//
//  CustomizeFlowLayout.swift
//  CustomizeCollectionLayoutProject
//
//  Created by zhifu360 on 2019/5/31.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class CustomizeFlowLayout: UICollectionViewFlowLayout {

    ///最大旋转角度
    let rotate: CGFloat = CGFloat(35*(Double.pi/180))
    
    ///完成一个过程需要的位移
    let ACTIVE_DISTANCE: CGFloat = 20
    
    //重写方法
    override func prepare() {
        super.prepare()
        //Cell大小
        itemSize = CGSize(width: 300, height: 400)
        //滑动方向
        scrollDirection = .horizontal
        //设置间距
        sectionInset = UIEdgeInsets(top: 0, left: (ScreenSize.width-itemSize.width)/2, bottom: 0, right: (ScreenSize.width-itemSize.width)/2)
        //列间距
        minimumLineSpacing = 0
    }
    
    //返回当前矩形内所有的UICollectionViewLayoutAttributes
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //获取所有UICollectionViewLayoutAttributes
        guard let array = super.layoutAttributesForElements(in: rect) else { fatalError() }
        
        var visibleRect = CGRect.zero
        visibleRect.origin = collectionView!.contentOffset
        visibleRect.size = collectionView!.bounds.size
        
        for attributes in array {
            
            //Cell中心离collectionView中心的位移
            let distance = visibleRect.midX - attributes.center.x
            
            //判断两个矩形是否相交
            if attributes.frame.intersects(rect) {
                let normalizedDistance = distance / ACTIVE_DISTANCE
                
                //ABS取绝对值
                //如果位移小于一个过程所需要的位移
                if abs(distance) < ACTIVE_DISTANCE {
                    //当前位移比上完成一个过程所需位移，得到不完全过程的旋转角度
                    let zoom = rotate*normalizedDistance
                    var transform = CATransform3DIdentity
                    transform.m34 = 1.0/600
                    transform = CATransform3DRotate(transform, -zoom, 0, 1, 0)
                    attributes.transform3D = transform
                    attributes.zIndex = 1
                } else {
                    var transform = CATransform3DIdentity
                    transform.m34 = 1.0/600
                    //向右滑
                    if distance > 0 {
                        transform = CATransform3DRotate(transform, -rotate, 0, 1, 0)
                    } else {
                        transform = CATransform3DRotate(transform, rotate, 0, 1, 0)
                    }
                    
                    attributes.transform3D = transform
                    attributes.zIndex = 1
                    
                }
            }
            
        }
        return array
    }
    
    //允许更新位置
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //proposedContentOffset是没有对齐到网格时本来应该停下的位置
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var offsetAddjustment = MAXFLOAT
        
        //屏幕中心点
        let horizontalCenter = proposedContentOffset.x + collectionView!.bounds.size.width/2
        
        //当前rect
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView!.bounds.size.width, height: collectionView!.bounds.size.height)
        
        guard let array = super.layoutAttributesForElements(in: targetRect) else { fatalError() }
        //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心点的那一个
        for layoutAttributes in array {
            let itemHorizontalCenter = layoutAttributes.center.x
            if abs(itemHorizontalCenter - horizontalCenter) < CGFloat(abs(offsetAddjustment)) {
                //与中心的位移差
                offsetAddjustment = Float(itemHorizontalCenter - horizontalCenter)
            }
            
        }
        
        //返回修改后停下的位置
        return CGPoint(x: proposedContentOffset.x + CGFloat(offsetAddjustment), y: proposedContentOffset.y)
        
    }
    
}
