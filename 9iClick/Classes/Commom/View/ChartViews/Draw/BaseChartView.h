//
//  BaseChartView.h
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN_LEFT 35              //统计图的左间隔
#define MARGIN_TOP 30               //统计图的顶部间隔
#define MARGIN_BETWEEN_X_POINT 50   //X轴的坐标点的间距
#define Y_SECTION 5                 //纵坐标轴的区间数

@interface BaseChartView : UIView

@property (strong, nonatomic) NSMutableArray *dataSource;

//纵坐标上标记点的间距(即虚线的间距)
@property (assign, nonatomic) CGFloat dashedSpace;
//纵坐标最大值
@property (assign, nonatomic) int maxYValue;
//纵坐标最小值
@property (assign, nonatomic) int minYValue;
//纵坐标的数值间隔(显示出来的坐标值的间隔)
@property (assign, nonatomic) int yNumberSpace;

/**
 *  @author li_yong
 *
 *  构造函数
 *
 *  @param dataSource 数据源
 *
 *  @return
 */
- (id)initWithDataSource:(NSMutableArray *)dataSource;

@end
