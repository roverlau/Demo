//
//  ImageModel.h
//  Car
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@protocol ImageModel <NSObject>


@end

@interface ImageModel : JSONModel

@property (nonatomic,copy) NSString *car_position;// "车身",
@property (nonatomic,copy) NSString *title;//" : "科雷傲",
@property (nonatomic,copy) NSString *url;//" : "http://cdn.carguide.com.cn/o_19t7o82c787v1v941r7obl215md1r.jpg?imageView2/0/w/800/q/100"


@end
