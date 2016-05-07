//
//  SelectionCell.m
//  qinkeTtavel
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SelectionCell.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "SonModelOne.h"
#import "UIImage+ZQCorp.h"

@interface SelectionCell ()

@property (nonatomic , retain) UIScrollView *imageScroll;

//@property (nonatomic , retain) UIImageView *imgView;

@property (nonatomic , retain) UILabel *oneTitleLabel;

@property (nonatomic , retain) NSTimer *timer;


@end

@implementation SelectionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imageScroll = [[UIScrollView alloc]init];
        _imageScroll.pagingEnabled = YES;
        _imageScroll.bounces = NO;
        
        [self.contentView addSubview:_imageScroll];
        
//        [_imageScroll mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self.contentView);
//            
//        }];
        
//        [self addimgScroll];
        
        _oneTitleLabel = [[UILabel alloc]init];
        _oneTitleLabel.textColor = [UIColor whiteColor];
        _oneTitleLabel.font = [UIFont boldSystemFontOfSize:22];
        _oneTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_oneTitleLabel];
        
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
            
//      [[NSRunLoop mainRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
        
        
    }
    return self;
}

-(void)timer:(NSTimer *)timer
{
    float width = [UIScreen mainScreen].bounds.size.width;
    CGPoint p = CGPointMake(width + _imageScroll.contentOffset.x, _imageScroll.contentOffset.y);
    
    
    if (!(p.x / width == _model.collections.count)) {
        [_imageScroll setContentOffset:p animated:YES];
    }
    else
    {
         [_imageScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    
}

-(void)setModel:(SelectModel *)model
{
    if (_model != model) {
        _model = model;
        
        UIImageView *lastImgView = nil;
        
        NSArray *imgArr = _model.collections;
        
        
        
        for (int i = 0; i < imgArr.count; i++) {
            
            
            SonModelOne *sonModel = imgArr[i];
            
            UIImageView *imgV = [[UIImageView alloc]init];
            
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.clipsToBounds = YES;
            
            imgV.tag = 110 + i;
            imgV.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressUpInImage:)];
            [imgV addGestureRecognizer:tap];
            
            [_imageScroll addSubview:imgV];
            
           [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(self.contentView);
               make.bottom.mas_equalTo(self.contentView);
               
               if (lastImgView) {
                   make.left.mas_equalTo(lastImgView.mas_right).offset(0);
                   
               }
               else
               {
                   make.left.mas_equalTo(0);
               }
               
               make.width.mas_equalTo(self.contentView);
           }];
            
            lastImgView = imgV;
            
            NSString *pathDefault = [[NSBundle mainBundle] pathForResource:@"supplier_default" ofType:@"png"];
            [imgV sd_setImageWithURL:[NSURL URLWithString:sonModel.bg_pic[0]] placeholderImage:[UIImage imageWithContentsOfFile:pathDefault]];
            
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:22];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.layer.masksToBounds = YES;
            [imgV addSubview:titleLabel];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.center.mas_equalTo(imgV);
                make.size.mas_equalTo(CGSizeMake(200, 100));
            }];
            
            titleLabel.text = sonModel.title;
            
        }
//        _imageScroll mas_remakeConstraints:<#^(MASConstraintMaker *make)block#>
        [_imageScroll mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(self.contentView);
            
            make.right.mas_equalTo(lastImgView.mas_right).offset(0);
            
        }];
        
    }
}

-(void)pressUpInImage:(UITapGestureRecognizer *)tap
{
    UIImageView *imageV = (UIImageView *)tap.view;
    SonModelOne *model = _model.collections[imageV.tag - 110];
    self.imageBlock(model.goodId);
}

@end






























