//
//  ChoiceBirthdayView.m
//  HealthUp
//
//  Created by 武志远 on 16/5/10.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "ChoiceBirthdayView.h"

@interface ChoiceBirthdayView ()

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation ChoiceBirthdayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sutupSubviews];
//        self.backgroundColor = RandomColor;
        self.layer.borderColor = Color(200, 200, 200).CGColor;
        self.layer.borderWidth = 0.5;
    }
    return self;
}

- (void)sutupSubviews
{
    UIView *customBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    customBackgroundView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
    [self addSubview:customBackgroundView];
    
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -40, self.width, 40)];
    promptLabel.text = @"选择出生日期，系统将会自动转换为年龄及星座。";
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.font = [UIFont systemFontOfSize:13];
    promptLabel.textColor = [UIColor grayColor];
    [self addSubview:promptLabel];
    
    NSDate *maximumDate = [NSDate date];
    NSDate *minimumDate = [NSDate dateWithYear:1900 month:1 day:1];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.width, 216)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.maximumDate = maximumDate;
    self.datePicker.minimumDate = minimumDate;
    self.datePicker.date = [NSDate dateWithYear:1990 month:1 day:1];
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    [self addSubview:self.datePicker];
}

- (void)setBirthday:(NSDate *)birthday
{
    if (_birthday != birthday) {
        _birthday = birthday;
        self.datePicker.date = _birthday;
    }
}

- (void)dateChanged:(UIDatePicker *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(choiceBirthdayView:selectedBirthday:age:constellation:)])
    {
        NSInteger age = [CommonFunction calculateAgeWithBirthday:sender.date];
        NSString *constellation = [CommonFunction calculateConstellationWithBirthday:sender.date];
        [self.delegate choiceBirthdayView:self selectedBirthday:sender.date age:age constellation:constellation];
    }
}

@end
