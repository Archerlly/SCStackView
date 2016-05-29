//
//  YXStackGroupView.h
//  HaoFenShu
//
//  Created by SnowCheng on 16/5/27.
//  Copyright © 2016年 yunxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCStackView.h"

@interface SCGroupStackView : SCStackView

@property (nonatomic, assign) int column;
@property (nonatomic, assign) CGFloat verticalSpace;

@end
