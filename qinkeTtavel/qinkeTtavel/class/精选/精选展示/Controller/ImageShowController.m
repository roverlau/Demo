//
//  ImageShowController.m
//  qinkeTtavel
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ImageShowController.h"
#import "ShowSonModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

#define LLG_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define LLG_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ImageShowController()<UIScrollViewDelegate>

//@property (strong , nonatomic) UIImageView *imgView;
@property (strong , nonatomic) UIScrollView *scroView;

@property (retain , nonatomic) NSMutableArray *dataArray;

@property (retain , nonatomic) UIView *lastView;

@end

@implementation ImageShowController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.scroView];
    
    [_scroView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(0);
        make.right.mas_equalTo(_lastView);
        
    }];
    
     _scroView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * _cc, 0);
    
}



#pragma mark -- Scrollview的创建

-(UIScrollView *)scroView
{
    if (!_scroView) {
        _dataArray = [[NSMutableArray alloc]init];
        _scroView = [[UIScrollView alloc]init];
        _scroView.userInteractionEnabled = YES;
        _scroView.pagingEnabled = YES;
        _scroView.backgroundColor = [UIColor blackColor];
        _scroView.showsHorizontalScrollIndicator = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressDismis:)];
        [_scroView addGestureRecognizer:tap];
        
        NSArray *imageArr = _model.details;
        
       _lastView = nil;
        NSInteger count = 0;
        
        for (ShowSonModel *sonModel in imageArr) {
            if ([sonModel.type isEqualToString:@"pic"]) {
                [_dataArray addObject:sonModel];
                UIImageView *imageV = [[UIImageView alloc]init];
                imageV.contentMode = UIViewContentModeScaleAspectFit;
                [imageV sd_setImageWithURL:[NSURL URLWithString:sonModel.content[@"url"]]];
                
                [_scroView addSubview:imageV];
                
                if (_lastView) {
                    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(_scroView);
                        make.left.mas_equalTo(_lastView.mas_right);
                         make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
                    }];
                }
                else
                {
                    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(_scroView);
                        make.left.mas_equalTo(0);
                        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
                    }];
                }
                _lastView = imageV;
                count++;
            }
        }
        
        _scroView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * count, [UIScreen mainScreen].bounds.size.height);
        
    }
    
    return _scroView;
}

-(void)pressDismis:(UITapGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
