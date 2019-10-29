//
//  BKTools.h
//  BKUIKit
//
//  Created by zhaolin on 2019/10/26.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKTools : NSObject

#pragma mark - 当前显示window

/// 当前显示window
+(nullable UIWindow*)keyWindow;

#pragma mark - 当前最上层显示的控制器

/// 当前最上层显示的控制器
+(nullable UIViewController*)displayViewController;

#pragma mark - 检测是否为空

/**
 检测是否为空
 
 @param object 检测对象
 @return 是否为空
 */
+(BOOL)isEmptyObject:(nonnull id)object;

#pragma mark - 打电话

/// 打电话
/// @param phoneStr 电话号
+(void)callPhone:(nonnull NSString*)phoneStr;

#pragma mark - alert弹框

/**
 alert弹框

 @param title 标题
 @param message 信息
 @param actionTitleArr 按钮
 @param actionMethod 按钮事件回调
 @return alert弹框
 */
+(nonnull UIAlertController*)presentAlert:(nullable NSString*)title message:(nullable NSString*)message actionTitleArr:(nullable NSArray<NSString*>*)actionTitleArr actionMethod:(nullable void (^)(NSInteger index))actionMethod;

/**
 alert底部弹框

 @param title 标题
 @param message 信息
 @param actionTitleArr 按钮
 @param actionMethod 按钮事件回调
 @return alert弹框
*/
+(nonnull UIAlertController*)presentActionSheet:(nullable NSString*)title message:(nullable NSString*)message actionTitleArr:(nullable NSArray<NSString*>*)actionTitleArr actionMethod:(nullable void (^)(NSInteger index))actionMethod;

/**
 alert弹框(富文本)
 
 @param attrTitle 标题
 @param attrMessage 信息
 @param actionTitleArr 按钮
 @param actionMethod 按钮事件回调
 @return alert弹框
 */
+(nonnull UIAlertController*)presentAttrAlert:(nullable NSAttributedString*)attrTitle attrMessage:(nullable NSAttributedString*)attrMessage actionTitleArr:(nullable NSArray<NSString*>*)actionTitleArr actionMethod:(nullable void (^)(NSInteger index))actionMethod;

/**
 alert弹框(富文本)
 
 @param attrTitle 标题
 @param attrMessage 信息
 @param actionTitleArr 按钮
 @param actionTitleColorArr 按钮颜色数组
 @param actionMethod 按钮事件回调
 @return alert弹框
 */
+(nonnull UIAlertController*)presentAttrAlert:(nullable NSAttributedString*)attrTitle attrMessage:(nullable NSAttributedString*)attrMessage actionTitleArr:(nullable NSArray<NSString*>*)actionTitleArr actionTitleColorArr:(nullable NSArray<UIColor*>*)actionTitleColorArr actionMethod:(nullable void (^)(NSInteger index))actionMethod;

#pragma mark - 检测私有属性

/**
 检测是否允许调用相机
 
 @param handler 检测回调
 @param alertHandler 弹框处理回调
 */
+(void)checkAllowVisitCameraHandler:(nullable void (^)(BOOL flag))handler alertHandler:(nullable void (^)(void))alertHandler;

/**
 检测是否允许调用相册

 @param handler 检测回调
 @param alertHandler 弹框处理回调
 */
+(void)checkAllowVisitPhotoAlbumHandler:(nullable void (^)(BOOL flag))handler alertHandler:(nullable void (^)(void))alertHandler;

#pragma mark - 打开外部Url

/// 打开外部url
/// @param url url
/// @param options 选项 ios10以后有效
/// @param completion 结果
+(void)openUrl:(nonnull NSURL*)url options:(nullable NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options completionHandler:(nullable void (^)(BOOL success))completion;

#pragma mark - 系统属性

/// 获取app设置url
+(nullable NSURL*)getSystemSetupInterfaceUrl;

/// 获取app名称
+(nonnull NSString*)getAppName;

/// 获取app版本号
+(nonnull NSString*)getAppVersion;

/// 获取app建筑版本
+(nonnull NSString*)getAppBuilding;


@end

NS_ASSUME_NONNULL_END
