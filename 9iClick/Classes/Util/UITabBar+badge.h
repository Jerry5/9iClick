//
//  UITabBar+badge.h
//  Steward
//
//  Created by Jerry on 15/11/9.
//  Copyright © 2015年 ChengpinKuaipai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
