//
//  YCoordinateView.m
//  testScreenOrientation
//
//  Created by 武志远 on 16/4/14.
//  Copyright © 2016年 武志远. All rights reserved.
//

#import "YCoordinateView.h"
#import "CoordinateItem.h"

@implementation YCoordinateView

/**
 *  @author li_yong
 *
 *  构造函数
 *
 *  @param dataSource 数据源
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame DataSource:(NSMutableArray *)dataSource
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.dataSource = dataSource;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.alpha = 0.3;
        [self addSubview:backgroundView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 绘制Y坐标系
    [self drawYCoordinate];
}

- (void)drawYCoordinate
{
    self.dashedSpace = (CGFloat)(self.frame.size.height - 2*MARGIN_TOP)/Y_SECTION;
    self.maxYValue = [self compareForMaxValue];
    self.minYValue = [self compareForMinValue];
    self.yNumberSpace = (self.maxYValue-self.minYValue)/Y_SECTION;
    for (int index = 0; index<Y_SECTION+1; index++)
    {
        CGPoint centerPoint = CGPointMake(MARGIN_LEFT/2, MARGIN_TOP + self.dashedSpace * index);
        CGRect bounds = CGRectMake(0, 0, MARGIN_LEFT - 10, 15);
        NSString *labelText = [NSString stringWithFormat:@"%d",self.yNumberSpace * (Y_SECTION - index) + self.minYValue];
        UILabel *yNumber = [self createLabelWithCenter:centerPoint
                                            withBounds:bounds
                                              withText:labelText
                                     withtextAlignment:NSTextAlignmentRight];
        [self addSubview:yNumber];
    }
}


/**
 *  @author li_yong
 *
 *  获取最大的纵坐标值
 */
- (int)compareForMaxValue
{
    __block float maxYValue = 0.0f;
    //获取最大的纵坐标值
    [self.dataSource enumerateObjectsUsingBlock:^(CoordinateItem *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.coordinateYValue floatValue] > maxYValue)
        {
            maxYValue = [obj.coordinateYValue floatValue];
        }
    }];
    if (maxYValue-(int)maxYValue>0) {
        maxYValue = (int)maxYValue + 1;
    }
    
    //获取最大的纵坐标值整数
    if(((int)maxYValue % Y_SECTION) != 0)
    {
        maxYValue = maxYValue + (Y_SECTION - (int)maxYValue % Y_SECTION);
    }
    NSLog(@"maxYValue = %f",maxYValue);
    
    return maxYValue;
}

/**
 *  @author li_yong
 *
 *  获取最小的纵坐标值
 */
- (int)compareForMinValue
{
    __block float minYValue = 100.0f;
    //获取最小的纵坐标值
    [self.dataSource enumerateObjectsUsingBlock:^(CoordinateItem *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.coordinateYValue floatValue] < minYValue)
        {
            minYValue = [obj.coordinateYValue floatValue];
        }
    }];
    NSLog(@"before minYValue = %f",minYValue);

    if (minYValue-(int)minYValue>0) {
        minYValue = (int)minYValue + 1;
    }
    NSLog(@"before minYValue = %f",minYValue);
    NSLog(@"minYValue / Y_SECTION = %d",(int)minYValue % Y_SECTION);
    //获取最小的纵坐标值整数
    if(((int)minYValue % Y_SECTION) != 0)
    {
        minYValue = minYValue - (int)minYValue % Y_SECTION;
    }
    NSLog(@"minYValue = %f",minYValue);
    return minYValue ;
}

/**
 *  @author li_yong
 *
 *  UILabel的工厂方法
 *
 *  @param centerPoint   label的中心
 *  @param bounds        label的大小
 *  @param labelText     label的内容
 *  @param textAlignment label的内容排版方式
 *
 *  @return
 */
- (UILabel *)createLabelWithCenter:(CGPoint)centerPoint
                        withBounds:(CGRect)bounds
                          withText:(NSString *)labelText
                 withtextAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] init];
    label.center = centerPoint;
    label.bounds = bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = textAlignment;
    label.text = labelText;
    
    return label;
}

@end
