//
//  TagListModel.m
//  qinkeTtavel
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TagListModel.h"
#import "TagListSonModel.h"

@implementation TagListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goodId":@"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"collections" : TagListSonModel.class};
}

@end
