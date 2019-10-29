//
//  BKTools.m
//  BKUIKit
//
//  Created by zhaolin on 2019/10/26.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import "BKTools.h"
#import <Photos/Photos.h>

@implementation BKTools

#pragma mark - 当前显示window

/// 当前显示window
+(UIWindow*)keyWindow
{
    return [[[UIApplication sharedApplication] windows] objectAtIndex:0];
}

#pragma mark - 当前最上层显示的控制器

/// 当前最上层显示的控制器
+(UIViewController*)displayViewController
{
    UIViewController * displayVC = [self keyWindow].rootViewController;
    BOOL isContinue;
    do {
        if (displayVC.presentedViewController) {
            displayVC = displayVC.presentedViewController;
            isContinue = YES;
        }else if ([displayVC isKindOfClass:[UITabBarController class]]) {
            displayVC = ((UITabBarController*)displayVC).selectedViewController;
            isContinue = YES;
        }else if ([displayVC isKindOfClass:[UINavigationController class]]) {
            displayVC = ((UINavigationController*)displayVC).visibleViewController;
            isContinue = YES;
        }else {
            isContinue = NO;
        }
    } while (isContinue);
    return displayVC;
}

#pragma mark - 检测是否为空

/**
 检测是否为空
 */
+(BOOL)isEmptyObject:(id)object
{
    if (object == nil ||
        object == NULL ||
        [object isKindOfClass:[NSNull class]] ||
        [object isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}

#pragma mark - 打电话

/// 打电话
+(void)callPhone:(NSString*)phoneStr
{
    NSURL * phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneStr]];
    
    if (@available(iOS 10.0, *)) {
        [self openUrl:phoneUrl options:nil completionHandler:nil];
    }else {
        [self presentAlert:phoneStr message:nil actionTitleArr:@[@"取消", @"呼叫"] actionMethod:^(NSInteger index) {
            if (index == 1) {
                [self openUrl:phoneUrl options:nil completionHandler:nil];
            }
        }];
    }
}

#pragma mark - alert弹框

/**
 alert弹框
 */
+(UIAlertController*)presentAlert:(NSString*)title message:(NSString*)message actionTitleArr:(NSArray<NSString*>*)actionTitleArr actionMethod:(void (^)(NSInteger index))actionMethod
{
    return [self presentCommonAlert:UIAlertControllerStyleAlert title:title message:message actionTitleArr:actionTitleArr actionMethod:actionMethod];
}

/**
 alert底部弹框
*/
+(UIAlertController*)presentActionSheet:(NSString*)title message:(NSString*)message actionTitleArr:(NSArray<NSString*>*)actionTitleArr actionMethod:(void (^)(NSInteger index))actionMethod
{
    return [self presentCommonAlert:UIAlertControllerStyleActionSheet title:title message:message actionTitleArr:actionTitleArr actionMethod:actionMethod];
}

/// alert弹框通用方法
+(UIAlertController*)presentCommonAlert:(UIAlertControllerStyle)style title:(NSString*)title message:(NSString*)message actionTitleArr:(NSArray<NSString*>*)actionTitleArr actionMethod:(void (^)(NSInteger index))actionMethod
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for (int i = 0; i < [actionTitleArr count]; i++) {
        NSString * actionTitle = actionTitleArr[i];
        UIAlertActionStyle actionStyle;
        if ([actionTitle isEqualToString:@"取消"]) {
            actionStyle = UIAlertActionStyleCancel;
        }else{
            actionStyle = UIAlertActionStyleDefault;
        }
        UIAlertAction * action = [UIAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action) {
            if (actionMethod) {
                actionMethod(i);
            }
        }];
        [alert addAction:action];
    }
    [[self displayViewController] presentViewController:alert animated:YES completion:nil];
    return alert;
}

/**
 alert弹框(富文本)
 */
+(UIAlertController*)presentAttrAlert:(NSAttributedString*)attrTitle attrMessage:(NSAttributedString*)attrMessage actionTitleArr:(NSArray<NSString*>*)actionTitleArr actionMethod:(void (^)(NSInteger index))actionMethod
{
    return [self presentAttrAlert:attrTitle attrMessage:attrMessage actionTitleArr:actionTitleArr actionTitleColorArr:nil actionMethod:actionMethod];
}

/**
 alert弹框(富文本)
 */
+(UIAlertController*)presentAttrAlert:(NSAttributedString*)attrTitle attrMessage:(NSAttributedString*)attrMessage actionTitleArr:(NSArray<NSString*>*)actionTitleArr actionTitleColorArr:(NSArray<UIColor*>*)actionTitleColorArr actionMethod:(void (^)(NSInteger index))actionMethod
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert setValue:attrTitle forKey:@"attributedTitle"];
    [alert setValue:attrMessage forKey:@"attributedMessage"];
    
    for (int i = 0; i < [actionTitleArr count]; i++) {
        NSString * title = actionTitleArr[i];
        NSInteger style;
        if ([title isEqualToString:@"取消"]) {
            style = UIAlertActionStyleCancel;
        }else{
            style = UIAlertActionStyleDefault;
        }
        UIAlertAction * action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (actionMethod) {
                actionMethod(i);
            }
        }];
        if ([actionTitleColorArr count] > 0) {
            [action setValue:actionTitleColorArr[i] forKey:@"titleTextColor"];
        }
        [alert addAction:action];
    }
    [[self displayViewController] presentViewController:alert animated:YES completion:nil];
    return alert;
}

