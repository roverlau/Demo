//
//  ListCollectionCell.h
//  qinkeTtavel
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListSonModel.h"

@interface ListCollectionCell : UICollectionViewCell

@property (nonatomic , retain) ListSonModel *model;



+(CGSize)SizeWithModel:(ListSonModel *)model;

@end
