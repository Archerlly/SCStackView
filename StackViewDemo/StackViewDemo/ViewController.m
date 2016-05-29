//
//  ViewController.m
//  StackViewDemo
//
//  Created by SnowCheng on 16/5/27.
//  Copyright © 2016年 SnowCheng. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "SCGroupStackView.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UILabel *lab5;
@property (nonatomic, strong) UILabel *lab6;
@property (nonatomic, strong) UILabel *lab7;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.contentView = [UIView new];
    self.lab1 = [self setupLabelWithString:@"第1个"];
    self.lab2 = [self setupLabelWithString:@"2"];
    self.lab3 = [self setupLabelWithString:@"~~第3个~~"];
    self.lab4 = [self setupLabelWithString:@"第4个"];
    self.lab5 = [self setupLabelWithString:@"第5个"];
    self.lab6 = [self setupLabelWithString:@"第6个"];
    self.lab7 = [self setupLabelWithString:@"第7个"];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"水平等宽",@"水平等间隔",@"水平等宽",@"水平等间隔",@"组"]];
    [seg addTarget:self action:@selector(segSelectAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:seg];
    [self.view addSubview:self.contentView];
    
    [seg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(50));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(100));
        make.leading.trailing.equalTo(self.view);
    }];
}

- (void)segSelectAction:(UISegmentedControl *)sender {
    
    for (UIView *sub in self.contentView.subviews) {
        [sub removeFromSuperview];
    }
    
    SCStackView *stackView = [SCStackView new];
    stackView.topMargin = 5;
    stackView.leftMargin = 10;
    stackView.bottomMargin = 15;
    stackView.rightMargin = 20;
    stackView.layer.borderColor = [UIColor redColor].CGColor;
    stackView.layer.borderWidth = 1;
    
    switch (sender.selectedSegmentIndex) {
        case 0:{
            
            self.lab3.text = @"~~第3个~~";
            self.lab3.numberOfLines = 1;
            
            stackView.space = 20;
            stackView.direction = SCStackDirectionStyleHorizontal;
            stackView.style = SCStackLayoutStyleEqualWidth;
            stackView.containViews = @[self.lab1, self.lab2, self.lab3, self.lab4];
            [self.contentView addSubview:stackView];
            
            [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.top.trailing.equalTo(self.contentView);
            }];

            break;
        }
        case 1:{
            
            self.lab3.text = @"~~第3个~~";
            self.lab3.numberOfLines = 1;
            
            stackView.direction = SCStackDirectionStyleHorizontal;
            stackView.style = SCStackLayoutStyleEqualMargin;
            stackView.containViews = @[self.lab1, self.lab2, self.lab3, self.lab4];
            [self.contentView addSubview:stackView];
            
            [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.top.trailing.equalTo(self.contentView);
            }];
            
            break;
        }
        case 2:{
            
            self.lab3.text = @"~~第3个~~\n~~第3个~~";
            self.lab3.numberOfLines = 0;

            stackView.space = 20;
            stackView.direction = SCStackDirectionStyleVertical;
            stackView.style = SCStackLayoutStyleEqualWidth;
            stackView.containViews = @[self.lab1, self.lab2, self.lab3, self.lab4];
            
            [self.contentView addSubview:stackView];
            
            [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.centerX.equalTo(self.contentView);
                make.height.equalTo(@(300));
            }];
            
            break;
        }
        case 3:{
            
            self.lab3.text = @"~~第3个~~\n~~第3个~~";
            self.lab3.numberOfLines = 0;

            stackView.direction = SCStackDirectionStyleVertical;
            stackView.style = SCStackLayoutStyleEqualMargin;
            stackView.containViews = @[self.lab1, self.lab2, self.lab3, self.lab4];
            
            [self.contentView addSubview:stackView];
            
            [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.centerX.equalTo(self.contentView);
                make.height.equalTo(@(300));
            }];
            
            break;
        }
        case 4:{
            
            self.lab3.text = @"~~第3个~~\n~~第3个~~";
            self.lab3.numberOfLines = 0;
            
            SCGroupStackView *group = [SCGroupStackView new];
            group.column = 3;
            group.space = 20;
            group.verticalSpace = 10;
            group.topMargin = 5;
            group.leftMargin = 10;
            group.bottomMargin = 15;
            group.rightMargin = 20;
            group.containViews = @[self.lab1, self.lab2, self.lab3, self.lab4, self.lab5, self.lab6, self.lab7];
            group.layer.borderColor = [UIColor redColor].CGColor;
            group.layer.borderWidth = 1;
            
            [self.contentView addSubview:group];
            
            [group mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.centerX.equalTo(self.contentView);
            }];
            
            break;
        }
        default:
            break;
    }
}


- (UILabel *)setupLabelWithString:(NSString *)string {
    
    UILabel *lab = [UILabel new];
    
    lab.layer.borderColor = [UIColor purpleColor].CGColor;
    lab.layer.borderWidth = 1;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = string;
    
    return lab;
}

@end
