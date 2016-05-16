//
//  YMTextView.m
//
//
//  Created by 杨蒙 on 16/1/24.
//  Copyright © 2016年 杨蒙. All rights reserved.
//

#import "YMTextView.h"

@implementation YMTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

/**
 *  监听文字改变
 */
-(void)textDidChange {
    
    //重绘
    [self setNeedsDisplay];
    
}

-(void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text {
    [super setText:text];
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font {
    [super setFont:font];
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    //设置文字属性
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = self.font;
    attributes[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor lightGrayColor];
    //画文字
    CGFloat x = 5;
    CGFloat width = rect.size.width -2 * x;
    CGFloat y = 8;
    CGFloat height = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, width, height);
    [self.placeholder drawInRect:placeholderRect withAttributes:attributes];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
