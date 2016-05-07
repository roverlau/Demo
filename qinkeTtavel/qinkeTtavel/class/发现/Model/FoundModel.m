//
//  FoundModel.m
//  qinkeTtavel
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FoundModel.h"
#import "articleModel.h"
#import "TopSelectModel.h"
#import "NextTopModel.h"
#import "CollectionModel.h"
#import "TagModel.h"


@implementation FoundModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"articles" : articleModel.class,
             @"top_selections" : TopSelectModel.class,
             @"next_stops" : NextTopModel.class,
             @"collections" : CollectionModel.class,
             @"tags" : TagModel.class};
}

@end
