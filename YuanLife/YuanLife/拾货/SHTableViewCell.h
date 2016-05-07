//
//  SHTableViewCell.h
//  猿生活
//
//  Created by RoverLau on 15/11/5.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "SHModel.h"


@interface SHTableViewCell : UITableViewCell

-(void)refreshUI:(SHModel*)model;

@end
