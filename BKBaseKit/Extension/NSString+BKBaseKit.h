//
//  NSString+BKBaseKit.h
//  BKUIKit
//
//  Created by zhaolin on 2019/10/28.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BKBaseKit)

#pragma mark - 转化拼音

/**
 转化为拼音
 
 @return 拼音
 */
-(NSString*)bk_transformToPinyin;

/**
 转化为拼音，并且取首字母
 
 @return 拼音首字母
 */
-(NSString*)bk_takeFirstLetterOfPinyin;

#pragma mark - 计算文本大小

/**
 计算文本大小(固定宽)

 @param width 固定宽度
 @param font 字体大小
 @return 文本大小
 */
-(CGSize)bk_calculateSizeWithUIWidth:(CGFloat)width font:(UIFont*)font;

/**
 计算文本大小(固定高)
 
 @param height 固定宽度
 @param font 字体大小
 @return 文本大小
 */
-(CGSize)bk_calculateSizeWithUIHeight:(CGFloat)height font:(UIFont*)font;

#pragma mark - 删除小数点后的0

/**
 删除小数点后的0

 @return 删除后的结果
 */
-(NSString*)bk_deleteZeroAfterDecimalPoint;

#pragma mark - 保留2位小数

/**
 保留2位小数

 @return 修改后的结果
 */
-(NSString*)bk_keepTwoDecimalPlaces;

#pragma mark - 删除整数前的0

/**
 删除整数前的0

 @return 删除后的结果
 */
-(NSString*)bk_deleteLeadingZero;

#pragma mark - 查看允不允许输入

/**
 查看允不允许输入 例如 允许输入1、2时传入12
 
 @param string 允许输入字符串
 @return 允不允许
 */
-(BOOL)bk_allowWriteString:(NSString*)string;

@end

NS_ASSUME_NONNULL_END
