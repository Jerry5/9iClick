//
//  HomeViewController.m
//  9iClick
//
//  Created by 武志远 on 16/5/16.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "HomeViewController.h"
#import "KxMenu.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    titleView.backgroundColor = [UIColor redColor];
//    self.navigationItem.titleView = titleView;
    
    self.title = @"易转发";

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(addExprateDateRemind) image:@"add" highlightImage:@"add_highlight"];

}

- (void)addExprateDateRemind
{
    NSArray *menuItems =
    @[[KxMenuItem menuItem:@"分享"
                     image:nil
                    target:self
                    action:@selector(shareAction)],
      
      [KxMenuItem menuItem:@"检查更新"
                     image:nil
                    target:self
                    action:@selector(checkVersion)],
      ];
    
    KxMenuItem *firstItem = menuItems[0];
    firstItem.foreColor = [UIColor blackColor];
    firstItem.alignment = NSTextAlignmentLeft;
    
    KxMenuItem *secondItem = menuItems[1];
    secondItem.foreColor = [UIColor blackColor];
    secondItem.alignment = NSTextAlignmentLeft;
    
    [KxMenu setTintColor:[UIColor whiteColor]];
    [KxMenu setTitleFont:[UIFont systemFontOfSize:16]];
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(ScreenWidth - 60, -40, 60, 40)
                 menuItems:menuItems];
}

- (void)shareAction
{
    
}

- (void)checkVersion
{
    
}

@end
