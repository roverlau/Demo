//
//  NameModel.m
//  Car
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NameModel.h"

@implementation NameModel

-(NSMutableArray *)nameArr
{
    if (_nameArr == nil) {
        _nameArr = [NSMutableArray new];
    }
    return _nameArr;
}
@end
