//
//  HeaderView.m
//  汽车导购
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

-(void)awakeFromNib
{
    [_handAction addTarget:self action:@selector(hand) forControlEvents:UIControlEventTouchUpInside];

}


-(void)hand
{


}
@end
