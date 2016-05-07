//
//  DetailCarCell.m
//  Car
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailCarCell.h"

@implementation DetailCarCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, KMainScreenWidth-50, 30)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nameLabel];
          _btn = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-40, 2, 30, 30)];
        [_btn setImage:[UIImage imageNamed:@"btn_contrast_nor"] forState:UIControlStateNormal];
        
        
//        [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn];
    }
    return self;
}

//-(void)click
//{
//    [_btn setImage:[UIImage imageNamed:@"btn_added_nor"] forState:UIControlStateNormal];
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
