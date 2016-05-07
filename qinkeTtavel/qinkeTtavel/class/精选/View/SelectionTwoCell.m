//
//  SelectionTwoCell.m
//  qinkeTtavel
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SelectionTwoCell.h"
#import "authorModel.h"
#import "UIImage+ZQCorp.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface SelectionTwoCell ()<SDWebImageManagerDelegate>

@property (nonatomic , retain) UIImageView *headImageV;

@property (nonatomic , retain) UILabel *nameLabel;

@property (nonatomic , retain) UILabel *introLabel;

@property (nonatomic , retain) UIImageView *bgImageV;

@property (nonatomic , retain) UILabel *descLabel;

@property (nonatomic , retain) UIImageView *likeImageV;

@property (nonatomic , retain) UILabel *likeLabel;

@property (nonatomic , retain) UIImageView *destImageV;

@property (nonatomic , retain) UILabel *destLabel; //位置

@property (nonatomic , retain) UILabel *titleLabel;

@property (nonatomic , retain) UILabel *subTitleLabel;

@end

@implementation SelectionTwoCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    
        _headImageV = [[UIImageView alloc]init];
        _headImageV.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_headImageV];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_nameLabel];
        
        _introLabel = [[UILabel alloc]init];
        _introLabel.textColor = [UIColor grayColor];
        _introLabel.font = [UIFont systemFontOfSize:11];
        _introLabel.backgroundColor = [UIColor whiteColor];
        _introLabel.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_introLabel];
        
        _bgImageV = [[UIImageView alloc]init];
        _bgImageV.backgroundColor = [UIColor whiteColor];
        _bgImageV.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageV.clipsToBounds = YES;
        
        [self.contentView addSubview:_bgImageV];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_bgImageV addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.textColor = [UIColor whiteColor];
        _subTitleLabel.layer.masksToBounds = YES;
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        
        [_bgImageV addSubview:_subTitleLabel];
        
        
        _descLabel = [[UILabel alloc]init];
        _descLabel.numberOfLines = 0;
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.backgroundColor = [UIColor whiteColor];
        _descLabel.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_descLabel];
        
        _likeImageV = [[UIImageView alloc]init];
        _likeImageV.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_likeImageV];
        
        _likeLabel = [[UILabel alloc]init];
        _likeLabel.font = [UIFont systemFontOfSize:13];
        _likeLabel.layer.masksToBounds = YES;
        _likeLabel.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_likeLabel];
        
        _destImageV = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_destImageV];
        
        
        _destLabel = [[UILabel alloc]init];
        _destLabel.font = [UIFont systemFontOfSize:13];
        _destLabel.backgroundColor = [UIColor whiteColor];
        _destLabel.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_destLabel];
        
        [self addMason];
        
    }
    return self;
}

#pragma mark -- 更新约束
-(void)addMason
{
//    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    [_headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.contentView).offset(10);
        make.top.mas_equalTo(self.contentView).offset(10);
        
        make.width.and.height.mas_equalTo(@40);
        
    }];
    
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageV);
        make.left.mas_equalTo(_headImageV.mas_right).offset(5);
        make.height.mas_equalTo(@20);
    }];
    
    [_introLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom);
        make.left.mas_equalTo(_nameLabel);
        make.right.mas_equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(_nameLabel);
    }];
    
    [_bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageV.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@250);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bgImageV).offset(200);
        make.left.mas_equalTo(_bgImageV).offset(15);
        make.height.mas_equalTo(@30);
        
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom);
        make.bottom.mas_equalTo(_bgImageV).offset(-10);
        make.left.mas_equalTo(_titleLabel);
    }];
    
    [_descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bgImageV.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
    }];
    
    [_destLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(_descLabel);
        make.height.mas_equalTo(@22);
    }];
    
    [_destImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(_destLabel.mas_left);
        make.width.and.height.mas_equalTo(@12);
    }];
    
    [_likeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(_destImageV.mas_left);
        make.height.mas_equalTo(@22);

    }];
    
    [_likeImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_descLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(_likeLabel.mas_left);
        make.width.and.height.mas_equalTo(@22);
    }];
}


#pragma mark -- 更新数据
-(void)setModel:(SelectModel *)model
{
    if (_model != model) {
        _model = model;
        
        [self updateData];
    }
}

-(void)updateData
{
    authorModel *auModel = (authorModel *)_model.referrer;
    
    [_headImageV sd_setImageWithURL:[NSURL URLWithString:auModel.photo_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        _headImageV.image = [image zq_cropCornerRadius:image.size.width/2];
    }];
    
    _nameLabel.text = auModel.username;
    
    _introLabel.text = auModel.intro;
    
//    NSString *pathDefault = [[NSBundle mainBundle] pathForResource:@"supplier_default" ofType:@"png"];
//    [_bgImageV sd_setImageWithURL:[NSURL URLWithString:_model.bg_pic[0]] placeholderImage:[UIImage imageWithContentsOfFile:pathDefault]];
    
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    manager.imageDownloader
    manager.delegate = self;
//
    [manager downloadImageWithURL:_model.bg_pic[0] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        _bgImageV.image = [image zq_cropEqyalScaleImageToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 250)];
//        NSLog(@"%@ -- %@",image,image1);
    }];
    
    
//
    

   
    
    _titleLabel.text = _model.title;
    _subTitleLabel.text = _model.sub_title;
    
    _likeLabel.text = [NSString stringWithFormat:@"%@",_model.like_count];
    _destLabel.text = _model.destination;
    
    _descLabel.text = _model.short_desc;
    
    _likeImageV.image = [UIImage imageNamed:@"activity_btnLike"];
    
    _destImageV.image = [[UIImage imageNamed:@"activity_location"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL
{
    image = [image zq_cropEqyalScaleImageToSize:_bgImageV.bounds.size];
    
    return image;
}

#pragma mark -- 返回cell高度的方法

+(float)heightWithModel:(SelectModel *)model
{
    SelectionTwoCell *cell = [[SelectionTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectionTwoCell"];
    
    cell.model = model;
    
    [cell layoutIfNeeded];
    
    CGRect frame = cell.likeImageV.frame;
    
    return frame.origin.y + frame.size.height;
}

@end
