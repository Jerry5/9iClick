//
//  SlidePlanIndexView.m
//  HealthUp
//
//  Created by 武志远 on 16/4/12.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "SlidePlanIndexView.h"

#define kSlideIndexViewWidth (ScreenWidth/6.0)
#define kSlideIndexViewHeight 2.0f

@interface SlidePlanIndexView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *slideView;

@property (nonatomic, strong) UIImageView *slideBackgroundView;

@property (nonatomic, strong) UIImageView *slideIndexView;

@property (nonatomic, assign) NSInteger selectItemID;

@end

@implementation SlidePlanIndexView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
        [self setupSubviews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
        [self setupSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    
}

#pragma mark - Private Methods
// 初始化对象
- (void)initValues
{
    self.selectItemID = 100;
}
// 创建视图
- (void)setupSubviews
{
    UIScrollView *slideView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    slideView.delegate = self;
    slideView.backgroundColor = [UIColor clearColor];
    slideView.pagingEnabled = NO;
    slideView.showsVerticalScrollIndicator = NO;
    slideView.showsHorizontalScrollIndicator = NO;
    slideView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    slideView.scrollEnabled = YES;
    
    self.slideBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideView.width, slideView.height)];
    self.slideBackgroundView.image = [UIImage imageNamed:@"sliderBackground"];
    [slideView addSubview:self.slideBackgroundView];
    
    self.slideIndexView = [[UIImageView alloc] initWithFrame:CGRectMake(0, slideView.height-kSlideIndexViewHeight, kSlideIndexViewWidth, kSlideIndexViewHeight)];
    self.slideIndexView.backgroundColor = [UIColor clearColor];
    self.slideIndexView.image = [UIImage imageNamed:@"sliderBar"];
    [slideView addSubview:self.slideIndexView];
    [slideView bringSubviewToFront:self.slideIndexView];
    
    self.slideView = slideView;
    [self addSubview:self.slideView];
}

#pragma mark - Public Methods
// 填充视图
-(void)createUI
{
    NSInteger itemCount = [self.dataSource numberOfItem:self];
    for (int itemIndex = 0; itemIndex < itemCount; itemIndex ++) {
        UILabel *item = [[UILabel alloc] initWithFrame:CGRectMake(kSlideIndexViewWidth * itemIndex, 0, kSlideIndexViewWidth, self.height)];
        item.layer.borderColor = Color(230, 230, 230).CGColor;
        item.layer.borderWidth = 0.5;
        item.font = [UIFont systemFontOfSize:11];
        item.textAlignment = NSTextAlignmentCenter;
        item.tag = itemIndex + self.selectItemID;
        // 小于当前日期 白字 灰底
        if (self.planIndex-1 > itemIndex) {
            item.textColor = [UIColor whiteColor];
            [item setBackgroundColor:Color(200, 200, 200)];
        } else if (self.planIndex-1 == itemIndex) {
            // 等于当前日期  白字 蓝底
            item.textColor = [UIColor whiteColor];
            [item setBackgroundColor:Color(69, 175, 227)];
        } else {
            // 大于当前日期 黑字 白底
            item.textColor = [UIColor darkGrayColor];
            [item setBackgroundColor:[UIColor whiteColor]];
        }
        // 数字Bold & 24 汉字小
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"第%d天",itemIndex + 1]];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(1,str.length-2)];
        item.attributedText = str;
        
        // 添加点击事件
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [item addGestureRecognizer:tapGestureRecognizer];
        item.userInteractionEnabled = YES;
        
        [self.slideView addSubview:item];
    }
    
    // 设置顶部分类滚动视图内容的尺寸
    [self.slideView setContentSize:CGSizeMake(itemCount * kSlideIndexViewWidth, 0)];
}

// 重新绘制
- (void)reloadData
{
    self.selectItemID = 100;
    
    for (UIView * subView in self.slideView.subviews)
    {
        if (![subView isKindOfClass:[UIImageView class]])
        {
            [subView removeFromSuperview];
        }
    }
    [self createUI];
}

#pragma mark - Action
- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self reloadData];
    
    NSInteger tag = tapGestureRecognizer.view.tag;
    self.selectItemID = tag;
    
    UILabel *itemLabel = [self.slideView viewWithTag:tag];
    itemLabel.textColor = [UIColor whiteColor];
    [itemLabel setBackgroundColor:Color(69, 175, 227)];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.slideIndexView.left = kSlideIndexViewWidth * (self.selectItemID - 100);
    } completion:^(BOOL finished) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slidePlanIndexView:didselectedItemAtIndex:)]) {
            [self.delegate slidePlanIndexView:self didselectedItemAtIndex:self.selectItemID-100];
        }
    }];
}

@end
