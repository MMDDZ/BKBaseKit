//
//  NSString+BKBaseKit.m
//  BKUIKit
//
//  Created by zhaolin on 2019/10/28.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import "NSString+BKBaseKit.h"

@implementation NSString (BKBaseKit)

#pragma mark - 转化拼音

/**
 转化为拼音
 */
-(NSString*)bk_transformToPinyin
{
    if (self.length <= 0) {
        return self;
    }
    NSMutableString * tempStringM = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)tempStringM, NULL, kCFStringTransformToLatin, false);
    NSString * tempString = [tempStringM stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [tempString uppercaseString];
}

/**
 转化为拼音，并且取首字母
 */
-(NSString*)bk_takeFirstLetterOfPinyin
{
    if (self.length <= 0) {
        return self;
    }
    return [[self bk_transformToPinyin] substringWithRange:NSMakeRange(0, 1)];
}

#pragma mark - 计算文本大小

/**
 计算文本大小(固定宽)
 
 @param width 固定宽度
 @param font 字体大小
 @return 文本大小
 */
-(CGSize)bk_calculateSizeWithUIWidth:(CGFloat)width font:(UIFont*)font
{
    if (!self || width <= 0 || !font) {
        return CGSizeZero;
    }
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                       options: NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    
    return rect.size;
}

/**
 计算文本大小(固定高)
 
 @param height 固定高度
 @param font 字体大小
 @return 文本大小
 */
-(CGSize)bk_calculateSizeWithUIHeight:(CGFloat)height font:(UIFont*)font
{
    if (!self || height <= 0 || !font) {
        return CGSizeZero;
    }
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                       options: NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil];
    
    return rect.size;
}

#pragma mark - 删除小数点后的0

/**
 删除小数点后的0
 
 @return 删除后的结果
 */
-(NSString*)bk_deleteZeroAfterDecimalPoint
{
    if (![self containsString:@"."]) {
        return self;
    }
    NSMutableString * mSelf = [[NSMutableString alloc] initWithString:self];
    while ([[mSelf substringFromIndex:[mSelf length] - 1] isEqualToString:@"0"]) {//删除小数点后的0
        [mSelf deleteCharactersInRange:NSMakeRange([mSelf length] - 1, 1)];
    }
    if ([[mSelf substringFromIndex:[mSelf length] - 1] isEqualToString:@"."]) {//小数点后没有0，删除小数点
        [mSelf deleteCharactersInRange:NSMakeRange([mSelf length] - 1, 1)];
    }
    return [mSelf copy];
}

#pragma mark - 保留2位小数

/**
 保留2位小数
 */
-(NSString*)bk_keepTwoDecimalPlaces
{
    NSMutableString * mSelf = [[NSMutableString alloc] initWithString:self];
    if ([self containsString:@"."]) {
        NSInteger decimalLocation = [mSelf rangeOfString:@"."].location;
        NSInteger lastDecimalLocationLength = [mSelf length] - decimalLocation - 1;
        if (lastDecimalLocationLength > 2) {
            while (lastDecimalLocationLength != 2) {
                [mSelf deleteCharactersInRange:NSMakeRange([mSelf length] - 1, 1)];
                lastDecimalLocationLength--;
            }
        }else if (lastDecimalLocationLength < 2) {
            while (lastDecimalLocationLength != 0) {
                [mSelf appendString:@"0"];
                lastDecimalLocationLength--;
            }
        }
    }else {
        [mSelf appendString:@".00"];
    }
    return [mSelf copy];
}

#pragma mark - 删除整数前的0

/**
 删除整数前的0
 */
-(NSString*)bk_deleteLeadingZero
{
    if ([self length] == 0) {
        return self;
    }
    NSMutableString * mSelf = [[NSMutableString alloc] initWithString:self];
    while ([mSelf length] != 0 && [[mSelf substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {//删除小数点后的0
        [mSelf deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    //如果删除光了保留1个0
    if ([mSelf length] == 0) {
        [mSelf appendString:@"0"];
    }
    return [mSelf copy];
}

#pragma mark - 查看允不允许输入

/**
 查看允不允许输入 例如 允许输入1、2时传入12
 */
-(BOOL)bk_allowWriteString:(NSString*)string
{
    NSCharacterSet * cs = [[NSCharacterSet characterSetWithCharactersInString:string] invertedSet];
    NSString * filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}

@end
