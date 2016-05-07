//
//  NextStopCell.h
//  qinkeTtavel
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NextStopCell : UITableViewCell

@property (nonatomic , retain) NSArray *array;

@property (nonatomic , copy) void(^pushNextBlock)(NSNumber *);

@end
