//
//  HotModel.h
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotModel : NSObject

@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * cover_image_url;
@property(nonatomic,copy)NSString * favorites_count;
@property(nonatomic,copy)NSString * price;

@end
