//
//  QuestionCell.m
//  汽车导购
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "QuestionCell.h"
#import "UIImageView+WebCache.h"

@implementation QuestionCell

- (void)awakeFromNib {
    self.commentLabel.numberOfLines = 0;
    
    self.headerImageView.layer.cornerRadius = 15;
    self.headerImageView.clipsToBounds = YES;
    
    self.yellowImageView.backgroundColor = [UIColor yellowColor];
    self.yellowImageView.layer.cornerRadius = 8;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshUI:(QuestionModel *)model
{
     //评论label自动折行
    //self.commentLabel.numberOfLines = 0;
    
    self.commentLabel.text = model.title;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.member_img]];
    self.nameLabel.text = model.member_name;
    NSString *str = model.ins_time;
    NSArray *arr = [str componentsSeparatedByString:@" "];
    
    self.timeLabel.text = arr[0];
    
   }
                       
-(void)refreshQuestionUI:(QuestionModel *)model
{
    self.commentLabel.text = model.title;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.member_img]];
    self.nameLabel.text = model.member_name;
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:[model.ins_time doubleValue] ];
    NSString *str = [NSString stringWithFormat:@"%@",d];
    NSArray *arr = [str componentsSeparatedByString:@" "];
     _timeLabel.text = [NSString stringWithFormat:@"%@",arr[0]];
    
}


@end
