//
//  TagListTwoCell.m
//  qinkeTtavel
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TagListTwoCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+ZQCorp.h"


@interface TagListTwoCell ()

@property (nonatomic , retain) UIImageView *bgImageView;

@property (nonatomic , retain) UILabel *titleLabel;

@end

@implementation TagListTwoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.backgroundColor = [UIColor whiteColor];
        //        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_bgImageView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [_bgImageView addSubview:_titleLabel];

        [self addMasonry];

    }
    return self;
}

-(void)addMasonry
{
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@200);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.mas_equalTo(_bgImageView);
        
        make.height.mas_equalTo(22);
        
    }];
    
}

-(void)setModel:(TagListSonModel *)model
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
    
    _titleLabel.text = _model.title;
    
}
@end
