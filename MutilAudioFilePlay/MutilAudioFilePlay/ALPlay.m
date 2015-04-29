//
//  ALPlay.m
//  MutilAudioFilePlay
//
//  Created by iOSDeveloper-zy on 15-4-28.
//  Copyright (c) 2015年 usc. All rights reserved.
//

#import "ALPlay.h"
#import "AppleOpenALSupport.h"

@interface ALPlay()
{
    ALvoid *_bufferData;
    ALdouble _duration;
    ALuint _bufferID;
    ALuint _sourceID;
    ALenum _error;
    ALfloat _volume;

    // 表示当前播放状态
    ALPlayStatus _status;
}
@end

@implementation ALPlay

- (id)initWithSoundFile:(NSString *)file doesLoop:(BOOL)loops
{
    if (self = [super init]) {

        ALenum  format;
        ALsizei size;
        ALsizei freq;

        NSString *doucumentFile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [doucumentFile stringByAppendingPathComponent:file];
        NSURL *fileUrl = [NSURL URLWithString:filePath];
        NSLog(@"fileurl = %@",fileUrl);

        _bufferData = MyGetOpenALAudioData((__bridge CFURLRef)fileUrl, &size, &format, &freq, &_duration);

        // grab a buffer ID from openAL
        alGenBuffers(1, &_bufferID);

        alBufferDataStaticProc(_bufferID, format, _bufferData, size, freq);

        // grab a source ID from openAL, this will be the base source ID
        alGenSources(1, &_sourceID);
        NSLog(@"sourceId = %d",_sourceID);
        
        // attach the buffer to the source
        alSourcei(_sourceID, AL_BUFFER, _bufferID);
    }
    return self;
}

- (BOOL)isPlaying
{
    ALenum state;
    alGetSourcei(_sourceID, AL_SOURCE_STATE, &state);

    return (state == AL_PLAYING);
}

- (BOOL)playWithOffset:(float)offset
{
    if ([self isPlaying]) {
        [self stop];
    }

    ALint itotal;
    ALint icurrent;
    alGetBufferi(_bufferID, AL_SIZE, &itotal);
    icurrent = itotal * offset;
    alSourcei(_sourceID, AL_BYTE_OFFSET, icurrent);
    alSourcePlay(_sourceID);
    return ((_error = alGetError()) != AL_NO_ERROR);
}

- (BOOL)resume
{
    if ([self getSourceStatus] == ALPlayStatus_Paused)
    {
      alSourcePlay(_sourceID);
      return YES;
    }
    return NO;
}

// 只有当有音频正在播放的时候，调用这个方法才会返回yes，其他情况全部返回no
- (BOOL)pause
{
    if ([self getSourceStatus] != ALPlayStatus_Playing) {
        return NO;
    }
    alSourcePause(_sourceID);
    _status = ALPlayStatus_Paused;
    return ((_error = alGetError()) != AL_NO_ERROR);
}

- (BOOL)stop
{
    alSourceStop(_sourceID);
    _status = ALPlayStatus_Stoped;
    return ((_error = alGetError()) != AL_NO_ERROR);
}

- (BOOL)play
{
    if([self isPlaying]) {
        return NO;
    }
    else
    {
        alSourcePlay(_sourceID);
        _status = ALPlayStatus_Playing;
    }
    return ((_error = alGetError()) != AL_NO_ERROR);
}

- (ALPlayStatus)getSourceStatus
{
    ALPlayStatus playerStatus;
    ALint status;
    alGetSourcei(_sourceID, AL_SOURCE_STATE, &status);
    switch (status) {
        case AL_INITIAL:
            playerStatus = ALPlayStatus_Inital;
            break;
        case AL_PLAYING:
            playerStatus = ALPlayStatus_Playing;
            break;
        case AL_PAUSED:
            playerStatus = ALPlayStatus_Paused;
            break;
        case AL_STOPPED:
            playerStatus = ALPlayStatus_Stoped;
            break;
        default:
            playerStatus = ALPlayStatus_Stoped;
            break;
    }
    return playerStatus;
}

- (BOOL)setVolume:(float)newVolume
{
    _volume = MAX(MIN(newVolume, 1.0f), 0.0f); //cap to 0-1
    alSourcef(_sourceID, AL_GAIN, _volume);
    return ((_error = alGetError()) != AL_NO_ERROR);
}

@end
