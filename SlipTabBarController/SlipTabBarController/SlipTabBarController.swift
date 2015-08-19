//
//  SlipTabBarController.swift
//  SlipTabBarController
//
//  Created by Damin on 15-8-19.
//  Copyright (c) 2015年 imstlife. All rights reserved.
//

import UIKit

class SlipTabBarController: UITabBarController {

    /// 用来记录当前选中按钮
    private var currentSelectedButton = UIButton()
    /// 用来指示选中的背景
    private var selectionIndicatorImageView: UIImageView!
    /// 单个item的宽度
    private var itemWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 记录TabBarController自带TabBar的位置
        let rect = self.tabBar.frame
        // 移除TabBarController自带的TabBar
        self.tabBar.removeFromSuperview()
        
        // 自定义TabBar的背景
        let backgroundView = UIView(frame: rect)
        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "TabBarBG")!)
        
        self.view.addSubview(backgroundView)
        
        itemWidth = backgroundView.frame.size.width / CGFloat(self.viewControllers!.count)
        
        selectionIndicatorImageView = UIImageView(frame: CGRectMake(0, 0, itemWidth, backgroundView.frame.size.height))
        selectionIndicatorImageView.image = UIImage(named: "TabBarBGSel")
        
        backgroundView.addSubview(selectionIndicatorImageView)
        
        for var i = 0; i < viewControllers!.count; i++ {
            
            let button = UIButton(frame: CGRectMake(itemWidth * CGFloat(i), 0, itemWidth, backgroundView.frame.size.height))
            
            let image = UIImage(named: "TabBar\(i)")!
            let selImage = UIImage(named: "TabBar\(i)Sel")!
            
            button.setImage(image, forState: UIControlState.Normal)
            button.setImage(selImage, forState: UIControlState.Selected)
            
            button.addTarget(self, action: "onClick:", forControlEvents: UIControlEvents.TouchUpInside)
            
            button.tag = i
            
            // 去掉buttond的高光效果
            button.adjustsImageWhenHighlighted = false
            
            backgroundView.addSubview(button)
        }
        
        
        
    }
    
    func onClick(button: UIButton) {
        // 将上个选中俺就设置为为选中
        self.currentSelectedButton.selected = false
        // 当前按钮设置为选中
        button.selected = true
        
        self.currentSelectedButton = button
        
        let x = CGFloat(button.tag) + 0.5
        
        // 为TabBarItem 添加动画效果
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.selectionIndicatorImageView.center.x = self.itemWidth * x
            
            }, completion: nil)
        
        self.selectedIndex = button.tag
    }

}
