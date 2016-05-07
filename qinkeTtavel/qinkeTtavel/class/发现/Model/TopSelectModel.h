//
//  TopSelectModel.h
//  qinkeTtavel
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopSelectSonModel.h"
#import <YYModel/YYModel.h>

@interface TopSelectModel : NSObject


@property (nonatomic , assign) NSNumber *hotness;

@property (nonatomic , strong) TopSelectSonModel *selection;

@end
