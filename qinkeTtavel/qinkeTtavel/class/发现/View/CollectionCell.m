//
//  CollectionCell.m
//  qinkeTtavel
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@interface CollectionCell ()

@property (nonatomic , retain) UIButton *btn;

@end

@implementation CollectionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.layer.cornerRadius = 10;
        _btn.layer.masksToBounds = YES;
        _btn.titleLabel.font = [UIFont boldSystemFontOfSize:23];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.contentMode = UIViewContentModeScaleToFill;
        _btn.userInteractionEnabled = NO;
        
         [self.contentView addSubview:_btn];
        
    }
    return self;
}


-(void)setCollectionModel:(CollectionModel *)collectionModel{
    if (_collectionModel != collectionModel) {
        _collectionModel = collectionModel;
        
        [self addBtn];
    }
}

-(void)addBtn
{
    
   [_btn setTitle:_collectionModel.title forState:UIControlStateNormal];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:_collectionModel.bg_pic[0]] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        [_btn setBackgroundImage:image forState:UIControlStateNormal];
        
    }];
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(self.contentView).offset(-10);
        
    }];
    
   
}

@end
