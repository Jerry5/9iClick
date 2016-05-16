//
//  GUIDCreat.h
//  KuaiPaiQR
//
//  Created by 亓 鑫 on 11-12-13.
//  Copyright (c) 2011年 灵动快拍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GUIDCreat : NSObject
+ (NSString *) stringWithUUID;
+ (NSString *) guid;
+ (NSString *) getMacAddress;
+ (NSString *) getIdfa;
@end
