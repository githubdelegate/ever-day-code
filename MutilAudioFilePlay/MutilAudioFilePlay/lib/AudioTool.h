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

/*!
 *  @author usc_zy, 15-04-29 18:04:14
 *
 *  @brief  获取一段音频文件的播放长度
 *
 *  @param fileUrl 文件url
 *
 *  @return 音频文件播放长度
 */
+ (double)getAudioDurationWithFileName:(NSURL *)fileUrl;


+ (NSString *)getErrorMeessge:(int)errorCode;
@end
