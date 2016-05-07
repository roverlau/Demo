//
//  TagsCell.h
//  qinkeTtavel
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TagsCell : UITableViewCell

@property (nonatomic , retain) NSArray *tagArray;

@property (nonatomic , copy) void(^pushTagBlock)(NSString *,NSString *);

@end
