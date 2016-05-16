//
//  DrawView.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "DrawView.h"
#import "CoordinateItem.h"
#import "LineChartView.h"
#import "BarChartView.h"
#import "PieChartView.h"

#define MARGIN_BETWEEN_X_POINT 50   //X轴的坐标点的间距
//#define MAX_POINT_WITHIN_SCREEN 13   //一屏幕最多容纳的坐标数
#define MAX_POINT_WITHIN_SCREEN 6   //一屏幕最多容纳的坐标数

@interface DrawView()

//数据源
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation DrawView

/**
 *  @author li_yong
 *
 *  构造方法
 *
 *  @param frame      frame
 *  @param dataSource 数据源
 *  @param type       绘图类型
 *  @isAnimation      是否动态绘制
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame
     withDataSource:(NSMutableArray *)dataSource
           withType:(ChartViewType)type
      withAnimation:(BOOL)isAnimation
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.autoresizesSubviews = NO;
        self.dataSource = [NSMutableArray arrayWithArray:dataSource];
        self.chartViewType = type;
        self.isAnimation = isAnimation;
        [self buildView];
    }
    return self;
}

- (void)buildView
{
    self.backgroundColor = [UIColor whiteColor];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    switch (self.chartViewType)
    {
        case LineChartViewType:
        {
            //根据数据源设置图形的尺寸
            [self sizeForDataSource];
            
            //折线图
            LineChartView *lineChartView = [[LineChartView alloc] initWithDataSource:self.dataSource
                                                               withLineAndPointColor:Color(69, 175, 227)
                                                                       withAnimation:self.isAnimation];
            lineChartView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
            [self addSubview:lineChartView];
        }
            break;
        case BarChartViewType:
        {
            //柱状图的数据源需要特殊处理(数据源的开始位置和结束位置需要添加空数据，方便绘制柱状体)
            CoordinateItem *firstItem = [[CoordinateItem alloc] initWithXValue:@""
                                                                    withYValue:@""
                                                                     withColor:[UIColor purpleColor]];
            [self.dataSource insertObject:firstItem atIndex:0];
            CoordinateItem *lastObject = [[CoordinateItem alloc] initWithXValue:@""
                                                                     withYValue:@""
                                                                      withColor:[UIColor purpleColor]];
            [self.dataSource insertObject:lastObject atIndex:[self.dataSource count]];
            
            //根据数据源设置图形的尺寸
            [self sizeForDataSource];
            
            //柱状图
            BarChartView *barChartView = [[BarChartView alloc] initWithDataSource:self.dataSource
                                                                        withColor:Color(69, 175, 227)
                                                                    withAnimation:self.isAnimation];
            barChartView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
            [self addSubview:barChartView];
        }
            break;
        case PieChartViewType:
        {
            //饼状图
            PieChartView *pieChartView = [[PieChartView alloc] initWithDataSource:self.dataSource withAimation:self.isAnimation];
            pieChartView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            pieChartView.pieRadius = 35;
            [self addSubview:pieChartView];
        }
            break;
        default:
            break;
    }
}

/**
 *  @author li_yong
 *
 *  根据数据源设置图形的尺寸
 */
- (void)sizeForDataSource
{
    //根据数据源的个数设置DrawView的内容Size
    NSUInteger valueCount = [self.dataSource count];
    if (valueCount > MAX_POINT_WITHIN_SCREEN)
    {
        self.contentSize = CGSizeMake(self.frame.size.width + (valueCount - MAX_POINT_WITHIN_SCREEN) * MARGIN_BETWEEN_X_POINT, self.frame.size.height);
    }else
    {
        self.contentSize = CGSizeMake(self.frame.size.width - (MAX_POINT_WITHIN_SCREEN - valueCount) * MARGIN_BETWEEN_X_POINT, self.frame.size.height);
    }
}

@end
