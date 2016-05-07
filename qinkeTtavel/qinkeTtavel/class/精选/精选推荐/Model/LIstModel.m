//
//  LIstModel.m
//  qinkeTtavel
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LIstModel.h"
#import "ListSonModel.h"

@implementation LIstModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"recomms" : ListSonModel.class};
}


@end
