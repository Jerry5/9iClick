//
//  HandlerAct.h
//  HealthUp
//
//  Created by Jerry on 16/1/20.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^complete)(id completeResult);

@interface HandlerAct : NSObject
{
    complete _complete;
}

// 动态注册新的Action
+ (void)registerHandlerAction:(HandlerAct *)handlerAction andKey:(NSString *) actKey;

// 获取注册的Action
+ (NSDictionary *)handlerActions;

// 具体的执行方法
- (void)performActionWichController:(UIViewController *)controller complete:(void(^)(id completeResult))complete;

@end
