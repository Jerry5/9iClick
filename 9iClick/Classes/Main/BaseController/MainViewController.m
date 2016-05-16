//
//  MainViewController.m
//  HealthUp
//
//  Created by Jerry on 15/12/9.
//  Copyright © 2015年 武志远. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ActivityViewController.h"
#import "SessionViewController.h"
#import "ProfileViewController.h"
#import "UITabBar+badge.h"
#import "NavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController

+ (instancetype)sharedMainViewController
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 初始化控制器
    HomeViewController * home = [[HomeViewController alloc] init];
    [self addChildViewController:home title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    
//    SessionViewController * session = [[SessionViewController alloc] init];
//    [self addChildViewController:session title:@"通知" image:@"icon_nav_time_gary" selectImage:@"icon_nav_time"];
    
    ActivityViewController * activity = [[ActivityViewController alloc] init];
    [self addChildViewController:activity title:@"动态" image:@"tabbar_activity" selectImage:@"tabbar_activity_selected"];
    
    ProfileViewController * profile = [[ProfileViewController alloc] init];
    [self addChildViewController:profile title:@"我的" image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = Color(170, 183, 183);
    NSMutableDictionary * selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = Color(67, 175, 229);
    [childController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    NavigationController * nav = [[NavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

@end
