//
//  AppDelegate.m
//  Car
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsViewController.h"
#import "QuestionViewController.h"
#import "FindCarViewController.h"
#import "ActivityViewController.h"
#import "AboutMeViewController.h"
#import "NZYTabBarController.h"
#import "UMSocial.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
      
    [UMSocialData setAppKey:@"5636c874e0f55a4935001751"];
    
     [self creatTabbarController];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)creatTabbarController
{
    NewsViewController *newsCtl = [[NewsViewController alloc]init];
    QuestionViewController *questionCtl = [[QuestionViewController alloc]init];
    FindCarViewController *findCarCtl = [[FindCarViewController alloc]init];
    ActivityViewController *activityCtl = [[ActivityViewController alloc]init];
    AboutMeViewController *aboutMeCtl = [[AboutMeViewController alloc]init];
    
    NZYTabBarController *ctl = [[NZYTabBarController alloc]init];
    ctl.titleArr = @[@"资讯",@"问答",@"找车",@"活动",@"我"];
    ctl.unSelecteArr = @[@"tab_Information",@"tab_QA",@"tab_car",@"tab_activity",@"tab_preson"];
    ctl.selectedArr = @[@"tab_Information_pre",@"tab_QA_pre",@"tab_car_pre",@"tab_activity_pre",@"tab_preson_pre"];
    ctl.viewControllers = @[newsCtl,questionCtl,findCarCtl,activityCtl,aboutMeCtl];
    self.window.rootViewController = ctl;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
