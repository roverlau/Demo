//
//  FLCollectionViewCell.m
//  礼物说
//
//  Created by RoverLau on 15/10/29.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "FLCollectionViewCell.h"
#import "PrefixHeader.pch"

@interface FLCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation FLCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)refreshUI:(ItemModel *)model{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.icon_url]];
    self.name.text = model.name;
}

@end