#pragma mark - 检测私有属性

/**
 检测是否允许调用相机
 */
+(void)checkAllowVisitCameraHandler:(void (^)(BOOL))handler alertHandler:(void (^)(void))alertHandler
{
    NSString * app_Name = [self getAppName];
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == PHAuthorizationStatusAuthorized) {
                        if (handler) {
                            handler(YES);
                        }
                    }else{
                        if (handler) {
                            handler(NO);
                        }
                        [self presentAlert:@"提示" message:[NSString stringWithFormat:@"%@没有权限访问您的相机\n在“设置-隐私-相机”中开启即可查看",app_Name] actionTitleArr:@[@"取消", @"去设置"] actionMethod:^(NSInteger index) {
                            if (index == 1) {
                                [self openUrl:[self getSystemSetupInterfaceUrl] options:nil completionHandler:nil];
                            }
                            if (alertHandler) {
                                alertHandler();
                            }
                        }];
                    }
                });
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
        {
           dispatch_async(dispatch_get_main_queue(), ^{
               if (handler) {
                   handler(NO);
               }
                      
               [self presentAlert:@"提示" message:[NSString stringWithFormat:@"%@没有访问相机的权限", app_Name] actionTitleArr:@[@"确认"] actionMethod:^(NSInteger index) {
                    if (alertHandler) {
                        alertHandler();
                    }
                }];
            });
        }
            break;
        case AVAuthorizationStatusDenied:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) {
                    handler(NO);
                }
            
                [self presentAlert:@"提示" message:[NSString stringWithFormat:@"%@没有权限访问您的相机\n在“设置-隐私-相机”中开启即可查看",app_Name] actionTitleArr:@[@"取消", @"去设置"] actionMethod:^(NSInteger index) {
                    if (index == 1) {
                        [self openUrl:[self getSystemSetupInterfaceUrl] options:nil completionHandler:nil];
                    }
                    if (alertHandler) {
                        alertHandler();
                    }
                }];
            });
        }
            break;
        case AVAuthorizationStatusAuthorized:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) {
                    handler(YES);
                }
            });
        }
            break;
        default:
            break;
    }
}

/**
 检测是否允许调用相册
 */
+(void)checkAllowVisitPhotoAlbumHandler:(void (^)(BOOL))handler alertHandler:(void (^)(void))alertHandler
{
    NSString * app_Name = [self getAppName];
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    switch (status) {
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == PHAuthorizationStatusAuthorized) {
                        if (handler) {
                            handler(YES);
                        }
                    }else{
                        if (handler) {
                            handler(NO);
                        }
                        [self presentAlert:@"提示" message:[NSString stringWithFormat:@"%@没有权限访问您的相册\n在“设置-隐私-照片”中开启即可查看", app_Name] actionTitleArr:@[@"确认", @"去设置"] actionMethod:^(NSInteger index) {
                            if (index == 1) {
                                [self openUrl:[self getSystemSetupInterfaceUrl] options:nil completionHandler:nil];;
                            }
                            if (alertHandler) {
                                alertHandler();
                            }
                        }];
                    }
                });
            }];
        }
            break;
        case PHAuthorizationStatusRestricted:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) {
                    handler(NO);
                }
                [self presentAlert:@"提示" message:[NSString stringWithFormat:@"%@没有访问相册的权限", app_Name] actionTitleArr:@[@"确认"] actionMethod:^(NSInteger index) {
                    if (alertHandler) {
                        alertHandler();
                    }
                }];
            });
        }
            break;
        case PHAuthorizationStatusDenied:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) {
                    handler(NO);
                }
                [self presentAlert:@"提示" message:[NSString stringWithFormat:@"%@没有权限访问您的相册\n在“设置-隐私-照片”中开启即可查看", app_Name] actionTitleArr:@[@"确认", @"去设置"] actionMethod:^(NSInteger index) {
                    if (index == 1) {
                        [self openUrl:[self getSystemSetupInterfaceUrl] options:nil completionHandler:nil];
                    }
                    if (alertHandler) {
                        alertHandler();
                    }
                }];
            });
        }
            break;
        case PHAuthorizationStatusAuthorized:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) {
                    handler(YES);
                }
            });
        }
            break;
        default:
            break;
    }
}

#pragma mark - 打开外部Url

/// 打开外部url
+(void)openUrl:(NSURL*)url options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options completionHandler:(void (^)(BOOL success))completion
{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:options completionHandler:completion];
    }else {
        BOOL flag = [[UIApplication sharedApplication] openURL:url];
        if (completion) {
            completion(flag);
        }
    }
}

#pragma mark - 系统属性

/// 获取app设置url
+(nullable NSURL*)getSystemSetupInterfaceUrl
{
    return [NSURL URLWithString:UIApplicationOpenSettingsURLString];
}

/// 获取app名称
+(nonnull NSString*)getAppName
{
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

/// 获取app版本号
+(nonnull NSString*)getAppVersion
{
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

/// 获取app建筑版本
+(nonnull NSString*)getAppBuilding
{
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

@end
