//
//  ZTTableViewCell.h
//  礼物说
//
//  Created by RoverLau on 15/10/28.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTModel.h"

@interface ZTTableViewCell : UITableViewCell

-(void)refreshUI:(ZTModel*)model;

@end
