//
//  LocationManager.h
//  Steward
//
//  获取用户地理位置
//
//  Created by Jerry on 15/7/21.
//  Copyright (c) 2015年 ChengpinKuaipai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationManager;

typedef void (^LocationSuccess)(LocationManager *locationManager, CGFloat latitude, CGFloat longitude);
typedef void (^LocationFailure)(LocationManager *locationManager, NSError *error);
@interface LocationManager : NSObject
{
    @private
    NSString                *_address;     // 地址
    NSString                *_city;        // 城市
    
    LocationSuccess         _locationSuccess;
    LocationFailure         _locationFailure;
}

+ (LocationManager *)shared;

- (void)getLocationValueSuccess:(LocationSuccess) success
                        failure:(LocationFailure)failure;


@end
