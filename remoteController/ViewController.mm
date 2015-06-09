//
//  ViewController.m
//  remoteController
//
//  Created by zy on 15/6/7.
//  Copyright (c) 2015年 adolph. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <ZXingWidgetController.h>
#import <QRCodeReader.h>
#import "HomeViewController.h"

@interface ViewController ()<ZXingDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conBtnToBotton;
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.connectBtn setBackgroundImage:[UIImage imageWithName:@"connectionBtn"] forState:UIControlStateNormal];
    [self.connectBtn setSize:self.connectBtn.currentBackgroundImage.size];
    [self.connectBtn addTarget:self action:@selector(connectionDevice:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - IBAction
- (void)setBtnOnClick:(id)sender
{

}

- (void)connectionDevice:(id)sender
{
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];

    widController.readers = readers;

    
    
    HomeViewController *hVC = [[HomeViewController alloc]init];
    [self.navigationController pushViewController:hVC animated:YES];
    
//    [self presentViewController:widController animated:YES completion:^{
//        
//    }];
}


#pragma mark - zxing Delegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result
{
    RCLog(@"扫描结果：%@",result);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    HomeViewController *hVC = [[HomeViewController alloc]init];
    [self.navigationController pushViewController:hVC animated:YES];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    HomeViewController *hVC = [[HomeViewController alloc]init];
    [self.navigationController pushViewController:hVC animated:YES];

}

@end
