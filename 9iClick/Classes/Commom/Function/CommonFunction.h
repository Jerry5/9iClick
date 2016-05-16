//
//  CommonFunction.h
//  HealthUp
//
//  Created by 武志远 on 16/2/27.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunction : NSObject

/**
 *  获取内容尺寸
 *
 *  @param content       内容
 *  @param contentWidth  计算高度时，固定宽度
 *  @param contentHeight 计算宽度时，固定高度
 *  @param font          内容字体大小
 *
 *  @return Size
 */
+ (CGSize)getContentSizeWithContent:(NSString *)content contentWidth:(CGFloat)contentWidth contentHeight:(CGFloat)contentHeight contentFont:(NSInteger)font;

/**
 *  Json转字典
 *
 *  @param jsonString Json字符串
 *
 *  @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  Data转字典
 *
 *  @param jsonData Data
 *
 *  @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData;

/**
 *  Json转数组
 *
 *  @param jsonString Json字符串
 *
 *  @return 数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;

/**
 *  字典转Json字符串
 *
 *  @param dic 字典
 *
 *  @return Json字符串
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

/**
 *  根据日期计算年龄
 *
 *  @param birthday
 *
 *  @return 年龄
 */
+ (NSInteger)calculateAgeWithBirthday:(NSDate *)birthday;

/**
 *  根据月日计算星座
 *
 *  @param birthday
 *
 *  @return 星座
 */
+ (NSString *)calculateConstellationWithBirthday:(NSDate *)birthday;

@end
