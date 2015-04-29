//
//  ALPlay.h
//  MutilAudioFilePlay
//
//  Created by iOSDeveloper-zy on 15-4-28.
//  Copyright (c) 2015年 usc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

typedef enum {
    ALPlayStatus_Inital,
    ALPlayStatus_Playing,
    ALPlayStatus_Paused,
    ALPlayStatus_Stoped
}ALPlayStatus;

@interface ALPlay : NSObject

/*!
 *  @author usc_zy, 15-04-29 15:04:23
 *
 *  @brief  根据文件名加载音频文件
 *   注意：根据文件名拼接document文件夹路径，去加载文件。
 *  @param file  文件名
 *  @param loops 是否循环播放
 *
 */
- (id)initWithSoundFile:(NSString *)file doesLoop:(BOOL)loops;

/*!
 *
 *  @brief  播放
 *
 */
- (BOOL) play;

/*!
 *
 *  @brief  停止播放
 *
 */
- (BOOL) stop;

/*!
 *
 *  @brief  暂停播放
 *
 */
- (BOOL) pause;

/*!
 *
 *  @brief  恢复播放
 *
 */
- (BOOL) resume;

/*!
 *
 *  @brief  重新开始播放
 *
 */
- (BOOL) rewind;

/*!
 *
 *  @brief  是否正在播放
 *
 */
- (BOOL) isPlaying;
/*!
 *
 *  @brief  跳到指定比例内容播放
 *
 *  @param offset 0-1
 *
 */
- (BOOL)playWithOffset:(float)offset;

/*!
 *
 *  @brief  设置音量
 *
 *  @param newVolume 最新的音量
 *
 *  @return
 */
- (BOOL)setVolume:(float)newVolume;

/*!
 *
 *  @brief  获取当前状态
 */
- (ALPlayStatus)getSourceStatus;
@end
