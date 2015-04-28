//
//  AudioTool.h
//  AudioSample
//
//  Created by iOSDeveloper-zy on 15-4-28.
//
//

#import <Foundation/Foundation.h>

#define kMin(x,y)  x > y ? y : x

@interface AudioTool : NSObject

+ (double)getAudioDurationWithFileName:(NSURL *)fileUrl;
@end
