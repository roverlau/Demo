//
//  NewsCell.m
//  汽车导购
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"

@implementation NewsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //各种控件初始化
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(86, 2, [UIScreen mainScreen].bounds.size.width - 90, 50)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(2 , 4, 80, 70)];
    
        [self.contentView addSubview:_imgView];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(250, 60, 15, 15)];
        [imageV setImage:[UIImage imageNamed:@"btn_talk"]];
        [self.contentView addSubview:imageV];
        
        _commentNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 55, 30, 20)];
        [self.contentView addSubview:_commentNumLabel];
        _commentNumLabel.font = [UIFont systemFontOfSize:12];
        _commentNumLabel.textColor = [UIColor grayColor];
        
        _dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(86, 55, 100, 20)];
        _dataLabel.font = [UIFont systemFontOfSize:12];
        _dataLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_dataLabel];
        
    }
    return self;

}


-(void)refreshUI:(NewsModel *)model
{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cover_url]]];
    _commentNumLabel.text = model.comment_nums;
    _titleLabel.text = model.title;
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:[model.instime doubleValue] ];
    NSString *str = [NSString stringWithFormat:@"%@",d];
    NSArray *arr = [str componentsSeparatedByString:@" "];
    _dataLabel.text = [NSString stringWithFormat:@"%@",arr[0]];
}


- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
