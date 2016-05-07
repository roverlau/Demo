//
//  NewsTitleModel.m
//  汽车导购
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsTitleModel.h"

@implementation NewsTitleModel

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
        
    }else{
        [super setValue:value forKey:key];
    }

}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"myId"];
    }
    
}

@end
