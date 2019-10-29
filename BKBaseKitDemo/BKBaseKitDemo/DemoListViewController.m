//
//  DemoListViewController.m
//  BKBaseKitDemo
//
//  Created by zhaolin on 2019/10/29.
//  Copyright © 2019 BIKE. All rights reserved.
//

#import "DemoListViewController.h"

@interface DemoListViewController ()

@end

@implementation DemoListViewController

#pragma mark - viewDidLoad

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BKButton * closeBtn = [[BKButton alloc] initWithImage:[UIImage imageNamed:@"nav_back"] title:@"haha sfvnelrnbvljngvlkrwmvlnkwnvlkwenvjklwevnlkrwnvlrnvjlrwnvljre"];
    closeBtn.imagePosition = BKImagePositionTop;
    closeBtn.frame = CGRectMake(100, 100, 100, 20);
    closeBtn.backgroundColor = [UIColor redColor];
    closeBtn.tintColor = [UIColor yellowColor];
    [closeBtn addTarget:self action:@selector(closeBtnClick)];
    [self.view addSubview:closeBtn];
}

-(void)closeBtnClick
{
    NSLog(@"666");
}

@end
