//
//  NZYTabBarController.h
//  自定义tabBar
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZYTabBarController : UITabBarController

@property (nonatomic,copy) NSArray *selectedArr;
@property (nonatomic,copy) NSArray *unSelecteArr;
@property (nonatomic,copy) NSArray *titleArr;

@end
