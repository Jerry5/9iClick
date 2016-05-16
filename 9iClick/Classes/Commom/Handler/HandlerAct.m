//
//  HandlerAct.m
//  HealthUp
//
//  Created by Jerry on 16/1/20.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "HandlerAct.h"
#import "Handler.h"

@implementation HandlerAct

static NSMutableDictionary * handlerActs = nil;

+ (void)registerCommonAction
{
    [HandlerSystemPic load];
}

// 动态注册新的Action
+ (void)registerHandlerAction:(HandlerAct *)handlerAction andKey:(NSString *) actKey
{
    @synchronized(self){
        if (!handlerActs)
        {
            handlerActs = [NSMutableDictionary dictionary];
            [HandlerAct registerCommonAction];
        }
        [handlerActs setObject:handlerAction forKey:actKey];
    }
}

// 获取注册的Action
+ (NSDictionary *)handlerActions
{
    NSDictionary * acts = nil;
    @synchronized(self){
        if (!handlerActs)
        {
            handlerActs = [NSMutableDictionary dictionary];
            [HandlerAct registerCommonAction];
        }
        acts = handlerActs;
    }
    
    return acts;
}


@end
