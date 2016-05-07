//
//  UIImage+ZQCorp.m
//  qinkeTtavel
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIImage+ZQCorp.h"

@implementation UIImage (ZQCorp)

-(UIImage *)zq_cropEqyalScaleImageToSize:(CGSize)size
{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

-(UIImage *)zq_cropCornerRadius:(CGFloat)cornerRadius
{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    
    CGContextAddPath(c, path.CGPath);
    
    CGContextClip(c);
    
    [self drawInRect:rect];
    
    CGContextDrawPath(c, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
