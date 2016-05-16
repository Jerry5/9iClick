//
//  LocationManager.m
//  Steward
//
//  Created by Jerry on 15/7/21.
//  Copyright (c) 2015年 ChengpinKuaipai. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "AFHTTPRequestOperationManager.h"

static LocationManager * locationManager = nil;

@interface LocationManager()<CLLocationManagerDelegate>
{
    BOOL        _isCallback;    // 如果为NO的话可以给经纬度赋值，YES将不赋值，防止重复获取经纬度
}

@property (nonatomic, strong) CLLocationManager * location;

@end

@implementation LocationManager

+ (LocationManager *)shared
{
    @synchronized(locationManager)
    {
        if (!locationManager)
        {
            locationManager = [[LocationManager alloc] init];
        }
        return locationManager;
    }
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initLocation];
    }
    return self;
}

- (void)initLocation
{
    _isCallback = YES;
    
    CLLocationManager * location = [[CLLocationManager alloc] init];
    if (iOS8)
    {
        //如果没有授权则请求用户授权
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
        {
            [location requestWhenInUseAuthorization];
            
            //设置代理
            location.delegate=self;
            //设置定位精度
            location.desiredAccuracy=kCLLocationAccuracyBest;
            //定位频率,每隔多少米定位一次
            CLLocationDistance distance=10.0;
            //十米定位一次
            location.distanceFilter=distance;
            //启动跟踪定位
            [location startUpdatingLocation];
        }
        else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse)
        {
            //设置代理
            location.delegate=self;
            //设置定位精度
            location.desiredAccuracy=kCLLocationAccuracyBest;
            //定位频率,每隔多少米定位一次
            CLLocationDistance distance=10.0;
            //十米定位一次
            location.distanceFilter=distance;
            //启动跟踪定位
            [location startUpdatingLocation];
        }
        else
        {
            location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; //设置精度
            location.distanceFilter = 10.0f;//设置移动10米开始刷新地图
            [location setDelegate:self];
        }
    }
    self.location = location;
}

- (void)getLocationValueSuccess:(LocationSuccess)success failure:(LocationFailure)failure
{
    [self initLocation];
    
    _locationSuccess = success;
    _locationFailure = failure;
    
    _isCallback = NO;
    CLog(@"location = %@",self.location);
    [self.location startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    if (!_isCallback)
    {
        _locationSuccess(self,newLocation.coordinate.latitude,newLocation.coordinate.longitude);
        // 反地理编码
        CLGeocoder * geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
         {
//            CLog(@"error %@ placemarks count %lu",error.localizedDescription,(unsigned long)[placemarks count]);
            for (CLPlacemark * placemark in placemarks) {
//                CLog(@"address dic %@",placemark.addressDictionary);
                
                // 给城市列表传递定位到的城市名称
                if ([placemark.addressDictionary objectForKey:@"State"])
                {
                    CLog(@"placemark.addressDictionary = %@",placemark.addressDictionary);
                    _address = [placemark.addressDictionary objectForKey:@"Name"];
                    _city = [placemark.addressDictionary objectForKey:@"State"];
                }
                
                // 打印地址字典里的内容
                for (NSString * key in [placemark.addressDictionary allKeys])
                {
                    id object = [placemark.addressDictionary objectForKey:key];
//                    CLog(@"###%@=%@",key,object);
                    /**
                     **Name=中国北京市海淀区上地街道
                     **Country=中国
                     **State=北京市
                     **SubLocality=海淀区
                     **CountryCode=CN
                     */
                }
            }
        }];
        _isCallback = YES;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager stopUpdatingLocation];
    CLog(@"获取位置错误 = %@", [error localizedDescription]);
    _locationFailure(self,error);
    if(!_isCallback)
    {
        _isCallback = YES;
    }

}
@end
