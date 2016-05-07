//
//  BigCollectionViewCell.m
//  Car
//
//  Created by qianfeng on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BigCollectionViewCell.h"

@implementation BigCollectionViewCell

-(void)setBigView:(UIView *)bigView
{
    _bigView = bigView;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    [self.contentView addSubview:bigView];
}
@end
