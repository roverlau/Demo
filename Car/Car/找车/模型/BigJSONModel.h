//
//  BigJSONModel.h
//  Car
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"
#import "CarTypeModel.h"
#import "ImageModel.h"
@interface BigJSONModel : JSONModel
@property (nonatomic,copy) NSString <Optional>* img_count;
@property (nonatomic,copy) NSString <Optional>* topimg;
@property (nonatomic,copy) NSString <Optional>* topimg_title;

@property (nonatomic,strong) NSMutableArray<CarTypeModel> * carlist;
@property (nonatomic,strong) NSMutableArray<ImageModel>* img_list;
@end
