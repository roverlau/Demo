//
//  HeaderView.m
//  Car
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyHeaderView.h"

@implementation MyHeaderView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, 270)];

        _img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenWidth, 200)];
        [_v addSubview:_img];
        [self addSubview:_v];
        
        _lb1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 205, 200, 25)];
        [_v addSubview:_lb1];
        
        _lb2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 235, 70, 25)];
        _lb2.text = @"厂家指导价:";
        _lb2.font = [UIFont systemFontOfSize:13];
        _lb2.textColor = [UIColor redColor];
        [_v addSubview:_lb2];
        
        _lb3 = [[UILabel alloc]initWithFrame:CGRectMake(75, 235, 150, 25)];
        [_v addSubview:_lb3];
        _lb3.textColor = [UIColor redColor];
        _lb3.font = [UIFont systemFontOfSize:13];
       
        _lb4 = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth-70, 160, 65, 30)];
        [_img addSubview:_lb4];
        _lb4.font = [UIFont systemFontOfSize:15];
        _lb4.textColor = [UIColor whiteColor];
        
    }
    return self;
}


@end
