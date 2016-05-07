//
//  CommandCell.m
//  Car
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommandCell.h"
#import "UIImageView+WebCache.h"

@implementation CommandCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 5, 150, 25)];
        [self.contentView addSubview:_nameLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
        _imgView.layer.cornerRadius = 3;
        [self.contentView addSubview:_imgView];
        
        _metaLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 35, KMainScreenWidth-90, 35)];
        _metaLabel.numberOfLines = 0;
        _metaLabel.textColor = [UIColor grayColor];
        _metaLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_metaLabel];
        
        _downLoadButton = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-50, 10, 25, 25)];
        [_downLoadButton setImage:[UIImage imageNamed:@"btn_download"] forState:UIControlStateNormal];
        [self.contentView addSubview:_downLoadButton];
        
    }
    return self;
}


-(void)refreshUI:(CommandModel *)model
{
    _nameLabel.text = model.app_name;
    _metaLabel.text = model.app_meta;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.app_icon]]];
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
