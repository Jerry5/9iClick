//
//  SlideSwithView.m
//  HealthUp
//
//  Created by Jerry on 16/1/5.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "SlideSwithView.h"

static const CGFloat kHeightOfTopScrollView = 38.0f;
static const CGFloat kHeightOfSliderView    = 2.0;
static const CGFloat kWidthOfSliderView     = 60.0;

@implementation SlideSwithView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initValues];
        [self createSubviews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initValues];
        [self createSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    for (int index = 0; index < [self.viewControllers count]; index ++)
    {
        UIViewController * viewController = self.viewControllers[index];
        //        CLog(@"XXX width = %f, height = %f",self.width,self.height);
        //        CLog(@"width = %f, height = %f",self.rootScrollView.bounds.size.width,self.rootScrollView.bounds.size.height);
        viewController.view.frame = CGRectMake(self.rootScrollView.bounds.size.width * index, 0, self.rootScrollView.bounds.size.width, self.rootScrollView.size.height);
    }
    self.topItemBackgroundView.frame = CGRectMake(0, 0, self.bounds.size.width / 4 * [self.viewControllers count], kHeightOfTopScrollView);
    self.topItemScrollView.contentSize = CGSizeMake(self.bounds.size.width / 4 * [self.viewControllers count], 0);
    //    [self.topItemScrollView setContentOffset:CGPointMake((self.selectItemID - 100) * self.bounds.size.width/4, 0) animated:YES];
    self.rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [self.viewControllers count], 0);
    [self.rootScrollView setContentOffset:CGPointMake((self.selectItemID - 100) * self.bounds.size.width, 0) animated:YES];
    //调整顶部滚动视图选中按钮位置
    UIButton *button = (UIButton *)[self.topItemScrollView viewWithTag:self.selectItemID];
    [self adjustTopItemScrollViewContentX:button];
    [self selectItem:button];
}

#pragma mark - Private Methods
- (void)initValues
{
    self.viewControllers = [[NSMutableArray alloc] init];
    self.selectItemID = 100;
}

// 创建子视图
- (void)createSubviews
{
    // 创建顶部分类视图
    UIScrollView * topItemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    topItemScrollView.delegate = self;
    topItemScrollView.backgroundColor = [UIColor clearColor];
    topItemScrollView.pagingEnabled = NO;
    topItemScrollView.showsHorizontalScrollIndicator = NO;
    topItemScrollView.showsVerticalScrollIndicator = NO;
    topItemScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    topItemScrollView.scrollEnabled = YES;
    
    self.topItemBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, topItemScrollView.width, kHeightOfTopScrollView)];
    self.topItemBackgroundView.image = [UIImage imageNamed:@"sliderBackground"];
    [topItemScrollView addSubview:self.topItemBackgroundView];
    
    [self addSubview:topItemScrollView];
    
    // 创建滑动View
    UIImageView * sliderView = [[UIImageView alloc] initWithFrame:CGRectMake((topItemScrollView.bounds.size.width/4 - kWidthOfSliderView)/2, kHeightOfTopScrollView - kHeightOfSliderView, kWidthOfSliderView, kHeightOfSliderView)];
    sliderView.backgroundColor = [UIColor clearColor];
    sliderView.image = [UIImage imageNamed:@"sliderBar"];
    [topItemScrollView addSubview:sliderView];
    [topItemScrollView bringSubviewToFront:sliderView];
    self.sliderView = sliderView;
    
    self.topItemScrollView = topItemScrollView;
    
    // 创建主视图
    UIScrollView * rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    rootScrollView.backgroundColor = [UIColor clearColor];
    rootScrollView.delegate = self;
    rootScrollView.pagingEnabled = YES;
    rootScrollView.bounces = NO;
    rootScrollView.showsVerticalScrollIndicator = NO;
    rootScrollView.showsHorizontalScrollIndicator = NO;
    rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:rootScrollView];
    self.rootScrollView = rootScrollView;
}

// 创建顶部分类视图子视图
- (void)createTopItem
{
    NSInteger itemCount = self.viewControllers.count;
    for (int index = 0; index < itemCount; index ++)
    {
        UIViewController * viewController = self.viewControllers[index];
        UIButton * item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(self.bounds.size.width/4 * index, 0, self.topItemScrollView.bounds.size.width/4, kHeightOfTopScrollView);
        item.tag = index + self.selectItemID;
        [item setTitle:viewController.title forState:UIControlStateNormal];
        [item setTitleColor:Color(123, 123, 121) forState:UIControlStateNormal];
        [item setTitleColor:Color(67, 175, 229) forState:UIControlStateSelected];
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.topItemScrollView addSubview:item];
    }
    // 设置顶部分类滚动视图内容的尺寸
    [self.topItemScrollView setContentSize:CGSizeMake(itemCount * self.topItemScrollView.bounds.size.width/4, 0)];
}

//调整顶部滚动视图选中按钮位置
- (void)adjustTopItemScrollViewContentX:(UIButton *)button
{
    CLog(@"adjustTopItemScrollViewContentX");
}

