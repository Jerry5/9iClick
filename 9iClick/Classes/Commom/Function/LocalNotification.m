//
//  LocalNotification.m
//  HealthUp
//
//  Created by 武志远 on 16/4/20.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "LocalNotification.h"

@implementation LocalNotification

+ (void)createLocalNotification
{
    // 触发时间
    NSDate *currentDate = [NSDate date];
    NSDate *breakfastFireDate = [NSDate dateWithYear:currentDate.year month:currentDate.month day:currentDate.day hour:7 minute:0 second:0];
    NSDate *lunchFireDate = [NSDate dateWithYear:currentDate.year month:currentDate.month day:currentDate.day hour:11 minute:0 second:0];
    NSDate *dinnerFireDate = [NSDate dateWithYear:currentDate.year month:currentDate.month day:currentDate.day hour:18 minute:0 second:0];
    [[self class] createNotificaionWithAlertBody:@"新的一天，该准备您的早餐了!" fireDate:breakfastFireDate];
    [[self class] createNotificaionWithAlertBody:@"肚子咕噜咕噜叫，快去准备午餐吧!" fireDate:lunchFireDate];
    [[self class] createNotificaionWithAlertBody:@"晚饭不可不吃哦，开始准备晚餐吧!" fireDate:dinnerFireDate];
}

+ (void)createNotificaionWithAlertBody:(NSString *)alertBody fireDate:(NSDate *)fireDate
{
    UILocalNotification *myLocalNotification = [[UILocalNotification alloc] init];
    myLocalNotification.alertBody = alertBody;
    myLocalNotification.fireDate = fireDate;
    myLocalNotification.timeZone=[NSTimeZone localTimeZone];
    myLocalNotification.repeatInterval = NSCalendarUnitDay;
    myLocalNotification.soundName =  UILocalNotificationDefaultSoundName;
    //    myLocalNotification.userInfo = @{@"information":[self dictionaryWithModel:aNotificationTaskModel],@"id":key};
    CLog(@"fireDate=%@",myLocalNotification.fireDate);
    [[UIApplication sharedApplication] scheduleLocalNotification:myLocalNotification];
}

@end
