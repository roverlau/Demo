//
//  SelectModel.m
//  qinkeTtavel
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SelectModel.h"
#import "SonModelOne.h"


@implementation SelectModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodId":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"collections" : SonModelOne.class};
}

@end
