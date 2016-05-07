//
//  CarCell.m
//  Car
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CarCell.h"

@implementation CarCell

- (void)awakeFromNib {
   
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 7, 200, 35)];
    [self.contentView addSubview:_nameLabel];
    
    _imgButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 60, 40)];
        [_imgButton setBackgroundImage:[UIImage imageNamed:@"load_albumcover_750"] forState:UIControlStateNormal];
    [self.contentView addSubview:_imgButton];

    }
    return self;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
