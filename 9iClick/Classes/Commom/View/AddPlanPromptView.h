//
//  AddPlanPromptView.h
//  HealthUp
//
//  Created by Jerry on 16/1/13.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddPlanPromptView;
@protocol AddPlanPromptViewDelegate;

@interface AddPlanPromptView : UIView

@property (nonatomic, assign) id <AddPlanPromptViewDelegate> delegate;

@end

@protocol AddPlanPromptViewDelegate <NSObject>

- (void)addPlan;

@end
