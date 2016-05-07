//
//  ListSonModel.h
//  qinkeTtavel
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface ListSonModel : NSObject

@property (nonatomic , assign) NSNumber *goodId;

@property (nonatomic , copy) NSString *title;

@property (nonatomic , copy) NSString *sub_title;

@property (nonatomic , retain) NSArray *bg_pic;

@property (nonatomic , copy) NSString *start_date;

@property (nonatomic , copy) NSString *end_date;

@property (nonatomic , copy) NSString *destination;

@property (nonatomic , copy) NSString *short_desc;

@end
