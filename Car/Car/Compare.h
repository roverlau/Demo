//
//  Compare.h
//  Car
//
//  Created by qianfeng on 15/11/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Compare : NSObject

+(id)shareInstance;
@property (strong, nonatomic) NSMutableArray * compareArr;

@property (assign,nonatomic)BOOL flag;

@end
