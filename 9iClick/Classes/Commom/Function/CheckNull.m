//
//  CheckNull.m
//  Lover
//
//  Created by Jerry on 15/7/17.
//  Copyright (c) 2015年 武志远. All rights reserved.
//

#import "CheckNull.h"
#import "NSString+Valid.h"

@implementation CheckNull

+ (NSString *)checkNullWithObject:(id)object
{
    NSString * resultStr;
    if ([object isEqual:[NSNull null]])
    {
        resultStr = @"";
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        resultStr = [object nullString];
    }
    else if (object == nil || object == NULL || [object isEqual:(id)[NSNull null]])
    {
        return @"";
    }
    else
    {
        resultStr = [NSString stringWithFormat:@"%@",object];
    }
    return resultStr;
}

+ (BOOL)isBlankWithObject:(id)object
{
    if ([object isEqual:[NSNull null]])
    {
        return YES;
    }
    if (object == nil || object == NULL || [object isEqual:(id)[NSNull null]])
    {
        return YES;
    }
    if ([object isKindOfClass:[NSString class]])
    {
        return [(NSString *)object isBlankString];
    }
    else
    {
        return NO;
    }
}

@end
