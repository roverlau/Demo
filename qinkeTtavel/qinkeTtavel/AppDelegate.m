//
//  AppDelegate.m
//  qinkeTtavel
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createTabbar];
    });
    
    _mapManager = [[BMKMapManager alloc]init];
    
    BOOL ret = [_mapManager start:@"cAGGn22TCSIRpY6dmS5WflEazG2mZxPG" generalDelegate:nil];
    
    if (!ret) {
        NSLog(@"百度地图登录失败");
    }
    
    return YES;
}

-(void)createTabbar
{
    NSArray *array = @[@"SelectionController",@"FoundController",@"BournController"];
    NSArray *classNameArray = @[@"tabbar_item_home",@"tabbar_item_discover",@"tabbar_item_des"];
    NSArray *titleNameArray = @[@"精选",@"发现",@"目的地"];
    
    NSMutableArray *classArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < array.count; i++) {
        Class viewControllerClass = NSClassFromString(array[i]);
        UIViewController *vc = [[viewControllerClass alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
        
        NSString *imageSel = [NSString stringWithFormat:@"%@_sel",classNameArray[i]];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleNameArray[i] image:[[UIImage imageNamed:classNameArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:imageSel] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
        
        if (i == 0) {
            navi.navigationBar.hidden = YES;
        }
        
        [classArray addObject:navi];
        
    }
    
    UITabBarController *barController = [[UITabBarController alloc]init];
    barController.viewControllers = classArray;
    
    //    [UIApplication sharedApplication].keyWindow.rootViewController = barController;
    //
    //    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    
//    AppDelegate *app = [[AppDelegate alloc]init];
    self.window.rootViewController = barController;
    
//    [self.window makeKeyAndVisible];
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
