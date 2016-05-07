//
//  ImageViewController.m
//  Car
//
//  Created by qianfeng on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ImageViewController.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"

@interface ImageViewController ()<UIScrollViewDelegate,NSURLConnectionDataDelegate,UMSocialDataDelegate>

@property (nonatomic,strong) UIView * titleView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * numLabel;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,assign) BOOL  isShow;
@property (nonatomic,assign) NSInteger count;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isShow = YES;

    [self initUI];
        
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20,KMainScreenWidth, 44)];
    [self.view addSubview:_titleView];
    _titleView.tag = 10;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(8, 5, 24, 30)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:btn];
    
    UIButton *downLoadBtn = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-80, 0, 30, 30)];
    [downLoadBtn setImage:[UIImage imageNamed:@"btn_download"] forState:UIControlStateNormal];
    [self.titleView addSubview:downLoadBtn];
    [downLoadBtn addTarget:self action:@selector(downLoad) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(KMainScreenWidth-45, 0, 30, 30)];
    [shareBtn setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:shareBtn];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KMainScreenHeight/2-110, KMainScreenWidth, 220)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(self.imageArr.count*KMainScreenWidth, 220);
    [self.view addSubview:_scrollView];
    for (NSInteger i = 0; i < self.imageArr.count; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*KMainScreenWidth, 0, KMainScreenWidth, 220)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.imageArr[i] url]]] placeholderImage:[UIImage imageNamed:@"load_carousel_750"]];
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUI:)];
        [imgView addGestureRecognizer:tap];
        [_scrollView addSubview:imgView];
    }
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, KMainScreenHeight/2+170, 200, 30)];
    _nameLabel.text = _name;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.tag = 20;
    [self.view addSubview:_nameLabel];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(KMainScreenWidth/2-50, 5, 100, 25)];
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.text = [NSString stringWithFormat:@"1/%ld",self.imageArr.count];
    [self.titleView addSubview:_numLabel];
}


-(void)backBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//下载
-(void)downLoad
{
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [_imageArr[_count] url] ]]]], self, @selector(didfinishingSavePhotos:withError:withContextInfo:), @"参数");
}

-(void)didfinishingSavePhotos:(UIImage *)image withError:(NSError *)error withContextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"error = %@",error);
    }else{
        
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"已保存到本地相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alerView show];
    }
    
    
}

-(void)shareImage
{
    [[UMSocialControllerService defaultControllerService] setShareText:@"你想说啥呢" shareImage:nil socialUIDelegate:self];
    
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}




//点击图片
-(void)changeUI:(UITapGestureRecognizer *)tap
{
    UIView * v= [self.view viewWithTag:10];
        UILabel *lb = (UILabel *)[self.view viewWithTag:20];

    if (_isShow) {
        [UIView animateWithDuration:0.5 animations:^{
            v.transform =  CGAffineTransformTranslate(v.transform, 0, -100);
            lb.transform = CGAffineTransformTranslate(lb.transform, -100, 0);
    }];
       

    }else{
        [UIView animateWithDuration:0.5 animations:^{
            v.transform =  CGAffineTransformTranslate(v.transform, 0, 100);
            lb.transform = CGAffineTransformTranslate(lb.transform, 100, 0);

        }];
        
    }
    _isShow = !_isShow;
       
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _count = scrollView.contentOffset.x/KMainScreenWidth;
    _numLabel.text = [NSString stringWithFormat:@"%ld/%ld",_count+1,self.imageArr.count];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
