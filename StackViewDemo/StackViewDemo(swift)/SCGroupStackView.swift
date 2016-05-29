//
//  YXGroupStackView.swift
//  YueJuan
//
//  Created by SnowCheng on 16/3/3.
//  Copyright © 2016年 yunxiao. All rights reserved.
//

import UIKit

class SCGroupStackView: SCStackView {
    
// MARK: - Private property

// MARK: - Public  property
    var column: Int = 0
    var verticalSpace: CGFloat = 0
    
// MARK: - override method (Init)

// MARK: - Public method
    override func updateLayout(){
    
        var stackList = [SCStackView]()
        for row in 0...(containViews.count - 1)/column{
            
            var group = [UIView]()
            for col in 0..<column {
                let idx = row * column + col
                if idx < containViews.count{
                    group.append(containViews[idx])
                } else {
                    group.append(UIView())
                }
            }
            let stack = SCStackView()
            stack.space = space
            stack.containViews = group
            stackList.append(stack)

        }
        let totalStack = SCStackView()
        totalStack.contentEdge = (topMargin,leftMargin,bottomMargin,rightMargin)
        totalStack.space = verticalSpace == 0 ? space : verticalSpace
        totalStack.direction = .Vertical
        totalStack.containViews = stackList
        addSubview(totalStack)
        totalStack.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsZero)
        }
    }

// MARK: - Private method

// MARK: - @objc Action

// MARK: - lazy Loading
    

}
