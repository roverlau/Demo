//
//  ItemModel.h
//  礼物说
//
//  Created by RoverLau on 15/10/29.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic,copy)NSString* icon_url;
@property (nonatomic,copy)NSString* name;
@property (nonatomic,copy)NSString* items_count;
@property (nonatomic,copy)NSString* group_id;
@property (nonatomic,copy)NSString* myId;
@property (nonatomic,copy)NSString* order;

@end
