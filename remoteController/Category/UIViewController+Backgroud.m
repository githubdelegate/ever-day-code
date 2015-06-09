//
//  UIViewController+Backgroud.m
//  remoteController
//
//  Created by zy on 15/6/7.
//  Copyright (c) 2015年 adolph. All rights reserved.
//

#import "UIViewController+Backgroud.h"

@implementation UIViewController (Backgroud)
- (void)setBackgroundImage:(UIImage *)image
{
    UIImageView *imageView  = [[UIImageView alloc]initWithFrame:self.view.frame];
    [imageView setImage:image];
    [self.view addSubview:imageView];
}
@end
