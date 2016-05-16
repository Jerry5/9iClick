//
//  CheckNull.h
//  Steward
//
//  检查是否是空字符串
//
//  Created by Jerry on 15/7/17.
//  Copyright (c) 2015年 武志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckNull : NSObject

+ (NSString *)checkNullWithObject:(id)object;

+ (BOOL)isBlankWithObject:(id)object;

@end
