//
//  NextStopView.m
//  qinkeTtavel
//
//  Created by ZQ on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NextStopView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NextBodyModel.h"


@interface NextStopView ()

@property (nonatomic , retain) UIView *lastView;

@property (nonatomic , retain) NSArray *bodyArray;

@property (nonatomic , retain) UIScrollView *nextScrollView;

@end

@implementation NextStopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        _nextScrollView = [[UIScrollView alloc]init];
        _nextScrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_nextScrollView];
   
    }
    return self;
}

-(void)setModel:(NextStopViewModel *)model
{
    if (_model != model) {
        _model = model;
        
        [self loadView];
    }
}


-(void)loadView
{
    UIImageView *imageV = [[UIImageView alloc]init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:_model.bg_pic]];
    [_nextScrollView addSubview:imageV];
    
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self.bounds.size.width);
        make.height.mas_equalTo(250);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = _model.title;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.layer.masksToBounds = YES;
    
    [_nextScrollView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV.mas_bottom).offset(20);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(self.bounds.size.width - 20);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    
    [_nextScrollView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(self.bounds.size.width - 20);
        make.height.mas_equalTo(1);
    }];
    
    _lastView = line;
    
    
    
    [self addSonViewByArray:_model.body];
}

-(void)addSonViewByArray:(NSArray *)array
{
    
    for (NextBodyModel *model in array) {
        if ([model.type isEqualToString:@"text"]) {
            [self addTextLabel:model];
        }
        else if ([model.type isEqualToString:@"pic"])
        {
            [self addPicImage:model];
        }
        else
        {
            [self addHead:model];
        }
    }
    
    [_nextScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.bottom.mas_equalTo(_lastView.mas_bottom).offset(60);
    }];
    
}

-(void)addTextLabel:(NextBodyModel *)sonModel
{
    NextDetailModel *model = sonModel.content;
    
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.backgroundColor = [UIColor whiteColor];
    textLabel.layer.masksToBounds = YES;
    textLabel.font = [UIFont systemFontOfSize:13];
    textLabel.numberOfLines = 0;
    
    textLabel.text = model.text;
    
    [_nextScrollView addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lastView.mas_bottom).offset(15);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(self.bounds.size.width - 20);
    }];
    
    _lastView = textLabel;
}

-(void)addPicImage:(NextBodyModel *)sonModel
{
    NextDetailModel *model = sonModel.content;
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:model.url]];
    
    [_nextScrollView addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lastView.mas_bottom).offset(15);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(self.bounds.size.width - 20);
        make.height.mas_equalTo(200);
    }];
    
    _lastView = imageV;
}

-(void)addHead:(NextBodyModel *)sonModel
{
    NextDetailModel *model = sonModel.content;
    
    UILabel *headLabel = [[UILabel alloc]init];
    headLabel.backgroundColor = [UIColor whiteColor];
    headLabel.layer.masksToBounds = YES;
    headLabel.font = [UIFont systemFontOfSize:17];
    headLabel.text = model.head;
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.numberOfLines = 0;
    
    [_nextScrollView addSubview:headLabel];
    
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lastView.mas_bottom).offset(15);
        make.centerX.mas_equalTo(_nextScrollView);
        make.width.mas_equalTo(self.bounds.size.width - 60);
    }];
    
    _lastView = headLabel;
}

@end
