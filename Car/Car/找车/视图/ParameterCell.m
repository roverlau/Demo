//
//  ParameterCell.m
//  Car
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ParameterCell.h"

@implementation ParameterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,170, 40)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_nameLabel];
        
        _paremeterLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.frame.size.width, 0, KMainScreenWidth-_nameLabel.frame.size.width, 40)];
        _paremeterLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView  addSubview:_paremeterLabel];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
