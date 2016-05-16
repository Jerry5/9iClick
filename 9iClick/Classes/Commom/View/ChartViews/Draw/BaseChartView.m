//
//  BaseChartView.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "BaseChartView.h"
#import "CoordinateItem.h"

@interface BaseChartView()

@end

@implementation BaseChartView

/**
 *  @author li_yong
 *
 *  构造函数
 *
 *  @param dataSource 数据源
 *
 *  @return
 */
- (id)initWithDataSource:(NSMutableArray *)dataSource
{
    self = [super init];
    if (self)
    {
        self.dataSource = dataSource;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //绘制坐标系
    [self drawCoordinate];
}

- (void)drawCoordinate
{
    CGContextRef currentCtx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentCtx, [[UIColor grayColor] CGColor]);
    CGContextSetLineWidth(currentCtx, 0.5);
    
    //1.绘制X轴和y轴
    //第一种方法绘制四条线
    CGPoint poins[] = {CGPointMake(MARGIN_LEFT, MARGIN_TOP),
                       CGPointMake(self.frame.size.width - MARGIN_LEFT, MARGIN_TOP),
                       CGPointMake(self.frame.size.width - MARGIN_LEFT, self.frame.size.height - MARGIN_TOP),
                       CGPointMake(MARGIN_LEFT, self.frame.size.height - MARGIN_TOP)};
    CGContextAddLines(currentCtx,poins,4);
    CGContextClosePath(currentCtx);
    CGContextStrokePath(currentCtx);
    
    /*
    //第二种方法绘制一个矩形
    CGContextMoveToPoint(currentCtx, MARGIN_LEFT, MARGIN_TOP);
    CGContextSetLineWidth(currentCtx, 0.1);
    CGContextSetRGBStrokeColor(currentCtx, 0.5, 0.5, 0.5, 1);
    CGContextAddRect(currentCtx, CGRectMake(MARGIN_LEFT, MARGIN_TOP, self.frame.size.width - 2*MARGIN_LEFT, self.frame.size.height - 2*MARGIN_TOP));
    CGContextClosePath(currentCtx);
    CGContextStrokePath(currentCtx);
    */
    
    //2.绘制虚线(暂时设置纵坐标分5个区间)
    //虚线间距
    self.dashedSpace = (CGFloat)(self.frame.size.height - 2*MARGIN_TOP)/Y_SECTION;
    //设置虚线属性
    CGFloat lengths[2] = {5,5};
    CGContextSetLineDash(currentCtx, 0, lengths, 1);
    for(int index = 1; index<Y_SECTION; index++)
    {
        CGContextMoveToPoint(currentCtx, MARGIN_LEFT, MARGIN_TOP + self.dashedSpace * index);
        CGContextAddLineToPoint(currentCtx, self.frame.size.width - MARGIN_LEFT, MARGIN_TOP + self.dashedSpace * index);
    }
    CGContextStrokePath(currentCtx);
    
    //3.设置纵坐标值
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
//        [self addSubview:yNumber];
    }
    
    //4.设置横坐标值
    for (int index = 0; index<[self.dataSource count]; index++)
    {
        CGPoint centerPoint = CGPointMake(MARGIN_LEFT + MARGIN_BETWEEN_X_POINT * index, self.frame.size.height - MARGIN_TOP/2 - 4);
        CGRect bounds = CGRectMake(0, 0, MARGIN_BETWEEN_X_POINT, 15);
        CoordinateItem *item = [self.dataSource objectAtIndex:index];
        UILabel *xNumber = [self createLabelWithCenter:centerPoint
                                           withBounds:bounds
                                             withText:item.coordinateXValue
                                    withtextAlignment:NSTextAlignmentCenter];
        [self addSubview:xNumber];
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
        if ([obj.coordinateYValue intValue] > maxYValue)
        {
           maxYValue = [obj.coordinateYValue intValue];
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
        if ([obj.coordinateYValue intValue] < minYValue)
        {
            minYValue = [obj.coordinateYValue intValue];
        }
    }];
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
