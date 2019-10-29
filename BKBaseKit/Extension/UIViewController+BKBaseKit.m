//
//  UIViewController+BKBaseKit.m
//  BKUIKit
//
//  Created by zhaolin on 2019/10/29.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import "UIViewController+BKBaseKit.h"

@implementation UIViewController (BKBaseKit)

#pragma mark - 模态弹出跳转

/// 模态弹出跳转 (此方法为全屏弹出,用于解决ios13弹出非全屏)
-(void)bk_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(nullable void (^)(void))completion
{
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
