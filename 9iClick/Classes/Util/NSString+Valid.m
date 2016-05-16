//
//  NSString+Valid.m
//  Lover
//
//  Created by 武志远 on 15/3/19.
//  Copyright (c) 2015年 武志远. All rights reserved.
//

#import "NSString+Valid.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Valid)

-(BOOL)isChinese
{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]].lowercaseString;
}

- (BOOL)isContainChinese
{
    int n = [self length];
    for(int i = 0; i < n; i++)
    {
        int a = [self characterAtIndex:i];
        if( (a > 0x4e00) && (a < 0x9fff) )
            return YES;
    }
    return NO;
}
- (BOOL)isUrlValid
{
    NSString * reg_str = @"^[a-zA-z]+://(\\w+(-\\w+)*)(\\.(\\w+(-\\w+)*))+(\\S*)?$";
    return [self isMatchedByRegex:reg_str options:2L inRange:NSMakeRange(0, [self length]) error:nil] && ![self isContainChinese];
}
- (BOOL) isEmailValid
{
    NSString * reg_str = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
    return [self isMatchedByRegex:reg_str options:2L inRange:NSMakeRange(0, [self length]) error:nil] && ![self isContainChinese];
}
- (BOOL) isDigitalCharacters
{
    NSString * reg_str = @"^\\d[0-9]+\\d$";
    BOOL flag = [self isMatchedByRegex:reg_str options:2L inRange:NSMakeRange(0, [self length]) error:nil];
    return flag;
}
- (BOOL) isEmpty
{
    NSString *origianlString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([origianlString length] == 0)
    {
        return YES;
    }
    else
        return NO;
}
- (NSString*) stripBlankCharacter
{
    NSString *blank = @" ";
    self = [[[self stripWithStartString:blank] stripWithEndString:blank] retain];
    return self;
}
- (NSArray*) urlString
{
    return [self componentsMatchedByRegex:@"([a-zA-z]+://)?(\\w+(-\\w+)*)(\\.(\\w+(-\\w+)*))*(\\?\\S*)?" options:2L range:NSMakeRange(0, [self length]) capture:0 error:nil];
}

//add by guowenjuan
- (int)convertToInt
{
    
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength;
}

- (NSString *) nullString
{
    if([self isEqualToString:@"(null)"] || [self isEqual:(id)[NSNull null]] || [self isEqualToString:@"null"])
    {
        return @"";
    }
    if (self == nil || self == NULL)
    {
        return @"";
    }
    if ([self isKindOfClass:[NSNull class]] || [self length] == 0)
    {
        return @"";
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return @"";
    }
    return self;
}

- (NSString *) stripWithStartString:(NSString*)str
{
    while([self hasPrefix:str])
    {
        self = [self substringWithRange:NSMakeRange(str.length, self.length - str.length)];
    }
    return self;
}

- (NSString *) stripWithEndString:(NSString*)str
{
    while([self hasSuffix:str])
    {
        self = [self substringWithRange:NSMakeRange(0, self.length - str.length)];
    }
    return self;
}

- (NSString *) stripWithFirstString:(NSString*)str
{
    if ([self hasPrefix:str])
    {
        self = [self substringWithRange:NSMakeRange(str.length, self.length - str.length)];
    }
    return self;
}

- (NSString *) stripWithLastString:(NSString*)str
{
    if([self hasSuffix:str])
    {
        self = [self substringWithRange:NSMakeRange(0, self.length - str.length)];
    }
    return self;
}

- (NSString*)encodeURLUsingEncoding:(NSStringEncoding)enc
{
    NSString *newString = [NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(enc))) autorelease];
    if (newString) {
        return newString;
    }
    return @"";
}

- (NSString*)decodeURLUsingEncoding:(NSStringEncoding)enc
{
    NSString *result = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                                           kCFAllocatorDefault,
                                                                                           (CFStringRef)self,
                                                                                           CFSTR(":/"),
                                                                                           CFStringConvertNSStringEncodingToEncoding(enc));
    [result autorelease];
    return result; 
}

// 中间加灰色横线
+ (NSAttributedString *)underlineWithString:(NSString *)string lineColor:(UIColor *)lineColor stringColor:(UIColor *)stringColor
{
    NSDictionary * attributes =  @{NSForegroundColorAttributeName:stringColor,
                                   NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                   NSStrikethroughColorAttributeName:lineColor};
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    return attrStr;
}

// 字符串颜色
+ (NSAttributedString *)string:(NSString *)string stringColor:(UIColor *)color
{
    NSDictionary * attributes =  @{NSForegroundColorAttributeName:color};
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    return attrStr;
}

//判断字符串是够为空
- (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL || [string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]] || [string length] == 0) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (BOOL)isBlankString
{
    if (self == nil || self == NULL || [self isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]] || [self length] == 0) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
