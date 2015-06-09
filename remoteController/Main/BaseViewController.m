//
//  BaseViewController.m
//  remoteController
//
//  Created by zy on 15/6/7.
//  Copyright (c) 2015年 adolph. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"setting" highImageName:nil target:self action:@selector(setBtnOnClick:)];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
