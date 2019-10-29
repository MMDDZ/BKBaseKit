//
//  UIViewController+BKBaseKit.h
//  BKUIKit
//
//  Created by zhaolin on 2019/10/29.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BKBaseKit)

#pragma mark - 模态弹出跳转

/// 模态弹出跳转 (此方法为全屏弹出,用于解决ios13弹出非全屏)
/// @param viewControllerToPresent 弹出控制器
/// @param flag 是否有动画
/// @param completion 完成回调
-(void)bk_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(nullable void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
