//
//  NZYTabBarController.m
//  自定义tabBar
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NZYTabBarController.h"
#import "NZYTabBarButton.h"

@interface NZYTabBarController ()
{
    UIView * _tabBarView;
}

@end

@implementation NZYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedArr = [NSArray new];
    self.unSelecteArr = [NSArray new];
    self.titleArr = [NSArray new];
}

-(void)viewWillAppear:(BOOL)animated
{
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];
    
    _tabBarView = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:_tabBarView];
    
    _tabBarView.backgroundColor = [UIColor whiteColor];
    
    for (NSInteger i = 0; i < self.selectedArr.count; i++ ) {
        NZYTabBarButton *btn = [[NZYTabBarButton alloc]initWithFrame:CGRectMake(i*(_tabBarView.frame.size.height+(_tabBarView.frame.size.width - _tabBarView.frame.size.height*self.selectedArr.count)/(self.selectedArr.count-1)),0,_tabBarView.frame.size.height, _tabBarView.frame.size.height)];
        btn.tag = 10+i;
        
        if (self.selectedIndex == i) {
            [btn.tabBarButton setImage:[UIImage imageNamed:self.selectedArr[i]] forState:UIControlStateNormal];
            btn.tabBarButtonTitle.text = self.titleArr[i];
            btn.tabBarButtonTitle.textColor = [UIColor redColor];
        }else{
            [btn.tabBarButton setImage:[UIImage imageNamed:self.unSelecteArr[i]] forState:UIControlStateNormal];
        }
        
        [btn.tabBarButton addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        btn.tabBarButtonTitle.text = self.titleArr[i];
        
        [_tabBarView addSubview:btn];
        
        
    }
    
}

-(void)change:(UIButton *)button
{
    for (NZYTabBarButton *btn in _tabBarView.subviews) {
        if (btn.tabBarButton == button) {
            [button setImage:[UIImage imageNamed:self.selectedArr[btn.tag-10]] forState:UIControlStateNormal];
            
            //选中后的文字
            btn.tabBarButtonTitle.textColor = [UIColor redColor];
            
            self.selectedIndex = btn.tag-10;
        }else{
            [btn.tabBarButton setImage:[UIImage imageNamed:self.unSelecteArr[btn.tag-10]] forState:UIControlStateNormal];
            btn.tabBarButtonTitle.textColor = [UIColor blackColor];
        }
    }
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
