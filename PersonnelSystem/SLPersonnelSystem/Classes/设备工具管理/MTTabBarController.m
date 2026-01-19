//
//  MTTabBarController.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/10.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "MTTabBarController.h"
#import "MTToolTaskController.h"
#import "MTToolHistoryController.h"
#import "MTToolUnFinishController.h"
#import "BaseNavViewController.h"
@interface MTTabBarController ()

@end

@implementation MTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initTabbar{
    
    [UITabBar appearance].translucent = YES;//不透明
    // 去掉tab黑色分割线
   // self.tabBar.barStyle = UIBarStyleDefault;
    //self.tabBar.shadowImage = [[UIImage alloc]init];
    
    MTToolTaskController *taskVC = [[MTToolTaskController alloc] init];
    
    
    MTToolUnFinishController *workoutVC = [[MTToolUnFinishController alloc] init];
    
    MTToolHistoryController *historyVC = [[MTToolHistoryController alloc] init];
    BaseNavViewController * priceNav  =[[BaseNavViewController alloc]initWithRootViewController:taskVC];
    [self addChildVC:priceNav title:@"任务" image:@"user" selectedImage:@"user"];
    BaseNavViewController * costNav  =[[BaseNavViewController alloc]initWithRootViewController:workoutVC];
    [self addChildVC:costNav title:@"未完成" image:@"unfinishList" selectedImage:@"unfinishList"];
    BaseNavViewController * histroyNav  =[[BaseNavViewController alloc]initWithRootViewController:historyVC];
    [self addChildVC:histroyNav title:@"历史" image:@"history" selectedImage:@"history"];
    
    
   
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
