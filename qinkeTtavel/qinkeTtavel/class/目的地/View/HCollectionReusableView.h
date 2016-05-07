//
//  HCollectionReusableView.h
//  qinkeTtavel
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCollectionReusableView : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
-(void)initUI:(NSString *)url name:(NSString*)desc;

@end
