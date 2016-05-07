//
//  Compare.m
//  Car
//
//  Created by qianfeng on 15/11/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Compare.h"

@implementation Compare

+(id)shareInstance
{
    static Compare *simple = nil;
    if (simple == nil) {
        simple = [[Compare alloc]init];
    }
    return simple;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _compareArr = [NSMutableArray array];
    }
    return self;
}

@end
