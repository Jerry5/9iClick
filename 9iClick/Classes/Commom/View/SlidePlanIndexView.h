//
//  SlidePlanIndexView.h
//  HealthUp
//
//  计划下标滑动视图
//
//  Created by 武志远 on 16/4/12.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlidePlanIndexViewDataSource;
@protocol SlidePlanIndexViewDelegate;

@interface SlidePlanIndexView : UIView
{
    __weak id <SlidePlanIndexViewDataSource> dataSource;
    __weak id <SlidePlanIndexViewDelegate>   delegate;
}

@property (nonatomic, assign) id <SlidePlanIndexViewDataSource> dataSource;

@property (nonatomic, assign) id <SlidePlanIndexViewDelegate> delegate;

@property (nonatomic, assign) NSInteger planIndex;

- (void)createUI;

- (void)reloadData;

@end

@protocol SlidePlanIndexViewDataSource <NSObject>

@required

/*!
 * @method 顶部item个数
 * @abstract
 * @discussion
 * @param 本控件
 * @result item个数
 */
- (NSUInteger)numberOfItem:(SlidePlanIndexView *)view;

/*!
 * @method 每个item所属的viewController
 * @abstract
 * @discussion
 * @param item索引
 * @result viewController
 */
- (UIViewController *)slidePlanIndexView:(SlidePlanIndexView *)view viewOfItemAtIndex:(NSUInteger)index;
@end

@protocol SlidePlanIndexViewDelegate <NSObject>

/*!
 * @method 点击item
 * @abstract
 * @discussion
 * @param item索引
 * @result
 */
- (void)slidePlanIndexView:(SlidePlanIndexView *)view didselectedItemAtIndex:(NSUInteger)index;

- (void)slidePlanIndexView:(SlidePlanIndexView *)view panLeftEdge:(UIPanGestureRecognizer *)panGestureRecognizer;

- (void)slidePlanIndexView:(SlidePlanIndexView *)view panRightEdge:(UIPanGestureRecognizer *)panGestureRecognizer;

@end
