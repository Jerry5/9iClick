//
//  DrawView.h
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    LineChartViewType,  //折线图
    BarChartViewType,   //柱状图
    PieChartViewType    //饼状图
}ChartViewType;

@interface DrawView : UIScrollView

//图形类型
@property (assign, nonatomic) ChartViewType chartViewType;

//是否动态绘制
@property (assign, nonatomic) BOOL isAnimation;

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
      withAnimation:(BOOL)isAnimation;

@end
