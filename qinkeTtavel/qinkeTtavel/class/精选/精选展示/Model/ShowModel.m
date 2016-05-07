//
//  ShowModel.m
//  qinkeTtavel
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShowModel.h"
#import "ShowSonModel.h"

@implementation ShowModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"details" : ShowSonModel.class};
}

@end
