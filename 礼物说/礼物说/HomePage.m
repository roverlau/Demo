//
//  HomePage.m
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "HomePage.h"
#import "AFNetworking.h"
#import "SroModel.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+SDImageCacheExtension.h"


@interface HomePage ()

@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIScrollView *scroll;
@property (nonatomic,strong)NSTimer *timer;

@end

@implementation HomePage

+(instancetype)circleViewFrame:(CGRect)frame{
    HomePage *view = [[HomePage alloc]initWithFrame:frame];
    view.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 1, frame.size.width,130)];
    [view addSubview:view.scroll];
    //    view.scroll.backgroundColor = [UIColor orangeColor];
    view.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:view selector:@selector(scrollBanan) userInfo:nil repeats:YES];
    
    
    return view;
}

-(void)scrollBanan{
    //判断是否滚动到最后一张图片 Y(偏移量归零  显示第一张)
    if (self.scroll.contentOffset.x>=self.scroll.frame.size.width*(self.imgUrlArr.count-1)) {
        self.scroll.contentOffset = CGPointMake(0, 0);
    }else{
        self.scroll.contentOffset = CGPointMake(self.scroll.contentOffset.x+self.scroll.frame.size.width, 0);
    }
}
//跟新滚动视图
-(void)setImgUrlArr:(NSMutableArray *)imgUrlArr{
    _imgUrlArr = imgUrlArr;
    //    self.scroll.backgroundColor = [UIColor orangeColor];
    self.scroll.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*imgUrlArr.count, 0
                                         );//CGRectGetHeight(self.bounds));
    
    
    self.scroll.pagingEnabled = YES;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    
    
    for (UIView *addView in self.scroll.subviews) {
        [addView removeFromSuperview];
    }
    for (NSInteger i = 0; i < imgUrlArr.count; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)*i, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.scroll.bounds))];
        SroModel *sm = imgUrlArr[i];
        //如果没有继续下载
        img.image = [UIImage cachedImageWithURL:sm.image_url];
        if (!img.image) {
            [img sd_setImageWithURL:[NSURL URLWithString:sm.image_url]];
        }
        [self.scroll addSubview:img];
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [img addGestureRecognizer:myTap];
        img.tag = i+10;
        img.userInteractionEnabled = YES;
        
    }
    //开启定时器
    [self openTimer];
    
}


-(void)click:(UITapGestureRecognizer*)sender{
    
     NSArray *arr = @[@"http://api.liwushuo.com/v1/collections/149/posts?offset=0&limit=20&_=635816174629146868",@"http://redirect.liwushuo.com/j/hongbao1023?_=635816204552188410",@"http://event.liwushuo.com/event/151111-sales/?_=635816203074072166",@"http://api.liwushuo.com/v1/collections/148/posts?offset=0&limit=20&_=635816174629146868",@"http://api.liwushuo.com/v1/collections/144/posts?offset=0&limit=20&_=635816174629146868",@"http://api.liwushuo.com/v1/collections/145/posts?offset=0&limit=20&_=635816174629146868",@"http://api.liwushuo.com/v1/collections/140/posts?offset=0&limit=20&_=635816174629146868"];
    NSDictionary *dic = @{arr[sender.view.tag-10]:[NSString stringWithFormat:@"%ld",sender.view.tag]};
    NSLog(@"%ld",sender.view.tag);
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Rover" object:dic];
}

-(void)openTimer{
    [self.timer setFireDate:[NSDate distantPast]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





@end
