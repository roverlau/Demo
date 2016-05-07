//
//  TwoParameterCell.m
//  Car
//
//  Created by qianfeng on 15/11/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TwoParameterCell.h"

@implementation TwoParameterCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, self.contentView.frame.size.height)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    
        _titleLabel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_titleLabel];
        
        _oneCarLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, (KMainScreenWidth-100)/2, self.contentView.frame.size.height)];
        _oneCarLabel.textAlignment = NSTextAlignmentCenter;
        _oneCarLabel.font = [UIFont systemFontOfSize:15];

        [self.contentView addSubview:_oneCarLabel];
        UIView *v= [[UIView alloc]initWithFrame:CGRectMake(100+(KMainScreenWidth-100)/2+1, 0, 0.4, self.contentView.frame.size.height)];
        v.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:v];
        
        _twoCarLabel = [[UILabel alloc]initWithFrame:CGRectMake(100+(KMainScreenWidth-100)/2+1, 0, (KMainScreenWidth-100)/2-1, self.contentView.frame.size.height)];
        _twoCarLabel.textAlignment = NSTextAlignmentCenter;
        _twoCarLabel.font = [UIFont systemFontOfSize:15];
    
        [self.contentView addSubview:_twoCarLabel];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
