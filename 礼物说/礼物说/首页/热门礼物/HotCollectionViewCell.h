//
//  HotCollectionViewCell.h
//  礼物说
//
//  Created by RoverLau on 15/10/27.
//  Copyright (c) 2015年 RoverLau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"

@interface HotCollectionViewCell : UICollectionViewCell

-(void)refreshUI:(HotModel*)model;

@end
