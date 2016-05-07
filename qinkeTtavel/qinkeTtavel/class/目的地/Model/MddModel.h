//
//  MddModel.h
//  qinkeTtavel
//
//  Created by admin on 16/4/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface MddModel : NSObject

@property(nonatomic)NSString * bg_pic;
@property(nonatomic)NSString * desc;
@property(nonatomic)NSString * name;
@property(nonatomic)NSString * type;
@property(nonatomic)NSNumber * bg_color;
@property(nonatomic)NSNumber * ID;

+(NSDictionary*)modelCustomPropertyMapper;
@end
