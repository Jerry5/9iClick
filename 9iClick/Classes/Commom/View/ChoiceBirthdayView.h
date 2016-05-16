//
//  ChoiceBirthdayView.h
//  HealthUp
//
//  Created by 武志远 on 16/5/10.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoiceBirthdayViewDelegate;

@interface ChoiceBirthdayView : UIView

@property (nonatomic, assign) id <ChoiceBirthdayViewDelegate> delegate;

@property (nonatomic, strong) NSDate *birthday;

@end

@protocol ChoiceBirthdayViewDelegate <NSObject>

- (void)choiceBirthdayView:(ChoiceBirthdayView *)choiceBirthdayView selectedBirthday:(NSDate *)birthday age:(NSInteger)age constellation:(NSString *)constellation;

@end