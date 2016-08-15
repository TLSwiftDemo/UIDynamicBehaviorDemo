//
//  BeizerPathView.swift
//  UIDynamicBehaviorDemo
//
//  Created by Andrew on 16/8/12.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

class BeizerPathView: UIView {

    var beizerPaths = [String:UIBezierPath](){
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        for (_,path) in beizerPaths {
            path.stroke()
        }
    }
}
