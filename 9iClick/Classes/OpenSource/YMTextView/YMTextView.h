//
//  YMTextView.h
//
//
//  Created by 杨蒙 on 16/1/24.
//  Copyright © 2016年 杨蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMTextView : UITextView
/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
