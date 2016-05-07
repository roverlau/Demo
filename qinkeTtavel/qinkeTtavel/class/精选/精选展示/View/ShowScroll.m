//
//  ShowScroll.m
//  qinkeTtavel
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShowScroll.h"
#import "ShowSonModel.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "SelectShowController.h"

@interface ShowScroll ()
{
    NSInteger flag;
}

@property (nonatomic , retain) UIView *lastView;

@property (nonatomic , retain) UIView *headView;

@property (nonatomic , retain) NSMutableDictionary *imageDic;

@property (nonatomic , retain) UIButton *moreButton;

@property (nonatomic , retain) NSMutableArray  *arr1;

//@property (nonatomic , assign) NSInteger flag;


@end

//static NSInteger flag = 0; //标记第几张图片

@implementation ShowScroll

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
         _arr1 = [[NSMutableArray alloc]init];
        _model = [[ShowModel alloc]init];
        _imageDic = [[NSMutableDictionary alloc]init];
        flag = 0;
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"更多内容↓" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        [_moreButton setTitle:@"收起内容↑" forState:UIControlStateSelected];
        [_moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [_moreButton addTarget:self action:@selector(moreShow:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
        
        self.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
        
    }
    return self;
}

#pragma mark -- 创建头部视图
-(void)createHeadView
{
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_headView];
    
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeBtn setBackgroundImage:[UIImage imageNamed:@"activity_btnUnLike_red"] forState:UIControlStateNormal];
    
    [_headView addSubview:likeBtn];
    
    
    UIView *rightView = nil;
    for (NSDictionary *dic in _model.like_user) {
        UIImageView *likeImgV = [[UIImageView alloc]init];
        
        [_headView addSubview:likeImgV];
        
        if (rightView) {
            [likeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(5);
                make.left.mas_equalTo(rightView.mas_right).offset(5);
                make.width.height.mas_equalTo(@30);
                
            }];
        }
        else
        {
            [likeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.mas_equalTo(5);
                make.left.mas_equalTo(likeBtn.mas_right).offset(10);
                make.width.height.mas_equalTo(@30);
                
            }];
        }
        likeImgV.layer.cornerRadius = 15;
        likeImgV.layer.masksToBounds = YES;
        
        [likeImgV sd_setImageWithURL:[NSURL URLWithString:dic[@"avatar"]]placeholderImage:[UIImage imageNamed:@"defaultavatar"]];
    
        rightView = likeImgV;
        
    }
    
    
    UILabel *addrLabel = [[UILabel alloc]init];
    addrLabel.font = [UIFont systemFontOfSize:15];
    addrLabel.backgroundColor = [UIColor whiteColor];
    addrLabel.layer.masksToBounds = YES;
    addrLabel.text = _model.destination;
    
    [_headView addSubview:addrLabel];  //地址和简介写反了
    
    
    UILabel *destLabel = [[UILabel alloc]init];
    destLabel.font = [UIFont systemFontOfSize:12];
    destLabel.textColor = [UIColor grayColor];
    destLabel.backgroundColor = [UIColor whiteColor];
    destLabel.layer.masksToBounds = YES;
    destLabel.text = _model.address;
    
    [_headView addSubview:destLabel];
    
    
    [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.width.height.mas_equalTo(@30);
        
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:234 green:238 blue:239 alpha:1.0];
    [_headView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(likeBtn.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo(5);
    }];
    
   [addrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      
       make.top.mas_equalTo(line.mas_bottom).offset(5);
       make.left.mas_equalTo(10);
       make.height.mas_equalTo(@20);
       make.width.mas_lessThanOrEqualTo([UIScreen mainScreen].bounds.size.width - 100);
       
   }];
    
    [destLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addrLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(addrLabel);
        make.height.mas_equalTo(@15);
        
        make.width.mas_lessThanOrEqualTo([UIScreen mainScreen].bounds.size.width - 100);
    }];
    
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mapBtn setBackgroundImage:[UIImage imageNamed:@"anjuke_icon_itis_position@2x"] forState:UIControlStateNormal];
    
    [mapBtn addTarget:self action:@selector(pushToMap) forControlEvents:UIControlEventTouchUpInside];
    
    [_headView addSubview:mapBtn];
    
    [mapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(addrLabel);
        make.right.mas_equalTo(_headView).offset(-10);
        make.bottom.mas_equalTo(destLabel);
        make.width.mas_equalTo(33);
        
    }];
    
    
    [self addHeadMason];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.layer.masksToBounds = YES;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = _model.title;
    
    [_headView addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc]init];
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.layer.masksToBounds = YES;
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    subTitleLabel.text = _model.sub_title;
    
    [_headView addSubview:subTitleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(_headView.mas_top).offset(-30);
        make.height.mas_equalTo(20);
        
    }];
    
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(titleLabel);
        make.height.mas_equalTo(15);
        
    }];
    
    _headImageV = [[UIImageView alloc]init];
    _headImageV.contentMode = UIViewContentModeScaleAspectFill;
    _headImageV.clipsToBounds = YES;
    [_headImageV sd_setImageWithURL:[NSURL URLWithString:_model.bg_pic[0]]];
    [self addSubview:_headImageV];
    [self sendSubviewToBack:_headImageV];
    
    [self setheadImageVAnimoteWith:250];
}

