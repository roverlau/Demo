//
//  CarCatBrandModel.m
//  Car
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CarCatBrandModel.h"

@implementation CarCatBrandModel

-(NSMutableArray *)myBrandArr
{
    if (_myBrandArr) {
        _myBrandArr = [[NSMutableArray alloc]init];
    }
    return _myBrandArr;
}

@end
