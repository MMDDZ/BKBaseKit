//
//  AppDelegate.m
//  BKBaseKitDemo
//
//  Created by zhaolin on 2019/10/29.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    
    DemoListViewController * vc = [[DemoListViewController alloc] init];
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
