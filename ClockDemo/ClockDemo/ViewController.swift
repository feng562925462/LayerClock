//
//  ViewController.swift
//  ClockDemo
//
//  Created by cool on 2018/4/25.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //      注意：这里imageview不能设置等比约束，否则指针显示不准
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var hour: CALayer = {
        let hour = CALayer()
        hour.backgroundColor = UIColor.black.cgColor
        hour.bounds = CGRect(x: 0, y: 0, width: 1, height: imageView.frame.width/4)
        // 设置锚点
        hour.anchorPoint = CGPoint(x: 0.5, y: 1)
        // 锚点的定位
        hour.position = CGPoint(x: imageView.frame.width/2, y: imageView.frame.width/2)
        self.imageView.layer.addSublayer(hour)
        return hour
    }()
    
    lazy var mintue: CALayer = {
        let mintue = CALayer()
        mintue.backgroundColor = UIColor.gray.cgColor
        mintue.bounds = CGRect(x: 0, y: 0, width: 1, height: imageView.frame.width/3)
        // 设置锚点
        mintue.anchorPoint = CGPoint(x: 0.5, y: 1)
        // 锚点的定位
        mintue.position = CGPoint(x: imageView.frame.width/2, y: imageView.frame.width/2)
        self.imageView.layer.addSublayer(mintue)
        return mintue
    }()
    
    lazy var second: CALayer = {
        let second = CALayer()
        second.backgroundColor = UIColor.orange.cgColor
        second.bounds = CGRect(x: 0, y: 0, width: 1, height: imageView.frame.width/2 - 20)
        // 设置锚点
        second.anchorPoint = CGPoint(x: 0.5, y: 1)
        // 锚点的定位
        second.position = CGPoint(x: imageView.frame.width/2, y: imageView.frame.width/2)
        self.imageView.layer.addSublayer(second)
        return second
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
//            return
            let calender = Calendar.current
            let components = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
            
            let comp = calender.dateComponents(components, from: Date())
            
            /// 计算精细的度数 不会让指针走的那么僵硬
            
            /// 1秒 = 6度
            let s = CGFloat(comp.second ?? 0) * 6 / 180 * CGFloat.pi
            
            /// 1分钟 = 6度 ， 1秒 = 0.1度
            let m = (CGFloat(comp.minute ?? 0) * 6 + CGFloat(comp.second ?? 0) * 0.1 ) / 180 * CGFloat.pi
            
            /// 1h = 30度 ，1分钟 = 0.5度，1秒 = 0.5/60度
            let h = (CGFloat(comp.hour ?? 0) * 30 +  CGFloat(comp.minute ?? 0) * 0.5 + CGFloat(comp.second ?? 0) * 0.5 / 60) / 180 * CGFloat.pi
            
            /// 按照z轴旋转一定的角度
            self.second.transform = CATransform3DMakeRotation(s, 0, 0, 1)
            self.mintue.transform = CATransform3DMakeRotation(m, 0, 0, 1)
            self.hour.transform = CATransform3DMakeRotation( h, 0, 0, 1)
        }
    }
}

