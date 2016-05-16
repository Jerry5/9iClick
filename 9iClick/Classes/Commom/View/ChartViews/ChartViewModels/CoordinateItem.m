//
//  CoordinateItem.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "CoordinateItem.h"

@implementation CoordinateItem

/**
 *  @author li_yong
 *
 *  构造函数
 *
 *  @param xValue X坐标值
 *  @param yValue Y坐标值
 *
 *  @return
 */
- (id)initWithXValue:(NSString *)xValue withYValue:(NSString *)yValue
{
    self = [super init];
    if (self)
    {
        self.coordinateXValue = xValue;
        self.coordinateYValue = yValue;
    }
    return self;
}

/**
 *  @author li_yong
 *
 *  构造函数
 *
 *  @param xValue    X坐标值
 *  @param yValue    Y坐标值
 *  @param itemColor item的颜色
 *
 *  @return
 */
- (id)initWithXValue:(NSString *)xValue
          withYValue:(NSString *)yValue
           withColor:(UIColor *)itemColor
{
    self = [super init];
    if (self)
    {
        self.coordinateXValue = xValue;
        self.coordinateYValue = yValue;
        self.itemColor = itemColor;
    }
    return self;
}

@end
