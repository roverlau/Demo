//
//  ZTModel.m
//  礼物说
//
//  Created by RoverLau on 15/10/28.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "ZTModel.h"

@implementation ZTModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"myId"];
    }
    
}

-(void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues{
    for (NSString *value in keyedValues) {
        [self setValue:keyedValues[value] forKey:value];
    }
}

-(void)setValue:(id)value forKey:(NSString *)key{
    //判断是否为NSNumber类型
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue: [NSString stringWithFormat:@"%@",value] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}

@end
