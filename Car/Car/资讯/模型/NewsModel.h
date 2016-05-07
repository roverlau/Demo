//
//  NewsModel.h
//  Car
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface NewsModel : JSONModel


@property (nonatomic,copy) NSString * cover_url;

//@property (nonatomic,assign) NSInteger  instime;

@property (nonatomic,copy) NSString * instime;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * comment_nums;

@property (nonatomic,copy) NSString * myId;



@end
