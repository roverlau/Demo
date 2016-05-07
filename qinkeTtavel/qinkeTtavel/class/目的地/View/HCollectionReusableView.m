//
//  HCollectionReusableView.m
//  qinkeTtavel
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HCollectionReusableView.h"

#import <SDWebImage/UIImageView+WebCache.h>


@interface HCollectionReusableView ()


@end
@implementation HCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)initUI:(NSString *)url name:(NSString *)desc{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:url]];
    self.name.text = desc;
    self.name.numberOfLines = 0;
    [self.imgView .layer setCornerRadius:5];
    self.imgView .layer.shouldRasterize = YES;
    self.imgView .layer.rasterizationScale=[UIScreen mainScreen].scale;
}
@end
