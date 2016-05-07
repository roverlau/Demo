//
//  BCollectionViewCell.h
//  qinkeTtavel
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CityModel.h"
@interface BCollectionViewCell : UICollectionViewCell

-(void)initUI:(CityModel*)model;

@end
