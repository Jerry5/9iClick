//
//  CoordinateItem.h
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CoordinateItem : NSObject

//X坐标值
@property (copy, nonatomic) NSString *coordinateXValue;
//Y坐标值
@property (copy, nonatomic) NSString *coordinateYValue;
//颜色(主要用于绘制扇形图，区分数据)
@property (strong, nonatomic) UIColor *itemColor;

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
- (id)initWithXValue:(NSString *)xValue withYValue:(NSString *)yValue;

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
           withColor:(UIColor *)itemColor;

@end
