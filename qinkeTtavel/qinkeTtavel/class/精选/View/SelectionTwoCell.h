//
//  SelectionTwoCell.h
//  qinkeTtavel
//
//  Created by mac on 16/3/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectModel.h"

@interface SelectionTwoCell : UITableViewCell

@property (nonatomic , retain) SelectModel *model;


+(float)heightWithModel:(SelectModel *)model;

@end