-(void)pushToMap
{
    self.pushMap(@"1");
}



-(void)setheadImageVAnimoteWith:(float)height
{
    [_headImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(-height);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo(height).priorityHigh();
        
        make.height.lessThanOrEqualTo(@300);
        make.height.greaterThanOrEqualTo(@250);
    }];
}

-(void)addHeadMason
{
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.height.mas_equalTo(120);
        
    }];
}

-(void)moreShow:(UIButton *)btn
{
    btn.selected = !btn.selected;
    [_imageDic removeAllObjects];
    flag = 0;
    
    if (btn.selected) {
        
        for (int i = 0; i<_arr1.count; i++) {
            UIView *view = [self viewWithTag:100+i];
            [view removeFromSuperview];
        }
        
        _lastView = nil;
        [self addSonViewByArray:_model.details];
    }
    else
    {
        for (int i = 0; i<_model.details.count; i++) {
            UIView *view = [self viewWithTag:100+i];
            [view removeFromSuperview];
        }
        
        _lastView = nil;
        
//        [self addSubview:_moreButton];
        [self addSonViewByArray:_arr1];
    }
}

-(void)setModel:(ShowModel *)model
{
    if (_model != model) {
        _model = model;
        
        [self createHeadView];
        
        for (int i = 0; i < _model.details.count / 2; i++) {
            ShowSonModel *model = _model.details[i];
            [_arr1 addObject:model];
        }
        
        [self addSonViewByArray:_arr1];
        
    }
}

-(void)addSonViewByArray:(NSArray *)array
{
    int i =0;
    for (ShowSonModel *model in array) {
        if ([model.type isEqualToString:@"text"]) {
            [self addTextLabel:model];
        }
        else if ([model.type isEqualToString:@"pic"])
        {
            [self addPicImageView:model];
            
        }
        else
        {
            [self addHeadLabel:model];
        }
        
        if (_lastView) {
            _lastView.tag = 100 + i;
            i++;
            if ([model.type isEqualToString:@"pic"]) {
                [_imageDic setObject:[NSString stringWithFormat:@"%ld",flag] forKey:[NSString stringWithFormat:@"%ld",_lastView.tag]];
                flag++;
            }
        }
    }
    
//    [_moreButton updateFocusIfNeeded];
    [_moreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lastView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(@12);
        make.width.mas_equalTo(@60);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(0);
      
//        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        
        make.bottom.mas_equalTo(_moreButton.mas_bottom).offset(54);
    }];
}

-(void)addTextLabel:(ShowSonModel *)model
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    
    [self addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lastView.mas_bottom).offset(15);
        make.left.mas_equalTo(self).offset(10);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 20);
//        make.right.mas_equalTo(self).offset(-10);
    }];
    
    label.text = model.content[@"text"];
    
    _lastView = label;
}

-(void)addPicImageView:(ShowSonModel *)model
{
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.backgroundColor = [UIColor whiteColor];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressImage:)];
    imageV.userInteractionEnabled = YES;
    
    [imageV addGestureRecognizer:tap];
    
    [self addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(_lastView.mas_bottom).offset(15);
        make.left.mas_equalTo(self).offset(10);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 20);
        make.height.mas_equalTo(250);
        
    }];
    
    [imageV sd_setImageWithURL:[NSURL URLWithString:model.content[@"url"]]];
    
    _lastView = imageV;
}

-(void)pressImage:(UITapGestureRecognizer *)tap
{
    UIImageView *imageV = (UIImageView *)tap.view;
    NSInteger cc = [_imageDic[[NSString stringWithFormat:@"%ld",imageV.tag]] integerValue];
    self.pushImageV(cc,_model);
    
    
}

-(void)addHeadLabel:(ShowSonModel *)model
{
    if (_lastView) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor whiteColor];
        label.layer.masksToBounds = YES;
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_lastView.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self);
        }];
        label.text = model.content[@"head"];
        
        _lastView = label;
    }
    else
    {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor whiteColor];
        label.layer.masksToBounds = YES;
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headView.mas_bottom).offset(30);
            make.centerX.mas_equalTo(self);
        }];
        label.text = model.content[@"head"];
        
        _lastView = label;
    }
    
    
    
    
    
}

@end
