//
//  ViewController.swift
//  UIDynamicBehaviorDemo
//
//  Created by Andrew on 16/8/12.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gameView:DropItView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        initView()
    }
    
    func initView() -> Void {
        gameView = DropItView(frame: self.view.bounds)
        gameView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(gameView)
        
        gameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addDrop(_:))))
        gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: #selector(DropItView.grapDrop(_:))))
        gameView.realGravity = true
    }
    
    func addDrop(gesture:UITapGestureRecognizer) -> Void {
        if gesture.state == .Ended{
         gameView.addDrop()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        gameView.animating = true
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        gameView.animating = false
    }
   


}

