//
//  HomeViewController.m
//  remoteController
//
//  Created by zy on 15/6/7.
//  Copyright (c) 2015年 adolph. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *light;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.light.width = self.light.height;
    
    
//    [self setBackgroundImage:[UIImage imageWithName:@"background2"]];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
        self.light.width = self.light.height;
}



@end
