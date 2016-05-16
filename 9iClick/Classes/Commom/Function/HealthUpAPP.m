//
//  HealthUpAPP.m
//  HealthUp
//
//  Created by Jerry on 16/1/14.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "HealthUpAPP.h"

@implementation HealthUpAPP

+ (NSString *) imei
{
    NSString *_guid = [GUIDCreat guid];
    CLog(@"GUID是 = %@", _guid);
    return _guid;
}

+ (NSString *) resolution
{
    CGSize size_screen = [[UIScreen mainScreen] currentMode].size;
    NSString *_resolution = [NSString stringWithFormat:@"%.0fx%.0f",size_screen.width,size_screen.height];
    CLog(@"分辨率 = %@", _resolution);
    return _resolution;
}

+ (NSString *) appVersion
{
    //    return [[NSUserDefaults standardUserDefaults] objectForKey:@"appversion"];
    return @"1.0";
}

+ (NSString *) platform
{
    NSString *_platform = [UIDevice currentDevice].platform;
    
    CLog(@"机型是 = %@", _platform);
    return _platform;
}

+ (NSString *) systemName
{
    NSString *_system = [UIDevice currentDevice].systemName;
    CLog(@"本机系统是 = %@", _system);
    return _system;
}

#pragma mark - 获取系统版本
+ (NSString *) systemVersion
{
    NSString *_systemVersion = [UIDevice currentDevice].systemVersion;
    CLog(@"本机系统版本号是 = %@", _systemVersion);
    
    return _systemVersion;
}

+ (NSString *) systemDate
{
    NSDate *  senddate=[NSDate date];
    
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    NSMutableString * dayStr = [NSMutableString stringWithFormat:@"%ld",(long)day];
    if ([dayStr length] == 1) {
        [dayStr insertString:[NSString stringWithFormat:@"%d",0] atIndex:0];
    }
    NSString * dateString = [NSString  stringWithFormat:@"%4ld-%2ld-%@",(long)year,(long)month,dayStr];
    CLog(@"系统日期是 == %@",dateString);
    return dateString;
}

+ (NSString *) yunyingshang
{
    NSString *opr= @"null";
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    NSString *mobileCountryCode = carrier.mobileCountryCode;
    NSString *mobileNetworkCode = carrier.mobileNetworkCode;
    
    if (!(mobileCountryCode.length==0))
    {
        if ([mobileNetworkCode isEqualToString:@"01"] || [mobileNetworkCode isEqualToString:@"06"]) { //国内
            opr=@"lt";
        }else if ([mobileNetworkCode isEqualToString:@"00"] || [mobileNetworkCode isEqualToString:@"02"] || [mobileNetworkCode isEqualToString:@"07"]){
            opr=@"yd";
        }else{
            opr=@"dx";
        }
    }
    return opr;
}

+ (NSString *)UUID
{
    NSUUID * UUID = [[NSUUID alloc] init];
    return [UUID UUIDString];
}

+ (NSString *) channel
{
    //企业版
    //    NSString *_channel = @"iOS-Firm";
    
    //测试版
    //NSString *_channel = @"iOS-Test";
    
    //AppStore线上版
    NSString *_channel = @"iOS-AppStore";
    
    return _channel;
}


@end
