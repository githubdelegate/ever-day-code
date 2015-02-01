//
//  crash.h
//  demo
//
//  Created by zy on 14/12/24.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface crash : NSObject
void uncaughtException(NSException *exception);
@end
