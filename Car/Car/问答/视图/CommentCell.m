//
//  CommentCell.m
//  Car
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"

@implementation CommentCell

- (void)awakeFromNib {
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 50, 50)];
        _headerImageView.layer.cornerRadius = 25;
        _headerImageView.clipsToBounds = YES;
        [self.contentView addSubview:_headerImageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 150, 25)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_nameLabel];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 33, KMainScreenWidth-95, 30)];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_contentLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 65,150, 20)];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_timeLabel];
        
        _zanLabel = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth-50, 5, 25, 20)];
        _zanLabel.textColor = [UIColor grayColor];
        _zanLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_zanLabel];
        
        _zanBtn = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-25, 5, 20, 20)];
        [_zanBtn setBackgroundImage:[UIImage imageNamed:@"thumbs_up_pre"] forState:UIControlStateNormal];
        [self.contentView addSubview:_zanBtn];
    }
    return self;

}

-(void)refreshUI:(CommentModel *)model
{
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.member_icon]];
    _nameLabel.text = model.nickname;
    _contentLabel.text = model.content;
    _zanLabel.text = model.zan_nums;
    
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:[model.instime doubleValue] ];
    NSString *str = [NSString stringWithFormat:@"%@",d];
    NSArray *arr = [str componentsSeparatedByString:@" "];
    _timeLabel.text = [NSString stringWithFormat:@"%@",arr[0]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
