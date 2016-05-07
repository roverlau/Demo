//
//  NextBodyModel.h
//  qinkeTtavel
//
//  Created by ZQ on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NextDetailModel.h"

@interface NextBodyModel : NSObject

@property (nonatomic , copy) NSString *type;

@property (nonatomic , retain) NextDetailModel *content;

@end
