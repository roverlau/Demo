//
//  ShowViewController.m
//  猿生活
//
//  Created by RoverLau on 15/11/5.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import "ShowViewController.h"
#import "UIImageView+WebCache.h"
#import "BuModel.h"

@interface ShowViewController ()

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,assign)CGSize mySize;
@end

@implementation ShowViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr ) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:_imgView];
    }
    return _imgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mySize =self.view.frame.size;

    self.navigationController.navigationBarHidden = YES;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pop)]];
    //长按手势
    UILongPressGestureRecognizer *pre = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpress:)];
    [self.view addGestureRecognizer:pre];
    
  
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(mySwipe:)];
    //指定手势的方向
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
    UISwipeGestureRecognizer *swipe3 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(mySwipe:)];
    //指定手势的方向
    swipe3.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe3];
  
    //缩放手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(myPinch:)];
    [self.view addGestureRecognizer:pinch];

}

#pragma mark - 长按手势触发
-(void)longpress:(UILongPressGestureRecognizer*)press{
    if (press.state==UIGestureRecognizerStateBegan) {
#warning 图片保存
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"图片即将保存" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }
}

-(void)mySwipe:(UISwipeGestureRecognizer*)swipe{
    NSString *picUrl =@"";
//    self.imgView.frame = CGRectMake(0, 20, self.mySize.width, self.mySize.height-64);
    self.view.transform =CGAffineTransformMakeScale(1,1);
     if(swipe.direction ==UISwipeGestureRecognizerDirectionLeft){
        
         if (self.page>=self.dataArr.count-1) {
             UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"已经到最后一张啦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [av show];
             return;
         }
         self.page++;
         BuModel *model = self.dataArr[self.page];
         
         if (model.raw_url==nil) {
             picUrl = model.url;
         }else{
             picUrl = model.raw_url;
         }
         
         [self.imgView sd_setImageWithURL:[NSURL URLWithString:picUrl]];
    }else if(swipe.direction ==UISwipeGestureRecognizerDirectionRight){
        if (self.page<=0) {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"已经到第一张啦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [av show];
            return;
        }
        self.page--;
        BuModel *model = self.dataArr[self.page];
        if (model.raw_url==nil) {
            picUrl = model.url;
        }else{
            picUrl = model.raw_url;
        }
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:picUrl]];
    }
}

-(void)myPinch:(UIPinchGestureRecognizer*)pin{

    pin.view.transform = CGAffineTransformMakeScale(pin.scale, pin.scale);
}
-(void)pop{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
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
