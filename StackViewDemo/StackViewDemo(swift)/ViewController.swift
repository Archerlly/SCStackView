//
//  ViewController.swift
//  StackViewDemo(swift)
//
//  Created by SnowCheng on 16/5/27.
//  Copyright © 2016年 SnowCheng. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let lab1 = UILabel()
    let lab2 = UILabel()
    let lab3 = UILabel()
    let lab4 = UILabel()
    let lab5 = UILabel()
    let lab6 = UILabel()
    let lab7 = UILabel()

    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lab1.text = "第1个"
        lab2.text = "2"
        lab3.text = "~~第3个~~"
        lab4.text = "第4个"
        lab5.text = "第5个"
        lab6.text = "第6个"
        lab7.text = "第7个"
        
        lab1.layer.borderColor = UIColor.purpleColor().CGColor
        lab2.layer.borderColor = UIColor.purpleColor().CGColor
        lab3.layer.borderColor = UIColor.purpleColor().CGColor
        lab4.layer.borderColor = UIColor.purpleColor().CGColor
        lab5.layer.borderColor = UIColor.purpleColor().CGColor
        lab6.layer.borderColor = UIColor.purpleColor().CGColor
        lab7.layer.borderColor = UIColor.purpleColor().CGColor
        
        lab1.layer.borderWidth = 1
        lab2.layer.borderWidth = 1
        lab3.layer.borderWidth = 1
        lab4.layer.borderWidth = 1
        lab5.layer.borderWidth = 1
        lab6.layer.borderWidth = 1
        lab7.layer.borderWidth = 1
        
        lab1.textAlignment = .Center
        lab2.textAlignment = .Center
        lab3.textAlignment = .Center
        lab4.textAlignment = .Center
        lab5.textAlignment = .Center
        lab6.textAlignment = .Center
        lab7.textAlignment = .Center
        
        let seg = UISegmentedControl.init(items: ["水平等宽","水平等间隔","水平等宽","水平等间隔","组"])
        seg.addTarget(self, action: #selector(segSelectAction(_:)), forControlEvents: .ValueChanged)
        
        view.addSubview(seg)
        view.addSubview(contentView)
        
        seg.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(50)
        }
        
        contentView.snp_makeConstraints { (make) in
            make.top.equalTo(100)
            make.leading.trailing.bottom.equalTo(view)
        }
        
    }


    @objc private func segSelectAction(sender: UISegmentedControl) {
        
        for sub in contentView.subviews {
            sub.removeFromSuperview()
        }
        
        let stackView = SCStackView()
        stackView.contentEdge = (5, 10, 15, 20)
        stackView.layer.borderColor = UIColor.redColor().CGColor
        stackView.layer.borderWidth = 1
        
        switch sender.selectedSegmentIndex {
        case 0:
            stackView.space = 20
            stackView.direction = .Horizontal
            stackView.style = .EqualWidth
            stackView.containViews = [lab1, lab2, lab3, lab4]
            
            lab3.text = "~~第3个~~"
            lab3.numberOfLines = 1
            
            contentView.addSubview(stackView)
            
            stackView.snp_makeConstraints(closure: { (make) in
                make.leading.top.trailing.equalTo(contentView)
            })
        case 1:
            stackView.direction = .Horizontal
            stackView.style = .EqualMargin
            stackView.containViews = [lab1, lab2, lab3, lab4]
            
            lab3.text = "~~第3个~~"
            lab3.numberOfLines = 1
            
            contentView.addSubview(stackView)
            
            stackView.snp_makeConstraints(closure: { (make) in
                make.leading.top.trailing.equalTo(contentView)
            })
        case 2:
            stackView.space = 20
            stackView.direction = .Vertical
            stackView.style = .EqualWidth
            stackView.containViews = [lab1, lab2, lab3, lab4]
            
            lab3.text = "~~第3个~~\n~~第3个~~"
            lab3.numberOfLines = 0
            
            contentView.addSubview(stackView)
            
            stackView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(contentView)
                make.centerX.equalTo(contentView)
                make.height.equalTo(300)
            })
        case 3:
            
            stackView.direction = .Vertical
            stackView.style = .EqualMargin
            stackView.containViews = [lab1, lab2, lab3, lab4]
            
            lab3.text = "~~第3个~~\n~~第3个~~"
            lab3.numberOfLines = 0
            
            contentView.addSubview(stackView)
            
            stackView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(contentView)
                make.centerX.equalTo(contentView)
                make.height.equalTo(300)
            })
        case 4:
            let group = SCGroupStackView()
            
            group.column = 3
            group.space = 20
            group.verticalSpace = 10
            group.contentEdge = (5, 10, 15, 20)
            group.containViews = [lab1, lab2, lab3, lab4, lab5, lab6, lab7]
            group.layer.borderColor = UIColor.redColor().CGColor
            group.layer.borderWidth = 1
            
            lab3.text = "~~第3个~~\n~~第3个~~"
            lab3.numberOfLines = 0
            
            contentView.addSubview(group)
            
            group.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(contentView)
                make.centerX.equalTo(contentView)
            })
        default:
            break
        }
    }
    
}

