//
//  AppDelegate.m
//  猿生活
//
//  Created by RoverLau on 15/11/4.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "AppDelegate.h"
#import "MessageViewController.h"
#import "ShopViewController.h"
#import "CateViewController.h"
#import "BeauViewController.h"
#import "MicViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    MessageViewController *ctl1 = [MessageViewController new];
    ctl1.view.backgroundColor = [UIColor blueColor];
    ctl1.title = @"资讯";
    ShopViewController *ctl3 = [ShopViewController new];
    ctl3.view.backgroundColor = [UIColor orangeColor];
    ctl3.title = @"拾货";
    BeauViewController *ctl4 = [BeauViewController new];
    ctl4.view.backgroundColor = [UIColor yellowColor];
    ctl4.title = @"美女";
    CateViewController *ctl5 = [CateViewController new];
    ctl5.view.backgroundColor = [UIColor greenColor];
    ctl5.title = @"频道";
    MicViewController *ctl2 = [MicViewController new];
    ctl2.title = @"微软";
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:ctl1];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:ctl2];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:ctl3];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:ctl4];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:ctl5];
    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"micsoft"];
    nav2.tabBarItem.image = [UIImage imageNamed:@"mic2"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"micsoft"];
    nav3.tabBarItem.image = [UIImage imageNamed:@"mic2"];
    nav4.tabBarItem.selectedImage = [UIImage imageNamed:@"micsoft"];
    nav4.tabBarItem.image = [UIImage imageNamed:@"mic2"];
    nav5.tabBarItem.selectedImage = [UIImage imageNamed:@"micsoft"];
    nav5.tabBarItem.image = [UIImage imageNamed:@"mic2"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"micsoft"];
    nav1.tabBarItem.image = [UIImage imageNamed:@"mic2"];
    UITabBarController *tab = [UITabBarController new];
    tab.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    
    tab.hidesBottomBarWhenPushed = YES;
    self.window.rootViewController = tab;
    self.window.backgroundColor = [UIColor whiteColor];
    
    [UMSocialData setAppKey:@"5636c18467e58e18e0000796"];
    [UMSocialQQHandler setQQWithAppId:@"wx507fcab25270157b37000010" appKey:@"5636c18467e58e18e0000796" url:nil];
    
    [self.window makeKeyAndVisible];
    return YES;
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
