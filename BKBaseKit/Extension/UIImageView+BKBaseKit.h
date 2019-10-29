//
//  UIImageView+BKBaseKit.h
//  BKUIKit
//
//  Created by zhaolin on 2019/10/28.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (BKBaseKit)

#pragma mark - 虚线

/**
 添加虚线
 
 @param color 虚线颜色
 @param length 单条线长度
 @param space 每条线之间的距离
 @param height 线的高度
 */
-(void)BK_addDottedLineImageWithColor:(UIColor*)color length:(CGFloat)length space:(CGFloat)space height:(CGFloat)height;

#pragma mark - 添加自定义颜色的图片

/**
 添加自定义颜色的图片

 @param image 图片
 @param csColor 自定义颜色的图片
 */
-(void)BK_setImage:(UIImage *)image csColor:(UIColor*)csColor;

@end

NS_ASSUME_NONNULL_END
