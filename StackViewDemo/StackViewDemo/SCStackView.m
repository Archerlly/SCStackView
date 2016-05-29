//
//  YXStackView.m
//  HaoFenShu
//
//  Created by SnowCheng on 16/5/27.
//  Copyright © 2016年 yunxiao. All rights reserved.
//

#import "SCStackView.h"

@interface SCStackView()

@property (nonatomic, strong) NSMutableArray *spaceViews;
@property (nonatomic, strong) NSMutableArray *layoutContentViews;

@end

@implementation SCStackView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.direction = SCStackDirectionStyleHorizontal;
    self.style = SCStackLayoutStyleEqualWidth;
    self.layoutContentViews = [NSMutableArray array];
    self.spaceViews = [NSMutableArray array];
}

- (void)updateLayout {
    switch (self.containViews.count) {
        case 0:
            break;
        case 1: {
            [self addSubview:self.containViews[0]];
            [self.containViews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(self.leftMargin);
                make.right.equalTo(self).offset(self.rightMargin);
                make.top.equalTo(self).offset(self.topMargin);
                make.bottom.equalTo(self).offset(self.bottomMargin);
            }];
            break;
        }
        default: {
            if (self.style == SCStackLayoutStyleEqualMargin) {
                
                [self.layoutContentViews addObject:self.containViews[0]];
                
                for (int i = 1; i< self.containViews.count; i++) {
                    UIView *spaceView = [UIView new];
                    [self.layoutContentViews addObject:spaceView];
                    [self.layoutContentViews addObject:self.containViews[i]];
                    [self.spaceViews addObject:spaceView];
                }
            } else {
                self.layoutContentViews = [NSMutableArray arrayWithArray:self.containViews];
            }
            
            switch (self.direction) {
                case SCStackDirectionStyleHorizontal:
                    [self horzontalLayout];
                    break;
                case SCStackDirectionStyleVertical:
                    [self verticalLayout];
                    break;
            }
            
            break;
        }
    }
}

- (void)horzontalLayout {
    switch (self.style) {
        case SCStackLayoutStyleEqualMargin:
            [self horizontalEqualMarginLayout];
            break;
        case SCStackLayoutStyleEqualWidth:
            [self horizontalEqualWidthLayout];
            break;
    }
}

- (void)verticalLayout {
    switch (self.style) {
        case SCStackLayoutStyleEqualMargin:
            [self verticalEqualMarginLayout];
            break;
        case SCStackLayoutStyleEqualWidth:
            [self verticalEqualWidthLayout];
            break;
    }
}

- (void)horizontalEqualWidthLayout {
    for (int i = 0; i< self.layoutContentViews.count; i++) {
        [self addSubview:(self.layoutContentViews[i])];
        //公有
        [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.topMargin);
            make.bottom.equalTo(self).offset(-self.bottomMargin);
        }];
        //第一个
        if (i == 0) {
            [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self).offset(self.leftMargin);
            }];
            continue;
        }
        //最后一个
        if (i == self.layoutContentViews.count - 1) {
            UIView *lastView = self.layoutContentViews[i-1];
            [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(lastView.mas_trailing).offset(self.space);
                make.trailing.equalTo(self).offset(-self.rightMargin);
                make.width.equalTo(self.layoutContentViews[i-1]);
            }];
            continue;
        }
        UIView *lastView = self.layoutContentViews[i-1];
        [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(lastView.mas_trailing).offset(self.space);
            make.width.equalTo(self.layoutContentViews[i-1]);
        }];
    }
}

- (void)horizontalEqualMarginLayout {
    for (int i = 0; i< self.layoutContentViews.count; i++) {
        [self addSubview:(self.layoutContentViews[i])];
        //公有
        [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.topMargin);
            make.bottom.equalTo(self).offset(-self.bottomMargin);
        }];
        //第一个
        if (i == 0) {
            [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self).offset(self.leftMargin);
            }];
            continue;
        }
        //最后一个
        if (i == self.layoutContentViews.count - 1) {
            UIView *lastView = self.layoutContentViews[i-1];
            [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(lastView.mas_trailing).offset(self.space);
                make.trailing.equalTo(self).offset(-self.rightMargin);
            }];
            continue;
        }
        UIView *lastView = self.layoutContentViews[i-1];
        [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(lastView.mas_trailing).offset(self.space);
        }];
    }
    
    UIView *firstSpaceView = self.spaceViews[0];
    for (int i = 1; i< self.spaceViews.count; i++) {
        UIView *spaceView = self.spaceViews[i];
        [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(firstSpaceView);
        }];
    }
}

- (void)verticalEqualWidthLayout {
    for (int i = 0; i< self.layoutContentViews.count; i++) {
        [self addSubview:(self.layoutContentViews[i])];
        //公有
        [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(self.leftMargin);
            make.right.equalTo(self).offset(-self.rightMargin);
        }];
        //第一个
        if (i == 0) {
            [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(self.topMargin);
            }];
            continue;
        }
        //最后一个
        if (i == self.layoutContentViews.count - 1) {
            UIView *lastView = self.layoutContentViews[i-1];
            [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastView.mas_bottom).offset(self.space);
                make.bottom.equalTo(self).offset(-self.bottomMargin);
                make.height.equalTo(self.layoutContentViews[i-1]);
            }];
            continue;
        }
        UIView *lastView = self.layoutContentViews[i-1];
        [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView.mas_bottom).offset(self.space);
            make.height.equalTo(self.layoutContentViews[i-1]);
        }];
    }
}

- (void)verticalEqualMarginLayout {
    for (int i = 0; i< self.layoutContentViews.count; i++) {
        [self addSubview:(self.layoutContentViews[i])];
        //公有
        [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(self.leftMargin);
            make.right.equalTo(self).offset(-self.rightMargin);
        }];
        //第一个
        if (i == 0) {
            [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(self.topMargin);
            }];
            continue;
        }
        //最后一个
        if (i == self.layoutContentViews.count - 1) {
            UIView *lastView = self.layoutContentViews[i-1];
            [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastView.mas_bottom).offset(self.space);
                make.bottom.equalTo(self).offset(-self.bottomMargin);
            }];
            continue;
        }
        UIView *lastView = self.layoutContentViews[i-1];
        [self.layoutContentViews[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView.mas_bottom).offset(self.space);
        }];
    }
    
    UIView *firstSpaceView = self.spaceViews[0];
    for (int i = 1; i< self.spaceViews.count; i++) {
        UIView *spaceView = self.spaceViews[i];
        [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(firstSpaceView);
        }];
    }
}

- (void)setContainViews:(NSArray *)containViews {
    _containViews = containViews;
    [self updateLayout];
}

@end
