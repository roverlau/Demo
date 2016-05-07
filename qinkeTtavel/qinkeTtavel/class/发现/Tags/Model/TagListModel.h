//
//  TagListModel.h
//  qinkeTtavel
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "TagListSonModel.h"

@interface TagListModel : NSObject

@property (nonatomic , assign) NSNumber *goodId;

@property (nonatomic , copy) NSString *title;

@property (nonatomic , copy) NSString *sub_title;

@property (nonatomic , retain) NSArray *bg_pic;

@property (nonatomic , copy) NSString *bg_video;

@property (nonatomic , copy) NSString *destination;

@property (nonatomic , copy) NSString *start_date;

@property (nonatomic , copy) NSString *end_date;

@property (nonatomic , assign) NSNumber *like_count;

@property (nonatomic , retain) NSArray *collections;

@end
