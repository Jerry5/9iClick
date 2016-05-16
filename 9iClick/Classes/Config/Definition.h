//
//  Definition.h
//  Steward
//
//  Created by Jerry on 15/6/30.
//  Copyright (c) 2015年 ChengpinKuaipai. All rights reserved.
//

#define DOCUMENTPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]//文档路径

#define CachesSavePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"mediaDataSource"]

#define iOS8    [[[UIDevice currentDevice] systemVersion] intValue] >= 8

#define IPHONE_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iOS7  ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

// 判断日期是否过期
#define isOverdue(day) ((day) > 0) ? YES : NO

// 设置颜色
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define Color_alpha(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ActivityColors @[Color(188, 171, 169),Color(145, 178, 190),Color(218, 191, 179),Color(178, 196, 164),Color(144, 163, 166),Color(182, 173, 173),Color(194, 177, 158)]
#define RandomActivityColor ActivityColors[arc4random_uniform(ActivityColors.count)]

// 获取随机颜色
#define RandomColor Color(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

// 提醒框
#define Alert(TITLE,MSG,CANCEL) [[[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:nil \
cancelButtonTitle:(CANCEL) \
otherButtonTitles:nil] show]

// 获取设备物理高度
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
// 获取设备物理宽度
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width

