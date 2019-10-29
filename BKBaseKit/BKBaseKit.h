//
//  BKBaseKit.h
//  BKBaseKit
//
//  Created by zhaolin on 2019/10/29.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double BKBaseKitVersionNumber;
FOUNDATION_EXPORT const unsigned char BKBaseKitVersionString[];

#if __has_include(<BKBaseKit/BKBaseKit.h>)

#import <BKBaseKit/BKCommon.h>
#import <BKBaseKit/BKBaseKitExtension.h>

#import <BKBaseKit/BKBaseViewController.h>
#import <BKBaseKit/BKButton.h>

#else

#import "BKCommon.h"
#import "BKBaseKitExtension.h"

#import "BKBaseViewController.h"
#import "BKButton.h"

#endif
