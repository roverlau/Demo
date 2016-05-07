//
//  FoundHeadScroll.m
//  qinkeTtavel
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FoundHeadScroll.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import "articleModel.h"

@interface FoundHeadScroll ()<UIScrollViewDelegate>

@property (nonatomic , retain) NSTimer *timer;

@end

@implementation FoundHeadScroll


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.delegate = self;
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
        
    }
    return self;
}

-(void)timer:(NSTimer *)timer
{
    float width = [UIScreen mainScreen].bounds.size.width;
    
    float x = self.contentOffset.x;

    if (x/width == _headArray.count + 1) {
        [self setContentOffset:CGPointMake(width, 0) animated:NO];
    }
    else if (x/width == 0)
    {
        [self setContentOffset:CGPointMake(width*_headArray.count, 0) animated:NO];
    }
    
    CGPoint p = CGPointMake(self.contentOffset.x + width, 0);
    [self setContentOffset:p animated:YES];
}

-(void)setHeadArray:(NSArray *)headArray
{
    if (_headArray != headArray) {
        _headArray = headArray;
        
        float width = [UIScreen mainScreen].bounds.size.width;
        self.contentSize = CGSizeMake(width * (_headArray.count + 2), 200);
        self.contentOffset = CGPointMake(width, 0);
        
        for (NSInteger i = 0; i < _headArray.count; i++) {
            
            articleModel *model = _headArray[i];
            
            if (i == 0) {
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(width * _headArray.count + width, 0, width, 200)];
                imageV.backgroundColor = [UIColor whiteColor];
                [imageV sd_setImageWithURL:[NSURL URLWithString:model.bg_pic]];
                
                [self addSubview:imageV];
            }
            else if (i == _headArray.count - 1)
            {
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 200)];
                imageV.backgroundColor = [UIColor whiteColor];
                [imageV sd_setImageWithURL:[NSURL URLWithString:model.bg_pic]];
                
                [self addSubview:imageV];
            }
            
            
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(width * i + width, 0, width, 200)];
            imageV.backgroundColor = [UIColor whiteColor];
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.bg_pic]];
            
            [self addSubview:imageV];
        }
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    float width = [UIScreen mainScreen].bounds.size.width;
    if (x/width == _headArray.count + 1) {
        [scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    }
    else if (x/width == 0)
    {
        [scrollView setContentOffset:CGPointMake(width*_headArray.count, 0) animated:NO];
    }
}

@end
