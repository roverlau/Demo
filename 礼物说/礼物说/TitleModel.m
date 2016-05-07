//
//  TitleModel.m
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "TitleModel.h"

@implementation TitleModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //   NSLog(@"%@-------%@",key,value);
}

-(void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues{
    for (NSString *value in keyedValues) {
        [self setValue:keyedValues[value] forKey:value];
    }
}

@end
