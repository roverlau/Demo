//
//  TopSelectCell.m
//  qinkeTtavel
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TopSelectCell.h"
#import "TopSelectSonModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@interface TopSelectCell ()

@property (nonatomic , retain) UIImageView *imageV;

@property (nonatomic , retain) UILabel *titleLabel;

@property (nonatomic , retain) UILabel *subTitleLabel;

@end

@implementation TopSelectCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imageV = [[UIImageView alloc]init];
        _imageV.backgroundColor = [UIColor whiteColor];
        _imageV.layer.cornerRadius = 5;
        _imageV.layer.masksToBounds = YES;
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_imageV];
        
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.font = [UIFont systemFontOfSize:13];
        _subTitleLabel.numberOfLines = 2;
        _subTitleLabel.layer.masksToBounds = YES;
        _subTitleLabel.textColor = [UIColor blackColor];
        _subTitleLabel.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_subTitleLabel];
        
        [self addMasory];
        
    }
    return self;
}

-(void)addMasory
{
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(120);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(_imageV.mas_right).offset(10);
        make.height.mas_equalTo(20);
        
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(_titleLabel);
        make.right.mas_equalTo(-15);
        
    }];
}

-(void)setTopModel:(TopSelectModel *)topModel
{
    if (_topModel != topModel) {
        _topModel = topModel;
        
        TopSelectSonModel *model = _topModel.selection;
        
        [self loadData:model];
    }
}

-(void)loadData:(TopSelectSonModel *)model
{
     SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:model.bg_pic] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
       
        _imageV.image = image;
    }];
    
    NSString *title = [NSString stringWithFormat:@"%@%@的小伙伴浏览了",_topModel.hotness,@"%"];
    
    NSMutableAttributedString *attrtitle = [[NSMutableAttributedString alloc]initWithString:title];
    
    NSRange range = [title rangeOfString:[NSString stringWithFormat:@"%@",_topModel.hotness]];
    [attrtitle addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
    
    _titleLabel.attributedText = attrtitle;
    
    NSString *subTitle = [NSString stringWithFormat:@"%@ -%@",model.title,model.sub_title];
    _subTitleLabel.text = subTitle;
    
}

@end
