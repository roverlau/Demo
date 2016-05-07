//
//  ShowScroll.h
//  qinkeTtavel
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowModel.h"

@interface ShowScroll : UIScrollView

@property (nonatomic , retain) ShowModel *model;

@property (nonatomic , retain) UIImageView *headImageV;

@property (nonatomic , copy) void(^pushMap)(NSString *);

@property (nonatomic , copy) void(^pushImageV)(NSInteger,ShowModel *);

-(void)setheadImageVAnimoteWith:(float)height;

@end
