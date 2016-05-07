//
//  TableViewCell.h
//  猿生活
//
//  Created by RoverLau on 15/11/5.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "HomeModel.h"
//
//@protocol MyMethod <NSObject>
//
//-(void)my;
//
//@end

@interface TableViewCell : UITableViewCell

//@property (nonatomic ,assign)id <MyMethod>delegate;

-(void)refreshUI:(HomeModel*)model;


@end
