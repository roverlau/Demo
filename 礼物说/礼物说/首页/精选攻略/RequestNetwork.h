//
//  RequestNetwork.h
//  礼物说
//
//  Created by RoverLau on 15/10/28.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "HomePage.h"
#import "SroModel.h"
#import "TitleModel.h"
#import "HomeModel.h"
#import "BeauTableViewController.h"
#import "PrefixHeader.pch"

@interface RequestNetwork : NSObject

@property (nonatomic,strong)ViewController *vc;

+(void)requestHome:(ViewController*)vc :(NSInteger)page;
+(void)requestNet:(ViewController*)vc;
+(void)requestBeau:(BeauTableViewController*)vc :(NSInteger)page;
+(void)push;
@end
