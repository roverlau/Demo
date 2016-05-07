//
//  MyView.m
//  qinkeTtavel
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MyView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *contant;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation MyView

-(void)initUI:(NSString *)url :(NSString *)title :(NSString *)name{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:url]];
    self.contant.text = name;
    self.contant.numberOfLines = 0;
    self.name.text = title;
    self.name.numberOfLines = 0;
    [self.imgView .layer setCornerRadius:8];
    self.imgView .layer.shouldRasterize = YES;
    self.imgView .layer.rasterizationScale=[UIScreen mainScreen].scale;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
