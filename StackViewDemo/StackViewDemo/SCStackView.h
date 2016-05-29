//
//  YXStackView.h
//  HaoFenShu
//
//  Created by SnowCheng on 16/5/27.
//  Copyright © 2016年 yunxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "masonry.h"

typedef NS_ENUM(NSInteger, SCStackDirectionStyle) {
    SCStackDirectionStyleHorizontal,
    SCStackDirectionStyleVertical
};

typedef NS_ENUM(NSInteger, SCStackLayoutStyle) {
    SCStackLayoutStyleEqualWidth,
    SCStackLayoutStyleEqualMargin
};

@interface SCStackView : UIView

@property (nonatomic, assign) CGFloat topMargin;
@property (nonatomic, assign) CGFloat bottomMargin;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;
@property (nonatomic, assign) CGFloat space;

@property (nonatomic, assign) SCStackDirectionStyle direction;
@property (nonatomic, assign) SCStackLayoutStyle style;

@property (nonatomic, copy) NSArray *containViews;

- (void)updateLayout;

@end
