//
//  crash.m
//  demo
//
//  Created by zy on 14/12/24.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "crash.h"

@implementation crash
void uncaughtException(NSException *exception)
{
    NSArray *stackArray = [exception callStackSymbols];
    
    NSString *name = [exception name];
    
    NSString *reason = [exception reason];
    
    
    NSString *info = [NSString stringWithFormat:@"exception name:%@\n exception reason:%@\n exception stack:%@",name,reason,stackArray];

    
    NSLog(@"info = %@",info);

}
@end
