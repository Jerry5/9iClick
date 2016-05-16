//
//  NSDate+CompareCurrentDate.h
//  WiConnection
//
//  Created by Milan on 14-7-31.
//  Copyright (c) 2014年 A4A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CompareCurrentDate)

+ (NSString *)compareCurrentTime:(NSDate*) compareDate;

+ (NSString *)transformDateWithoutTime:(NSDate *)date;

@end
