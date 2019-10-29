//
//  UIImageView+BKBaseKit.m
//  BKUIKit
//
//  Created by zhaolin on 2019/10/28.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import "UIImageView+BKBaseKit.h"

@implementation UIImageView (BKBaseKit)

#pragma mark - 虚线

/**
 添加虚线
 */
-(void)BK_addDottedLineImageWithColor:(UIColor*)color length:(CGFloat)length space:(CGFloat)space height:(CGFloat)height
{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, height);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGFloat lengths[] = {length, space};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.frame.size.width, 0);
    CGContextStrokePath(context);
    UIImage * dottedLine = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = dottedLine;
}

#pragma mark - 添加自定义颜色的图片

/**
 添加自定义颜色的图片
 */
-(void)BK_setImage:(UIImage *)image csColor:(UIColor*)csColor
{
    self.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tintColor = csColor;
}

@end
