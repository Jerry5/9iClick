//
//  PieChartView.m
//  DrawTool
//
//  Created by li_yong on 15/7/13.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "PieChartView.h"
#import "CoordinateItem.h"

#define Angle(percent) 2*M_PI*percent
#define PIE_RADIUS (self.frame.size.height>self.frame.size.width?self.frame.size.width:self.frame.size.height)/4
#define ANIMATION_DURING 0.5

@interface PieChartView()

//是否动态绘制
@property (assign, nonatomic) BOOL isAnimation;
//数据源
@property (strong, nonatomic) NSMutableArray *dataSource;
//百分比数组
@property (strong, nonatomic) NSMutableArray *percentArray;
//角度值数组
@property (strong, nonatomic) NSMutableArray *angleArray;

@end

@implementation PieChartView

/**
 *  @author li_yong
 *
 *  构造函数
 *
 *  @param dataSource 数据源
 *
 *  @return
 */
- (id)initWithDataSource:(NSMutableArray *)dataSource withAimation:(BOOL)isAnimation
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.isAnimation = isAnimation;
        [self buildDataSourceWith:dataSource];
    }
    return self;
}

- (void)buildDataSourceWith:(NSMutableArray *)dataSource
{
    self.dataSource = [NSMutableArray arrayWithArray:dataSource];
    
    //根据传进来的数据计算比例数据
    __block CGFloat totalData = 0.0;
    __weak PieChartView *weakSelf = self;
    self.percentArray = [NSMutableArray arrayWithCapacity:0];
    self.angleArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.dataSource enumerateObjectsUsingBlock:^(CoordinateItem *obj, NSUInteger idx, BOOL *stop) {
        //统计总值
        totalData = totalData + [obj.coordinateYValue floatValue];
    }];
    
    [self.dataSource enumerateObjectsUsingBlock:^(CoordinateItem *obj, NSUInteger idx, BOOL *stop) {
        //统计百分比
        CGFloat percent = [obj.coordinateYValue floatValue]/totalData;
        NSNumber *percentNumber = [NSNumber numberWithFloat:percent];
        [weakSelf.percentArray addObject:percentNumber];
        //统计角度值
        CGFloat angle = Angle(percent);
        NSNumber *angleNumber = [NSNumber numberWithFloat:angle];
        [weakSelf.angleArray addObject:angleNumber];
    }];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //设置饼状图的半径(PIE_RADIUS是最大的半径)
    if((self.pieRadius == 0)||
        (self.pieRadius > PIE_RADIUS))
    {
        self.pieRadius = PIE_RADIUS;
    }
    
    __weak PieChartView *weakSelf = self;
    __block CGFloat endAngle = 0.0;
    __block CGFloat startAngle = 0.0;
    [self.angleArray enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        //绘制的弧度大小
        CGFloat duringAngle = [obj floatValue];
        //计算开始弧度
        startAngle = endAngle;
        //计算结束弧度
        endAngle = startAngle + duringAngle;
        //绘制扇形
        [weakSelf drawPinWithStartAngle:startAngle
                           withEndAngle:endAngle
                              withIndex:idx];
    }];
}

/**
 *  @author li_yong
 *
 *  绘制扇形
 *
 *  @param startAngle 扇形的开始角度
 *  @param endAngle   扇形的结束角度
 *  @param idx        数据项的序号
 */
- (void)drawPinWithStartAngle:(CGFloat)startAngle
                 withEndAngle:(CGFloat)endAngle
                    withIndex:(NSUInteger)idx
{
    CAShapeLayer *pieLayer = [CAShapeLayer layer];
    //这里设置填充线的宽度，这个参数很重要
    pieLayer.lineWidth = self.pieRadius*2;
    //设置线端点样式，这个也是非常重要的一个参数
    pieLayer.lineCap = kCALineCapButt;
    //设置绘制的颜色
    CoordinateItem *item = [self.dataSource objectAtIndex:idx];
    pieLayer.strokeColor = item.itemColor.CGColor;
    pieLayer.fillColor = nil;
    
    //绘制图形
    CGMutablePathRef piePath  = CGPathCreateMutable();
    CGPathAddArc(piePath, &CGAffineTransformIdentity, self.center.x, self.center.y, self.pieRadius, startAngle, endAngle, NO);
    pieLayer.path = piePath;
    
    //是否动态绘制
    if (self.isAnimation)
    {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        //设置绘制动画持续的时间
        pathAnimation.duration = ANIMATION_DURING;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        //是否翻转绘制
        pathAnimation.autoreverses = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [pieLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
    //表示绘制到百分比多少就停止，这个我们用1表示完全绘制
//    pieLayer.strokeEnd = 1.0;
    
    //该属性表示如果图形绘制超过的容器的范围是否被裁掉，这里我们设置为YES ，表示要裁掉超出范围的绘制
//    self.clipsToBounds = NO;
    [self.layer addSublayer:pieLayer];
//    CGPathRelease(piePath);
}

@end
