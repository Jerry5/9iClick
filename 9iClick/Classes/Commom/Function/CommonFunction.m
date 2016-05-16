//
//  CommonFunction.m
//  HealthUp
//
//  Created by 武志远 on 16/2/27.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "CommonFunction.h"

@implementation CommonFunction

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
+ (CGSize)getContentSizeWithContent:(NSString *)content contentWidth:(CGFloat)contentWidth contentHeight:(CGFloat)contentHeight contentFont:(NSInteger)font
{
    CGSize contentSize;
    if ([NSString instancesRespondToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        contentSize = [content boundingRectWithSize:CGSizeMake(contentWidth, contentHeight)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                            context:nil].size;
    }
    
    return contentSize;
}

/**
 *  Json转字典
 *
 *  @param jsonString Json字符串
 *
 *  @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil)
    {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        CLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

/**
 *  Data转字典
 *
 *  @param jsonData Data
 *
 *  @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData
{
    if (jsonData == nil)
    {
        return nil;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];

    return dic;
}

/**
 *  Json转数组
 *
 *  @param jsonString Json字符串
 *
 *  @return 数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil)
    {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        CLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return array;
}

/**
 *  字典转Json字符串
 *
 *  @param dic 字典
 *
 *  @return Json字符串
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 * 根据日期计算年龄
 * @param birthday
 * @return
 */
+ (NSInteger)calculateAgeWithBirthday:(NSDate *)birthday
{
    NSDate *currentDate = [NSDate date];
    NSInteger currentDateYear = currentDate.year;
    NSInteger currentDateMonth = currentDate.month;
    NSInteger currentDateDay = currentDate.day;
    
    NSInteger birthdayYear = birthday.year;
    NSInteger birthdayMonth = birthday.month;
    NSInteger birthdayDay = birthday.day;
    
    // 计算年龄
    NSInteger age = currentDateYear - birthdayYear - 1;
    if ((currentDateMonth > birthdayMonth) || (currentDateMonth == birthdayMonth && currentDateDay >= birthdayDay)) {
        age++;
    }
    
    return age;
}

/**
 * 根据月日计算星座
 * @param month
 * @param day
 * @return
 */
+ (NSString *)calculateConstellationWithBirthday:(NSDate *)birthday
{
    NSArray *astro = @[@"摩羯座", @"水瓶座", @"双鱼座", @"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座", @"天蝎座", @"射手座", @"摩羯座"];
    NSArray *intervalDays = @[@20, @19, @21, @21, @21, @22, @23, @23, @23, @23, @22, @22];
    
    NSInteger month = birthday.month;
    NSInteger day = birthday.day;
    NSInteger intervalDay = [intervalDays[month - 1] integerValue];
    if (day < intervalDay) {
        month = month - 1;
    }
    
    return astro[month];
}

@end
