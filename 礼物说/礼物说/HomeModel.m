//
//  HomeModel.m
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //   NSLog(@"%@-------%@",key,value);
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
