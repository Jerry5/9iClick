//
//  SlideSwithView.h
//  HealthUp
//
//  Created by Jerry on 16/1/5.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideSwithViewDataSource;
@protocol SlideSwithViewDelegate;

@interface SlideSwithView : UIView<UIScrollViewDelegate>
{
    __weak id <SlideSwithViewDataSource> dataSource;
    __weak id <SlideSwithViewDelegate>   delegate;
}

@property (nonatomic, assign) id <SlideSwithViewDataSource> dataSource;
@property (nonatomic, assign) id <SlideSwithViewDelegate>   delegate;

@property (nonatomic, assign) CGFloat startDecelerateX;

@property (nonatomic, strong) NSMutableArray * viewControllers; // 保存所有的子ViewController
@property (nonatomic, strong) UIScrollView * rootScrollView; // 主视图
@property (nonatomic, strong) UIScrollView * topItemScrollView; // 顶部分类视图
@property (nonatomic, strong) UIImageView * topItemBackgroundView;  // 顶部分类视图背景图
@property (nonatomic, strong) UIImageView * sliderView; // 顶部分类视图滑动图片
@property (nonatomic, assign) NSInteger selectItemID; // scrollview 中 tag == 0 默认是ImageView 需设置一个其他起始ID给Button
@property (nonatomic, assign) BOOL isRootScrolled; // 是否是主视图滑动

- (void)createUI;

- (void)reloadData;

@end

@protocol SlideSwithViewDataSource <NSObject>

@required

/*!
 * @method 顶部item个数
 * @abstract
 * @discussion
 * @param 本控件
 * @result item个数
 */
- (NSUInteger)numberOfItem:(SlideSwithView *)view;

/*!
 * @method 每个item所属的viewController
 * @abstract
 * @discussion
 * @param item索引
 * @result viewController
 */
- (UIViewController *)slideSwithView:(SlideSwithView *)view viewOfItemAtIndex:(NSUInteger)index;
@end


@protocol SlideSwithViewDelegate <NSObject>

/*!
 * @method 点击item
 * @abstract
 * @discussion
 * @param item索引
 * @result
 */
- (void)slideSwithView:(SlideSwithView *)view didselectedItemAtIndex:(NSUInteger)index;

- (void)slideSwithView:(SlideSwithView *)view panLeftEdge:(UIPanGestureRecognizer *)panGestureRecognizer;

- (void)slideSwithView:(SlideSwithView *)view panRightEdge:(UIPanGestureRecognizer *)panGestureRecognizer;

@end
