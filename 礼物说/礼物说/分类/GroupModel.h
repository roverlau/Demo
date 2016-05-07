//
//  GroupModel.h
//  礼物说
//
//  Created by RoverLau on 15/10/29.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,strong)NSMutableArray *kinds;

@end