#pragma mark - Public Methods
- (void)createUI
{
    NSInteger itemCount = [self.dataSource numberOfItem:self];
    // 保存子ViewController
    for (int itemIndex = 0; itemIndex < itemCount; itemIndex ++)
    {
        UIViewController * subViewController = [self.dataSource slideSwithView:self viewOfItemAtIndex:itemIndex];
        UIView * subView = subViewController.view;
        subView.frame = self.rootScrollView.bounds;
        [self.viewControllers addObject:subViewController];
        [self.rootScrollView addSubview:subView];
    }
    
    CLog(@"rootScrollView subviews = %@",self.rootScrollView.subviews);
    // 创建TopScroll中的Item
    [self createTopItem];
    
    [self setNeedsLayout];
    
    // 默认选中第一个Item
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideSwithView:didselectedItemAtIndex:)])
    {
        [self.delegate slideSwithView:self didselectedItemAtIndex:0];
    }
}

- (void)reloadData
{
    self.selectItemID = 100;
    
    [self.viewControllers removeAllObjects];
    for (UIView * subView in self.rootScrollView.subviews)
    {
        [subView removeFromSuperview];
    }
    for (UIView * subView in self.topItemScrollView.subviews)
    {
        if (![subView isKindOfClass:[UIImageView class]])
        {
            [subView removeFromSuperview];
        }
    }
    [self createUI];
}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//
//}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    CLog(@"scrollViewDidEndDragging");
//    if (scrollView == self.rootScrollView)
//    {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(slideSwithView:didselectedItemAtIndex:)])
//        {
//            [self.delegate slideSwithView:self didselectedItemAtIndex:(self.selectItemID - 100)];
//        }
//    }
//}

// 当不用手指拨动，而是设置scrollview偏移之后，scrollview完毕时触发
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CLog(@"scrollViewDidEndScrollingAnimation");
    if (scrollView == self.rootScrollView)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slideSwithView:didselectedItemAtIndex:)])
        {
            [self.delegate slideSwithView:self didselectedItemAtIndex:(self.selectItemID - 100)];
        }
    }
}

// 当用手指拨动scrollview后，scrollview滑动完成时触发
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.rootScrollView)
    {
        self.isRootScrolled = YES;
        // 调整顶部滑动条
        NSInteger index = (NSInteger)scrollView.contentOffset.x / self.bounds.size.width;
        UIButton * item = (UIButton *)[self.topItemScrollView viewWithTag:index + 100];
        [self selectItem:item];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(slideSwithView:didselectedItemAtIndex:)])
        {
            [self.delegate slideSwithView:self didselectedItemAtIndex:(self.selectItemID - 100)];
        }
    }
}

#pragma mark - Action
// 可以判断是否滑到了最左/最右
- (void)scrollHandlePan:(UIPanGestureRecognizer *)panGestureRecognizer
{
    //当滑道左边界时，传递滑动事件给代理
    if(_rootScrollView.contentOffset.x <= 0)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slideSwithView:panLeftEdge:)])
        {
            [self.delegate slideSwithView:self panLeftEdge:panGestureRecognizer];
        }
    }
    else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slideSwithView:panRightEdge:)]) {
            [self.delegate slideSwithView:self panRightEdge:panGestureRecognizer];
        }
    }
}

- (void)selectItem:(UIButton *)button
{
    NSInteger index = button.tag;
    
    for (UIView * subview in self.topItemScrollView.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
            UIButton * button = (UIButton *)subview;
            button.selected = NO;
            [button setTitleColor:Color(123, 123, 121) forState:UIControlStateNormal];
        }
    }
    
    [button setTitleColor:Color(67, 175, 229) forState:UIControlStateNormal];
    
    self.selectItemID = index;
    
    // 从左到右 右侧即将展示出来的总宽度
    float topScrollviewRightWillDisplayWidth = (self.selectItemID + 1 - 100) * self.bounds.size.width / 4;
    // 偏移量
    float topOffset_X = self.topItemScrollView.contentOffset.x;
    // 右侧展示出来之后的总宽度 和 现视图露出部分的总宽度
    float overFlowWidth = topScrollviewRightWillDisplayWidth - (topOffset_X + self.topItemScrollView.width);
    // 如果右侧展出出来之后的总宽度大于现视图露出部分的总宽度  说明需要向右偏移  偏移量 == 之前偏移量 + 超出部分
    if (overFlowWidth > 0)
    {
        [self.topItemScrollView setContentOffset:CGPointMake(overFlowWidth + topOffset_X, 0) animated:YES];
    }
    // 如果从右到左的话 先计算左侧展示出来之后视图左侧的宽度
    float topScrollviewleftWillDisplayWidth = (self.selectItemID - 100) * self.topItemScrollView.width / 4.0f;
    // 如果左侧展示出来之后视图左侧的宽度 小于 偏移量  说明需要向左偏移   偏移量 == 左侧展示出来之后视图左侧的宽度
    if (topScrollviewleftWillDisplayWidth < topOffset_X)
    {
        [self.topItemScrollView setContentOffset:CGPointMake(topScrollviewleftWillDisplayWidth, 0) animated:YES];
    }
    
    CGFloat sliderOriginOfX = self.topItemScrollView.bounds.size.width/4 * (self.selectItemID - 100) + (self.topItemScrollView.bounds.size.width/4 - kWidthOfSliderView)/2;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.left = sliderOriginOfX;
        //        if (self.isRootScrolled)
        //        {
        //            [self.topItemScrollView setContentOffset:CGPointMake((self.selectItemID - 100) * self.bounds.size.width/4, 0) animated:YES];
        //        }
    } completion:^(BOOL finished) {
        // 如果不是主视图滑动，而是点击Item
        if (!self.isRootScrolled)
        {
            [self.rootScrollView setContentOffset:CGPointMake(self.bounds.size.width * (self.selectItemID - 100), 0) animated:YES];
        }
        self.isRootScrolled = NO;
        
    }];
}

@end
