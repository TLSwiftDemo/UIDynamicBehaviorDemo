//
//  FallingObejctBehavior.swift
//  UIDynamicBehaviorDemo
//  自定义的动画行为
//  Created by Andrew on 16/8/12.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

class FallingObejctBehavior: UIDynamicBehavior {

    //重力行为
    let gravity = UIGravityBehavior()
    //碰撞效果
    private let collider : UICollisionBehavior = {
    
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        
        return collider
    }()
    
    
    private let itemBehavior :UIDynamicItemBehavior = {
     let dib = UIDynamicItemBehavior()
        dib.allowsRotation = true
        dib.elasticity = 0.74
        return dib
    }()
    
    func addBarrier(path:UIBezierPath,name:String) -> Void {
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    
    
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(itemBehavior)
    }
    
    
    func addItem(item:UIDynamicItem) -> Void {
        gravity.addItem(item)
        collider.addItem(item)
        itemBehavior.addItem(item)
    }
    
    func removeItem(item:UIDynamicItem) -> Void {
        gravity.removeItem(item)
        collider.removeItem(item)
        itemBehavior.removeItem(item)
    }
    
    
    
    
    
}
