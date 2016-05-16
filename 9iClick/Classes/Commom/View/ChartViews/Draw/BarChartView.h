//
//  BarChartView.h
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "BaseChartView.h"

@interface BarChartView : BaseChartView

/**
 *  @author li_yong
 *
 *  构建方法
 *
 *  @param dataSource  数据源
 *  @param color       折线点和折线的颜色
 *  @param isAnimation 是否动态绘制
 *
 *  @return
 */
- (id)initWithDataSource:(NSMutableArray *)dataSource
               withColor:(UIColor *)color
           withAnimation:(BOOL)isAnimation;


@end
