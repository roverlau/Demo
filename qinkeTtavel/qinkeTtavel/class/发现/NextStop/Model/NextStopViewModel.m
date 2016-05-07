//
//  NextStopViewModel.m
//  qinkeTtavel
//
//  Created by ZQ on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NextStopViewModel.h"
#import "NextBodyModel.h"

@implementation NextStopViewModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"body" : NextBodyModel.class};
}

@end
