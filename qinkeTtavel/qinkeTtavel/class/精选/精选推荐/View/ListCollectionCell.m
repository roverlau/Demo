//
//  ListCollectionCell.m
//  qinkeTtavel
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ListCollectionCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+ZQCorp.h"

@interface ListCollectionCell ()

@property (nonatomic , retain) UIImageView *backImage;

@property (nonatomic , retain) UIImageView *bgImageView;

@property (nonatomic , retain) UILabel *titleLabel;

@property (nonatomic , retain) UILabel  *subTitleLabel;

@property (nonatomic , retain) UIImageView *addressImageV;

@property (nonatomic , retain) UILabel *addressLabel;

@property (nonatomic , retain) UIImageView *timeImageV;

@property (nonatomic , retain) UILabel *timeLabel;

@property (nonatomic , retain) UILabel *descLabel;

@end


@implementation ListCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        _backImage = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
//        _backImage.image = [[UIImage imageNamed:@"activity_Tit"]zq_cropEqyalScaleImageToSize:self.contentView.bounds.size];
//        [self.contentView addSubview:_backImage];
        self.contentView.backgroundColor = [UIColor whiteColor];
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.backgroundColor = [UIColor whiteColor];
//        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_bgImageView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_bgImageView addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.textColor = [UIColor whiteColor];
        _subTitleLabel.layer.masksToBounds = YES;
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        
        [_bgImageView addSubview:_subTitleLabel];
        
        _addressImageV  = [[UIImageView alloc]init];
        _addressImageV.image = [UIImage imageNamed:@"activity_location"];
        [_bgImageView addSubview:_addressImageV];
        
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = [UIColor whiteColor];
        _addressLabel.layer.masksToBounds = YES;
        _addressLabel.font = [UIFont systemFontOfSize:11];
        
        [_bgImageView addSubview:_addressLabel];
        
        _timeImageV = [[UIImageView alloc]init];
        _timeImageV.image = [UIImage imageNamed:@"activity_time"];
        _timeImageV.layer.masksToBounds = YES;
        
        [_bgImageView addSubview:_timeImageV];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.layer.masksToBounds = YES;
        _timeLabel.font = [UIFont systemFontOfSize:11];
        
        [_bgImageView addSubview:_timeLabel];
        
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.numberOfLines = 0;
        _descLabel.layer.masksToBounds = YES;
        _descLabel.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_descLabel];
        
        
         [self addMasonry];
    }
    return self;
}

-(void)addMasonry
{
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(@200);
        
    }];
    
    
    [_addressImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_bgImageView).offset(-5);
        make.left.mas_equalTo(_bgImageView).offset(15);
        make.width.height.mas_equalTo(11);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(_addressImageV);
        make.left.mas_equalTo(_addressImageV.mas_right).offset(5);
        make.height.mas_equalTo(11);
        
    }];
    
    [_timeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(_addressLabel);
        make.left.mas_equalTo(_addressLabel.mas_right).offset(5);
        make.width.height.mas_equalTo(11);
        
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(_timeImageV);
        make.left.mas_equalTo(_timeImageV.mas_right).offset(5);
        make.height.mas_equalTo(11);
        
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(_addressImageV.mas_top).offset(-5);
        make.left.mas_equalTo(_addressImageV);
        make.height.mas_equalTo(13);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(_subTitleLabel.mas_top).offset(-5);
        make.left.mas_equalTo(_subTitleLabel);
        make.height.mas_equalTo(15);
        
    }];
    
    [_descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(_bgImageView.mas_bottom).offset(5);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        
    }];
    
}

-(void)setModel:(ListSonModel *)model
{
    if (_model != model) {
        _model = model;
        
        [self loadModel];
        
    }
}

-(void)loadModel
{
    SDWebImageManager *manage = [SDWebImageManager sharedManager];
    
    [manage downloadImageWithURL:_model.bg_pic[0] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
       
        _bgImageView.image = [image zq_cropEqyalScaleImageToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 200)];
        
    }];
    
    _addressLabel.text = _model.destination;
    
    _timeLabel.text = [self timeStrWithStarStr:_model.start_date andEndStr:_model.end_date];
    
    _subTitleLabel.text = _model.sub_title;
    
    _titleLabel.text = _model.title;
    
    _descLabel.text = _model.short_desc;
}


+(CGSize)SizeWithModel:(ListSonModel *)model
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSParagraphStyleAttributeName:style};
    
    float height = [model.short_desc boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 35, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
    
    CGSize size = CGSizeMake( [UIScreen mainScreen].bounds.size.width,210 + height);
    
    return size;
}


-(NSString *)timeStrWithStarStr:(NSString *)star andEndStr:(NSString *)end
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    
    NSDate *starDate = [formatter dateFromString:star];
    
    NSDate *endDate = [formatter dateFromString:end];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"m月d日"];
    NSString *str1 = [formatter1 stringFromDate:starDate];
    NSString *str2 = [formatter1 stringFromDate:endDate];
    
    return [NSString stringWithFormat:@"%@-%@",str1,str2];
}

@end
