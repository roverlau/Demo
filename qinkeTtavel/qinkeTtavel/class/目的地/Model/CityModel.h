//
//  CityModel.h
//  qinkeTtavel
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface CityModel : NSObject



@property(nonatomic)NSString * bg_pic;
@property(nonatomic)NSString * name;
@property(nonatomic)NSString * bg_video;
@property(nonatomic)NSString * destination;
@property(nonatomic)NSString * end_date;
@property(nonatomic)NSNumber * is_liked;
@property(nonatomic)NSNumber * bg_color;
@property(nonatomic)NSNumber * ID;
@property(nonatomic)NSNumber * is_count;
@property(nonatomic)NSString * price;
@property(nonatomic)NSString * share_url;
@property(nonatomic)NSString * short_desc;
@property(nonatomic)NSString * start_date;
@property(nonatomic)NSString * sub_title;
@property(nonatomic)NSString * title;


+(NSDictionary*)modelCustomPropertyMapper;
@end
