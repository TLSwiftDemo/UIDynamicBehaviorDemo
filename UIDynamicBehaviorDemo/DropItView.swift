//
//  DropItView.swift
//  UIDynamicBehaviorDemo
//
//  Created by Andrew on 16/8/12.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

class DropItView: BeizerPathView,UIDynamicAnimatorDelegate {

    var animating:Bool = false{
        didSet{
            if animating{
                animator.addBehavior(dropBehavior)
            }else{
                
            }
        }
    }
    
    func addDrop() -> Void {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow)*dropSize.width
        
        let drop = UIView(frame: frame)
        drop.backgroundColor = UIColor.random
        
        addSubview(drop)
        
        dropBehavior.addItem(drop)
        lastDrop = drop
    }
    
    var realGravity:Bool = false{
        didSet{
         updateRealGravity()
        }
    }
    
    private var dropBehavior = FallingObejctBehavior()
    
    private lazy var animator:UIDynamicAnimator = {
      let animator = UIDynamicAnimator(referenceView: self)
        animator.delegate = self
        return animator
    }()
    
    
    func updateRealGravity() -> Void {
        if realGravity{
         
        }
    }
    private struct PathNames {
        static let MiddleBarrier = "Middle Barrier"
        static let Attachment = "Attachment"
    }
    
    //MARK: - 吸附效果
    private var lastDrop:UIView?
    private var attachment:UIAttachmentBehavior?{
        willSet{
            if attachment != nil{
                animator.removeBehavior(attachment!)
                beizerPaths[PathNames.Attachment] = nil
            }
        
        }
        
        didSet{
            if attachment != nil{
             animator.addBehavior(attachment!)
                attachment!.action = {[unowned self] in
                    if let attachedDrop = self.attachment!.items.first as? UIView{
                     self.beizerPaths[PathNames.Attachment] = UIBezierPath.lineFrom(self.attachment!.anchorPoint, to:attachedDrop.center)
                    }
                
                }
            }
        }
    }
    
    
    func grapDrop(recognizer:UIPanGestureRecognizer) -> Void {
        let gesturePoint = recognizer.locationInView(self)
        switch recognizer.state {
        case .Began:
            if let dropToAttachTo = lastDrop where dropToAttachTo.superview != nil{
              attachment = UIAttachmentBehavior(item: dropToAttachTo, attachedToAnchor: gesturePoint)
                
            }
            
            lastDrop = nil
            break
        case .Changed:
            //让依附物跟着手势移动
            attachment?.anchorPoint = gesturePoint
            break
        default:
            attachment = nil
        }
    }
    
    //MARK: - UIDynamicAnimatorDelegate
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
       removeCompletedRow()
    }
    
    private func removeCompletedRow() -> Void {
        var dropsToRemove = [UIView]()
        
        var hitTestRect = CGRect(origin: bounds.lowerLeft, size: dropSize)
        
        repeat{
            hitTestRect.origin.x = bounds.minX
            hitTestRect.origin.y -= dropSize.height
            var dropsTested = 0
            var dropsFound = [UIView]()
            
            while dropsTested < dropsPerRow {
                if let hitView = hitTest(hitTestRect.mid) where hitView.superview == self {
                    dropsFound.append(hitView)
                } else {
                    break
                }
                hitTestRect.origin.x += dropSize.width
                dropsTested += 1
            }
            if dropsTested == dropsPerRow {
                dropsToRemove += dropsFound
            }
            
        }while dropsToRemove.count == 0 && hitTestRect.origin.y > bounds.minY
        
        for drop in dropsToRemove {
            dropBehavior.removeItem(drop)
            drop.removeFromSuperview()
        }
    }

    
    // MARK: Private Implementation
    
    private let dropsPerRow = 10
    
    private var dropSize: CGSize {
        let size = bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
}










