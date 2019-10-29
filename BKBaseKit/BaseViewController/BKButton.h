//
//  BKButton.h
//  BKUIKit
//
//  Created by zhaolin on 2019/10/26.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 当图片和标题同时存在时 图片相对于标题的位置

 - BKImagePositionLeft: 左边
 - BKImagePositionTop: 上边
 - BKImagePositionRight: 右边
 - BKImagePositionBottom: 下边
 */
typedef NS_ENUM(NSUInteger, BKImagePosition) {
    BKImagePositionLeft = 0,
    BKImagePositionTop,
    BKImagePositionRight,
    BKImagePositionBottom,
};

NS_ASSUME_NONNULL_BEGIN

@interface BKButton : UIView

/***************************************************************************************************
 默认frame = CGRectMake(0, 0, 44, 44)
 ***************************************************************************************************/

#pragma mark - 图片init

-(nonnull instancetype)initWithImage:(nonnull UIImage *)image;
-(nonnull instancetype)initWithImage:(nonnull UIImage *)image imageSize:(CGSize)imageSize;

#pragma mark - 标题init

-(nonnull instancetype)initWithTitle:(nonnull NSString*)title;
-(nonnull instancetype)initWithTitle:(nonnull NSString*)title font:(nonnull UIFont*)font;
-(nonnull instancetype)initWithTitle:(nonnull NSString*)title titleColor:(nonnull UIColor*)titleColor;
-(nonnull instancetype)initWithTitle:(nonnull NSString*)title font:(nonnull UIFont*)font titleColor:(nonnull UIColor*)titleColor;

#pragma mark - 图片&标题init

-(nonnull instancetype)initWithImage:(nonnull UIImage *)image title:(nonnull NSString*)title;
-(nonnull instancetype)initWithImage:(nonnull UIImage *)image title:(nonnull NSString*)title imagePosition:(BKImagePosition)imagePosition;
-(nonnull instancetype)initWithImage:(nonnull UIImage *)image imageSize:(CGSize)imageSize title:(nonnull NSString*)title;
-(nonnull instancetype)initWithImage:(nonnull UIImage *)image imageSize:(CGSize)imageSize title:(nonnull NSString*)title imagePosition:(BKImagePosition)imagePosition;
-(nonnull instancetype)initWithImage:(nonnull UIImage *)image imageSize:(CGSize)imageSize title:(nonnull NSString*)title font:(nonnull UIFont*)font titleColor:(nonnull UIColor*)titleColor imagePosition:(BKImagePosition)imagePosition;

#pragma mark - 点击方法

/**
 点击方法(无参数)

 @param target 对象
 @param action 方法
 */
-(void)addTarget:(nullable id)target action:(nonnull SEL)action;

/**
 点击方法(单参数)

 @param target 对象
 @param action 方法
 @param object 单参数
 */
-(void)addTarget:(nullable id)target action:(nonnull SEL)action object:(nullable id)object;

/**
 点击方法(多参数)

 @param target 对象
 @param action 方法
 @param objects 多参数
 */
-(void)addTarget:(nullable id)target action:(nonnull SEL)action objects:(nullable NSArray*)objects;

#pragma mark - 属性

/**
 标题
 */
@property (nonatomic,copy,nullable) NSString * title;
/**
 标题大小
 */
@property (nonatomic,strong,nullable) UIFont * font;
/**
 标题颜色
 */
@property (nonatomic,strong,nullable) UIColor * titleColor;
/**
 图片 修改图片颜色请修改tintColor
 */
@property (nonatomic,strong,nullable) UIImage * image;
/**
 图片大小
 */
@property (nonatomic,assign) CGSize imageSize;
/**
 图片位置
 */
@property (nonatomic,assign) BKImagePosition imagePosition;

@end

NS_ASSUME_NONNULL_END
