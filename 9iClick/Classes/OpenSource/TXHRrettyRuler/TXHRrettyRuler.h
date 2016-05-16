//
//  TXHRrettyRuler.h
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Tangxianhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXHRulerScrollView.h"

@protocol TXHRrettyRulerDelegate <NSObject>

- (void)txhRrettyRuler:(TXHRulerScrollView *)rulerScrollView;

@end

@interface TXHRrettyRuler : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) id <TXHRrettyRulerDelegate> rulerDeletate;

- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSUInteger)average
                        currentValue:(CGFloat)currentValue
                           smallMode:(BOOL)mode;

@end
