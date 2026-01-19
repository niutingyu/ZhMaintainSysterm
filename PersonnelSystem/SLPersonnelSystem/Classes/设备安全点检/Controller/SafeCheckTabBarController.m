//
//  SafeCheckTabBarController.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/6.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckTabBarController.h"
#import "SafeCheckTaskController.h"
#import "SafeCheckUnFinishController.h"
#import "SafeCheckHistoryController.h"
#import "BaseNavViewController.h"
#import "DeviceModel.h"
#import "MCBaseNavigationController.h"

@interface SafeCheckTabBarController ()

@end

@implementation SafeCheckTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbar];
    
}
-(void)initTabbar{
    
    [UITabBar appearance].translucent = YES;//不透明

    SafeCheckTaskController *taskVC = [[SafeCheckTaskController alloc] init];
    MCBaseNavigationController *tasknav  =[[MCBaseNavigationController alloc]initWithRootViewController:taskVC];
    [self addChildVC:tasknav title:@"任务" image:@"me-light." selectedImage:@"me-light."];
    
    SafeCheckUnFinishController *workoutVC = [[SafeCheckUnFinishController alloc] init];
    MCBaseNavigationController * worknav  =[[MCBaseNavigationController alloc]initWithRootViewController:workoutVC];
    [self addChildVC:worknav title:@"未完成" image:@"gougao-h" selectedImage:@"gougao-h"];
    SafeCheckHistoryController *historyVC = [[SafeCheckHistoryController alloc] init];
    MCBaseNavigationController * historynav  =[[MCBaseNavigationController alloc]initWithRootViewController:historyVC];
    [self addChildVC:historynav title:@"历史" image:@"tool-light." selectedImage:@"tool-light."];

}
-(void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self selectedTapTabBarItems:childVC.tabBarItem];
    [self unSelectedTapTabBarItems:childVC.tabBarItem];
    [self addChildViewController:childVC];
}
//tab字体颜色
-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor blueColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}
-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden  =YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden  =NO;
}

@end
