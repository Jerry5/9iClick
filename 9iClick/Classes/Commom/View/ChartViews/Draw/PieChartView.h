//
//  PieChartView.h
//  DrawTool
//
//  Created by li_yong on 15/7/13.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartView : UIView

//饼状图的大小
@property (assign, nonatomic) CGFloat pieRadius;

/**
 *  @author li_yong
 *
 *  构建函数
 *
 *  @param dataSource  数据源
 *  @param isAnimation 是否使用动画绘制
 *
 *  @return
 */
- (id)initWithDataSource:(NSMutableArray *)dataSource withAimation:(BOOL)isAnimation;

@end
