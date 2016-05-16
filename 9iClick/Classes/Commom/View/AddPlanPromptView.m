//
//  AddPlanPromptView.m
//  HealthUp
//
//  Created by Jerry on 16/1/13.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "AddPlanPromptView.h"

@interface AddPlanPromptView ()

@property (nonatomic, strong) UILabel *promptLabel;

@property (nonatomic, strong) UIButton *addPlanButton;

@end

@implementation AddPlanPromptView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.promptLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.promptLabel.text = @"您还没有开始减肥计划，添加计划可查看当天食谱。";
    self.promptLabel.textAlignment = NSTextAlignmentCenter;
    self.promptLabel.numberOfLines = 0;
    self.promptLabel.textColor = Color(170, 170, 170);
    self.promptLabel.font = [UIFont systemFontOfSize:14];
    
    self.addPlanButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.addPlanButton.frame = CGRectZero;
    [self.addPlanButton setTitle:@"添加计划" forState:UIControlStateNormal];
    [self.addPlanButton addTarget:self action:@selector(addPlan:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.promptLabel];
    [self addSubview:self.addPlanButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算内容文字高度
    CGFloat contentWidth = self.width-60;
    CGFloat maxHeight = 9999;
    CGSize contentSize;
    if ([NSString instancesRespondToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        contentSize = [self.promptLabel.text boundingRectWithSize:CGSizeMake(contentWidth, maxHeight)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                                          context:nil].size;
    }
    self.promptLabel.frame = CGRectMake(30, (self.height-contentSize.height)/2 - 30, contentWidth, contentSize.height);
    
    self.addPlanButton.frame = CGRectMake(30, self.promptLabel.bottom + 13, self.width - 60, 40);
}

- (void)addPlan:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPlan)])
    {
        [self.delegate addPlan];
    }
}

@end
