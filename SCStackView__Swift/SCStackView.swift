//
//  YXStackView.swift
//  PitureTextAttachment
//
//  Created by SnowCheng on 16/2/26.
//  Copyright © 2016年 SnowCheng. All rights reserved.
//

import UIKit

class SCStackView: UIView {

    enum DirectionStyle {
        case Horizontal
        case Vertical
    }
    
    enum LayoutStyle {
        case EqualWidth
        case EqualMargin
    }
    
// MARK: - Private property
    private var spaceViews = [UIView]()
    private var layoutContentViews = [UIView]()

// MARK: - Public  property
    var topMargin: CGFloat = 0
    var bottomMargin: CGFloat = 0
    var rightMargin: CGFloat = 0
    var leftMargin: CGFloat = 0
    var space: CGFloat = 0
    var direction: DirectionStyle = .Horizontal
    var style: LayoutStyle = .EqualWidth
    var containViews: [UIView] = [UIView](){
        didSet{
            for subview in subviews{
                subview.removeFromSuperview()
            }
            updateLayout()
        }
    }
    /// 边距 上 左 下 右
    var contentEdge: (top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) = (0,0,0,0){
        didSet{
            topMargin = contentEdge.top
            leftMargin = contentEdge.left
            bottomMargin = contentEdge.bottom
            rightMargin = contentEdge.right
        }
    }

// MARK: - override method (Init)

// MARK: - Public method
    func updateLayout(){
        switch containViews.count {
        case 0:
            break
        case 1:
            addSubview(containViews[0])
            containViews[0].snp_makeConstraints(closure: { (make) in
                make.leading.equalTo(leftMargin)
                make.trailing.equalTo(-rightMargin)
                make.top.equalTo(topMargin)
                make.bottom.equalTo(-bottomMargin)
            })
        default:
            if style == .EqualMargin {
                layoutContentViews.append(containViews.first!)
                for i in 1..<containViews.count {
                    let spaceView = UIView()
                    layoutContentViews.append(spaceView)
                    layoutContentViews.append(containViews[i])
                    spaceViews.append(spaceView)
                }
            } else {
                layoutContentViews = containViews
            }
            
            switch direction {
            case .Horizontal:
                horizontalLayout()
            case .Vertical:
                verticalLayout()
            }
        }
       
    }

// MARK: - Private method
    private func horizontalLayout(){
        switch style {
        case .EqualMargin:
            horizontalEqualMarginLayout()
        case .EqualWidth:
            horizontalEqualWidthLayout()
        }
    }
    
    private func verticalLayout(){
        switch style {
        case .EqualMargin:
            verticalEqualMarginLayout()
        case .EqualWidth:
            verticalEqualWidthLayout()
        }
    }
    
    private func horizontalEqualWidthLayout(){
        for i in 0 ..< layoutContentViews.count{
            addSubview(layoutContentViews[i])
            //公有
            layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                make.top.equalTo(self).offset(topMargin)
                make.bottom.equalTo(self).offset(-bottomMargin)
            }
            //第一个
            if i == 0{
                layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                    make.leading.equalTo(self).offset(leftMargin)
                }
                continue
            }
            //最后一个
            if i == layoutContentViews.count - 1{
                layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                    make.leading.equalTo(layoutContentViews[i-1].snp_trailing).offset(space)
                    make.trailing.equalTo(self).offset(-rightMargin)
                    make.width.equalTo(layoutContentViews[i-1])
                }
                continue
            }
            layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                make.leading.equalTo(layoutContentViews[i-1].snp_trailing).offset(space)
                make.width.equalTo(layoutContentViews[i-1])
            }
        }
    }
    
    private func horizontalEqualMarginLayout(){
        for i in 0 ..< layoutContentViews.count{
            addSubview(layoutContentViews[i])
            //公有
            layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                make.top.equalTo(self).offset(topMargin)
                make.bottom.equalTo(self).offset(-bottomMargin)
            }
            //第一个
            if i == 0{
                layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                    make.leading.equalTo(self).offset(leftMargin)
                }
                continue
            }
            //最后一个
            if i == layoutContentViews.count - 1{
                layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                    make.leading.equalTo(layoutContentViews[i-1].snp_trailing)
                    make.trailing.equalTo(self).offset(-rightMargin)
                }
                continue
            }
            layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                make.leading.equalTo(layoutContentViews[i-1].snp_trailing)
            }
        }
        for view in spaceViews.dropFirst() {
            view.snp_makeConstraints(closure: { (make) in
                make.width.equalTo(spaceViews.first!)
            })
        }
    }
    
    private func verticalEqualWidthLayout(){
        for i in 0 ..< layoutContentViews.count{
            addSubview(layoutContentViews[i])
            //公有
            layoutContentViews[i].snp_makeConstraints(closure: { (make) in
                make.leading.equalTo(self).offset(leftMargin)
                make.trailing.equalTo(self).offset(-rightMargin)
            })
            //第一个
            if i == 0{
                layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                    make.top.equalTo(self).offset(topMargin)
                }
                continue
            }
            //最后一个
            if i == layoutContentViews.count - 1{
                layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                    make.top.equalTo(layoutContentViews[i-1].snp_bottom).offset(space)
                    make.bottom.equalTo(self).offset(-bottomMargin)
                    make.height.equalTo(layoutContentViews[i-1])
                }
                continue
            }
            layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                make.top.equalTo(layoutContentViews[i-1].snp_bottom).offset(space)
                make.height.equalTo(layoutContentViews[i-1])
            }
        }
    }
    
    private func verticalEqualMarginLayout(){
        for i in 0 ..< layoutContentViews.count{
            addSubview(layoutContentViews[i])
            //公有
            layoutContentViews[i].snp_makeConstraints(closure: { (make) in
                make.leading.equalTo(self).offset(leftMargin)
                make.trailing.equalTo(self).offset(-rightMargin)
            })
            //第一个
            if i == 0{
                layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                    make.top.equalTo(self).offset(topMargin)
                }
                continue
            }
            //最后一个
            if i == layoutContentViews.count - 1{
                layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                    make.top.equalTo(layoutContentViews[i-1].snp_bottom).offset(space)
                    make.bottom.equalTo(self).offset(-bottomMargin)
                }
                continue
            }
            layoutContentViews[i].snp_makeConstraints { (make) -> Void in
                make.top.equalTo(layoutContentViews[i-1].snp_bottom).offset(space)
            }
        }
        
        for view in spaceViews.dropFirst() {
            view.snp_makeConstraints(closure: { (make) in
                make.height.equalTo(spaceViews.first!)
            })
        }
    }
    
    

// MARK: - @objc Action

// MARK: - lazy Loading
    

}
