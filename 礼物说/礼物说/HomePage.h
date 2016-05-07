//
//  HomePage.h
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePage : UIView
@property (nonatomic,strong) NSMutableArray *imgUrlArr;

//实例化视图
+(instancetype)circleViewFrame:(CGRect)frame;

-(void)openTimer;
@end
