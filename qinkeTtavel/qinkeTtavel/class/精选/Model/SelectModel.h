//
//  SelectModel.h
//  qinkeTtavel
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "authorModel.h"

@interface SelectModel : NSObject

@property (nonatomic , copy) NSArray *collections;

@property (nonatomic , copy) NSString *type;

@property (nonatomic , copy) NSNumber *goodId;

@property (nonatomic , copy) NSString *title;

@property (nonatomic , copy) NSString *sub_title;

@property (nonatomic , retain) NSArray *bg_pic;

@property (nonatomic , copy) NSNumber *like_count;

@property (nonatomic , copy) NSString *short_desc;

@property (nonatomic , copy) NSString *destination;

@property (nonatomic , retain)  authorModel *referrer;

@end
