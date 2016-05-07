//
//  NextStopCell.m
//  qinkeTtavel
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NextStopCell.h"
#import "NextTopModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@implementation NextStopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


-(void)setArray:(NSArray *)array
{
    if (_array != array) {
        _array = array;
        
        [self addImageButton];
    }
}

-(void)addImageButton
{
    float width = [UIScreen mainScreen].bounds.size.width;
    UIView *lastView = nil;
    UIView *secondView = nil;
    for (NSInteger i = 0; i < _array.count; i++) {
        
        NextTopModel *model = _array[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+i;
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:model.title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:model.bg_pic] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [btn setBackgroundImage:image forState:UIControlStateNormal];
        }];
     
        [self.contentView addSubview:btn];
        
        if (lastView) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(lastView);
                make.left.mas_equalTo(lastView.mas_right).offset(10);
                make.width.mas_equalTo((width-30)/2);
                make.height.mas_equalTo((width-30)/4);
                
            }];
            if (i == 1) {
                lastView = nil;
            }
            else
            {
                lastView = btn;
            }
            
        }
        else
        {
            if (secondView) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.mas_equalTo(secondView.mas_bottom).offset(10);
                    make.left.mas_equalTo(10);
                    make.width.mas_equalTo((width-30)/2);
                    make.height.mas_equalTo((width-30)/4);
                    
                }];
                lastView = btn;
            }
            else
            {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.mas_equalTo(10);
                    make.left.mas_equalTo(10);
                    make.width.mas_equalTo((width-30)/2);
                    make.height.mas_equalTo((width-30)/4);
                    
                }];
                secondView = btn;
                lastView = btn;
            }
           
        }
        
        
    }
    
    
    
    
}

-(void)pressBtn:(UIButton *)btn
{
    NSInteger i = btn.tag - 100;
     NextTopModel *model = _array[i];
    
    self.pushNextBlock(model.goodId);
}

@end
