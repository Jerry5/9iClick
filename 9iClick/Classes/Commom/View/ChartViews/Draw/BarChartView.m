//
//  BarChartView.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "BarChartView.h"
#import "CoordinateItem.h"

#define BAR_WIDTH 30
#define ANIMATION_DURING 0.5

@interface BarChartView()

//柱形的颜色
@property (strong, nonatomic) UIColor *barColor;

//是否动态绘制
@property (assign, nonatomic) BOOL isAnimation;

@end

@implementation BarChartView

- (id)initWithDataSource:(NSMutableArray *)dataSource
               withColor:(UIColor *)color
           withAnimation:(BOOL)isAnimation
{
    self = [super initWithDataSource:dataSource];
    if (self)
    {
        self.barColor = color;
        self.isAnimation = isAnimation;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef currentCtx = UIGraphicsGetCurrentContext();
    
    for(int index = 0; index<[self.dataSource count]; index++)
    {
        CoordinateItem *item = [self.dataSource objectAtIndex:index];
        if(([item.coordinateXValue length] == 0)||
           ([item.coordinateYValue length] == 0))
        {
            //空数据就不绘制
            continue;
        }
        //柱形的开始位置
        CGFloat startX = MARGIN_LEFT + (index ) * MARGIN_BETWEEN_X_POINT - BAR_WIDTH/2;
        CGFloat startY = self.frame.size.height - (MARGIN_TOP + [item.coordinateYValue integerValue]*(self.dashedSpace/self.yNumberSpace));
        CGRect itemRect = CGRectMake(startX, startY, BAR_WIDTH, [item.coordinateYValue integerValue]*(self.dashedSpace/self.yNumberSpace));
        [self drawBarWithRect:itemRect];
        
        /*  使用CoreGraphics直接绘制
        CGContextMoveToPoint(currentCtx, startX, startY);
        CGContextAddRect(currentCtx, itemRect);
        CGContextSetFillColorWithColor(currentCtx, self.barColor.CGColor);
        CGContextFillPath(currentCtx);
         */
    }
    CGContextStrokePath(currentCtx);
}

/**
 *  @author li_yong
 *
 *  绘制柱形
 *
 *  @param itemRect 柱形的大小和位置
 */
- (void)drawBarWithRect:(CGRect)itemRect
{
    CAShapeLayer *barLayer = [CAShapeLayer layer];
    //设置图形线条的宽度
    barLayer.lineWidth = 1;
    barLayer.lineCap = kCALineCapButt;
    //设置图形线条的颜色
    barLayer.strokeColor = self.barColor.CGColor;
    //设置图形的填充色
    barLayer.fillColor = self.barColor.CGColor;
    
    CGMutablePathRef barPath = CGPathCreateMutable();
    CGPathMoveToPoint(barPath, nil, itemRect.origin.x, itemRect.origin.y);
    CGPathAddRect(barPath, nil, itemRect);
    barLayer.path = barPath;
    CGMutablePathRef initBarPath = CGPathCreateMutable();
    CGPathMoveToPoint(initBarPath, nil, itemRect.origin.x, self.frame.size.height - MARGIN_TOP);
    CGPathAddRect(initBarPath, nil, CGRectMake(itemRect.origin.x, self.frame.size.height - MARGIN_TOP, itemRect.size.width, 0));
    
    if (self.isAnimation)
    {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.duration = ANIMATION_DURING;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = (__bridge id)initBarPath;
        pathAnimation.toValue = (__bridge id)barPath;
        //是否翻转绘制
        pathAnimation.autoreverses = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [barLayer addAnimation:pathAnimation forKey:@"path"];
    }

    [self.layer addSublayer:barLayer];
    CGPathRelease(barPath);
    CGPathRelease(initBarPath);
}

@end
