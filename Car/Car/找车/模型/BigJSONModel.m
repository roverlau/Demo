//
//  BigJSONModel.m
//  Car
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BigJSONModel.h"

@implementation BigJSONModel

-(NSMutableArray *)carlist
{
    if (_carlist == nil) {
        _carlist = [[NSMutableArray alloc]init];
    }
    return _carlist;
}

-(NSMutableArray *)img_list
{
    if (_img_list == nil) {
        _img_list = [[NSMutableArray alloc]init];
    }
    return _img_list;
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }

}
@end
