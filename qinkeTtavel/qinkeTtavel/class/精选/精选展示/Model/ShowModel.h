//
//  ShowModel.h
//  qinkeTtavel
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface ShowModel : NSObject


@property (nonatomic , copy) NSString *title;

@property (nonatomic , copy) NSString *sub_title;

@property (nonatomic , copy) NSNumber *like_count;

@property (nonatomic , copy) NSString *address;

@property (nonatomic , retain) NSArray *details;

@property (nonatomic , retain) NSArray *like_user;

@property (nonatomic , retain) NSString *destination;

@property (nonatomic , retain) NSArray *bg_pic;

@end
