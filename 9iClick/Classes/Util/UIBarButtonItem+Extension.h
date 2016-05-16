//
//  UIBarButtonItem+Extension.h
//  ProjectDemo
//
//  自定义BarButton
//
//  Created by Jerry on 15/3/3.
//  Copyright (c) 2015年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightImage:(NSString *)highlightImage;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

@end
