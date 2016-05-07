//
//  TagsCell.m
//  qinkeTtavel
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TagsCell.h"
#import "TagModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@implementation TagsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)setTagArray:(NSArray *)tagArray
{
    if (_tagArray != tagArray) {
        _tagArray = tagArray;
        
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self addButton];
        });
    
    }
}


-(void)addButton
{
    UIView *lastView = nil;
    UIView *secondView = nil;
    float width = [UIScreen mainScreen].bounds.size.width;
    for (NSInteger j = 0; j < 2; j++) {
        for (NSInteger i = 0; i < _tagArray.count / 2; i++) {
            NSInteger count = i;
            if (j == 1) {
                count += _tagArray.count / 2;
            }
            TagModel *model = _tagArray[count];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = [model.goodId integerValue];
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:model.name forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
//            btn.titleLabel.text = model.name;
            
            btn.titleEdgeInsets = UIEdgeInsetsMake(75, 0, 0, 0);
            
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            
            [manager downloadImageWithURL:[NSURL URLWithString:model.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
//                [btn setImage:image forState:UIControlStateNormal];
                [btn setBackgroundImage:image forState:UIControlStateNormal];
            }];
            
            [self.contentView addSubview:btn];
            
            if (lastView) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.mas_equalTo(lastView);
                    make.left.mas_equalTo(lastView.mas_right).offset(10);
                    make.width.height.mas_equalTo((width - 60)/6);
                    
                }];
                lastView = btn;
                
            }
            else
            {
                if (j == 0) {
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.top.mas_equalTo(10);
                        make.left.mas_equalTo(5);
                        make.width.height.mas_equalTo((width - 60)/6);
                        
                    }];
                    
                    secondView = btn;
                }
                else
                {
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.top.mas_equalTo(secondView.mas_bottom).offset(30);
                        make.left.mas_equalTo(5);
                        make.width.height.mas_equalTo((width - 60)/6);
                        
                    }];
                }
               
                lastView = btn;
            }
            
        }
        //第二行
        lastView = nil;
        
    }
    
    
}

-(void)pressBtn:(UIButton *)btn
{
    NSString *str = [NSString stringWithFormat:@"%ld",btn.tag];
    self.pushTagBlock(str,btn.titleLabel.text);
}

@end
