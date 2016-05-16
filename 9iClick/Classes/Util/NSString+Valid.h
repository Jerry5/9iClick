//
//  NSString+Valid.h
//  Steward
//
//  Created by 武志远 on 15/3/19.
//  Copyright (c) 2015年 武志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Valid)

- (BOOL)isChinese;
- (NSString *)MD5;
- (BOOL) isUrlValid;
- (BOOL) isEmailValid;
- (BOOL) isDigitalCharacters;
- (NSString*) stripBlankCharacter;
- (BOOL) isEmpty;
- (NSArray*) urlString;
- (int) convertToInt;
- (NSString *) nullString;

//删除字符串中头部出现的str
- (NSString *) stripWithStartString:(NSString*)str;

//删除字符串中尾部出现的str
- (NSString *) stripWithEndString:(NSString*)str;

//删除字符串中头部第一次出现的str
- (NSString *) stripWithFirstString:(NSString*)str;

//删除字符串中尾部最后一次出现的str
- (NSString *) stripWithLastString:(NSString*)str;

//判断字符串中是否包含汉字
- (BOOL)isContainChinese;

// 中间加灰色横线
+ (NSAttributedString *)underlineWithString:(NSString *)string lineColor:(UIColor *)lineColor stringColor:(UIColor *)stringColor;

// 字符串颜色
+ (NSAttributedString *)string:(NSString *)string stringColor:(UIColor *)color;

//判断字符串是够为空
- (BOOL)isBlankString:(NSString *)string;
- (BOOL)isBlankString;

- (NSString*)encodeURLUsingEncoding:(NSStringEncoding)enc;
- (NSString*)decodeURLUsingEncoding:(NSStringEncoding)enc;


@end
