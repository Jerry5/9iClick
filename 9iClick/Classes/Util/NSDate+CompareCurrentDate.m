//
//  NSDate+CompareCurrentDate.m
//  WiConnection
//
//  Created by Milan on 14-7-31.
//  Copyright (c) 2014年 A4A. All rights reserved.
//

#import "NSDate+CompareCurrentDate.h"

@implementation NSDate (CompareCurrentDate)

+ (NSString *) compareCurrentTime:(NSDate*) compareDate;

{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else{
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        result = [dateFormatter stringFromDate:compareDate];
    }
    
    return  result;
}

+ (NSString *)transformDateWithoutTime:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *fixString = [dateFormatter stringFromDate:date];
    
    return fixString;
}

@end
