//
//  HomeViewController.m
//  9iClick
//
//  Created by 武志远 on 16/5/16.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"易转发";
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    titleView.backgroundColor = [UIColor redColor];
    
    self.navigationItem.titleView = titleView;
    
    //提交代码合并测试
    NSLog(@"提交了啊!");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
