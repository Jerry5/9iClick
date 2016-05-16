//
//  HealthUpAPP.h
//  HealthUp
//
//  Created by Jerry on 16/1/14.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "UIDevice-Extensions.h"
#import "GUIDCreat.h"

@interface HealthUpAPP : NSObject

/**
 *  获取IEMI号
 *
 *  @return IMEI号
 */
+ (NSString *) imei;

/**
 *  设备分辨率
 *
 *  @return 分辨率
 */
+ (NSString *) resolution;

/**
 *  软件版本号
 *
 *  @return 版本号
 */
+ (NSString *) appVersion;

/**
 *  手机型号
 *
 *  @return 手机型号
 */
+ (NSString *) platform;

/**
 *  返回系统名称
 *
 *  @return 系统名称
 */
+ (NSString *) systemName;

/**
 *  iOS系统版本号
 *
 *  @return 系统版本号
 */
+ (NSString *) systemVersion;

/**
 *  系统日期
 *
 *  @return 系统日期
 */
+ (NSString *) systemDate;

/**
 *  运营商
 *
 *  @return 运营商
 */
+ (NSString *) yunyingshang;

/**
 *  获取渠道名
 *
 *  @return 渠道名
 */
+ (NSString *) channel;

/**
 *  生成随机UUID
 *
 *  @return UUID
 */
+ (NSString *) UUID;

@end
