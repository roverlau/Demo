//
//  NZYTabBarButton.m
//  自定义tabBar
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NZYTabBarButton.h"

@implementation NZYTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化tabBarButton
        self.tabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tabBarButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-8);
        [self addSubview:_tabBarButton];
        
        self.tabBarButtonTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-12, frame.size.width, 10)];
        self.tabBarButtonTitle.font = [UIFont systemFontOfSize:14];
        self.tabBarButtonTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tabBarButtonTitle];
    }
    return self;
}


@end
