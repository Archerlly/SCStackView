//
//  YXStackGroupView.m
//  HaoFenShu
//
//  Created by SnowCheng on 16/5/27.
//  Copyright © 2016年 yunxiao. All rights reserved.
//

#import "SCGroupStackView.h"

@implementation SCGroupStackView

- (void)updateLayout {
    NSMutableArray *stackList = [NSMutableArray array];
    for (int row = 0; row <= (self.containViews.count - 1) / self.column; row++) {

        NSMutableArray *group = [NSMutableArray array];
        
        for (int col = 0; col < self.column; col++) {
            int idx = row * self.column + col;
            if (idx < self.containViews.count) {
                [group addObject:self.containViews[idx]];
            } else {
                [group addObject: [UIView new]];
            }
        }
        SCStackView *stack = [SCStackView new];
        stack.space = self.space;
        stack.containViews = group;
        [stackList addObject:stack];
        
    }
    SCStackView *totalStack = [SCStackView new];
    totalStack.topMargin = self.topMargin;
    totalStack.leftMargin = self.leftMargin;
    totalStack.rightMargin = self.rightMargin;
    totalStack.bottomMargin = self.bottomMargin;

    totalStack.space = self.verticalSpace == 0 ? self.space : self.verticalSpace;
    totalStack.direction = SCStackDirectionStyleVertical;
    totalStack.containViews = stackList;
    [self addSubview:totalStack];
    [totalStack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
