//
//  ALPlay.m
//  MutilAudioFilePlay
//
//  Created by iOSDeveloper-zy on 15-4-28.
//  Copyright (c) 2015年 usc. All rights reserved.
//

#import "ALPlay.h"
#import "AppleOpenALSupport.h"
#import "AudioTool.h"

@interface ALPlay()<ALPlayDelegate>
{
    ALvoid *_bufferData;
    ALdouble _duration;
    ALuint _bufferID;
    ALuint _sourceID;
    ALenum _error;
    ALfloat _volume;

    // 表示当前播放状态
    ALPlayStatus _status;

    NSURL *_fileUrl;
}

@property (nonatomic,strong) NSTimer *timer;
@end

@implementation ALPlay

#pragma mark - public method

- (id)initWithSoundFile:(NSString *)file doesLoop:(BOOL)loops
{
    if (self = [super init]) {

        _sourceID = 0;
        _bufferID = 0;

        NSString *doucumentFile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [doucumentFile stringByAppendingPathComponent:file];
        NSURL *fileUrl = [NSURL URLWithString:filePath];
        _fileUrl = fileUrl;
        NSLog(@"fileurl = %@",fileUrl);

        [self loadFile];
    }
    return self;
}

- (void)loadFile
{
    ALenum  format;
    ALsizei size;
    ALsizei freq;

    int openStatus;
    _bufferData = MyGetOpenALAudioData((__bridge CFURLRef)_fileUrl, &size, &format, &freq, &_duration,&openStatus);
    if (openStatus != 0 && [self.delegate respondsToSelector:@selector(onEnd:)]) {
        NSError *error = [NSError errorWithDomain:[AudioTool getErrorMeessge:openStatus] code:openStatus userInfo:nil];
        [self.delegate onEnd:error];
    }

    // grab a buffer ID from openAL
    alGenBuffers(1, &_bufferID);
    NSLog(@"bufferID = %d",_bufferID);

    alBufferDataStaticProc(_bufferID, format, _bufferData, size, freq);

    // grab a source ID from openAL, this will be the base source ID
    alGenSources(1, &_sourceID);
    NSLog(@"sourceId = %d",_sourceID);

    // attach the buffer to the source
    alSourcei(_sourceID, AL_BUFFER, _bufferID);
}

- (BOOL)isPlaying
{
    ALenum state;
    alGetSourcei(_sourceID, AL_SOURCE_STATE, &state);

    return (state == AL_PLAYING);
}

- (BOOL)playWithOffset:(float)offset
{
//
//#ifdef USE
//    [self releaseResource];
//    [self loadFile];
//#endif
//

    ALint iTotal = 0;
    ALint iCurrent = 0;
    ALint uiBuffer = 0;
    alGetSourcei(_sourceID, AL_BUFFER, &uiBuffer);
    alGetBufferi(uiBuffer, AL_SIZE, &iTotal);
    iCurrent = iTotal * offset;

    alSourcei(_sourceID, AL_BYTE_OFFSET, iCurrent);
    alSourcePlay(_sourceID);
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkIsStop) userInfo:nil repeats:YES];
    return ((_error = alGetError()) != AL_NO_ERROR);
}

- (BOOL)resume
{
    if ([self getSourceStatus] == ALPlayStatus_Paused)
    {
      alSourcePlay(_sourceID);
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
      self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkIsStop) userInfo:nil repeats:YES];
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
    if (self.timer) {
        [self.timer invalidate];
    }

    return ((_error = alGetError()) != AL_NO_ERROR);
}

- (BOOL)stop
{
    alSourceStop(_sourceID);
    _status = ALPlayStatus_Stoped;
    if (self.timer) {
        [self.timer invalidate];
    }

    return ((_error = alGetError()) != AL_NO_ERROR);
}

- (BOOL)setOffset:(float)offset
{
    ALint iTotal = 0;
    ALint iCurrent = 0;
    ALint uiBuffer = 0;
    alGetSourcei(_sourceID, AL_BUFFER, &uiBuffer);
    alGetBufferi(uiBuffer, AL_SIZE, &iTotal);
    iCurrent = iTotal * offset;

    alSourcei(_sourceID, AL_BYTE_OFFSET, iCurrent);

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
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkIsStop) userInfo:nil repeats:YES];
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

#pragma mark -


#pragma  mark - private method
- (void)checkIsStop
{
//    NSLog(@"check status:%d--%@",[self getSourceStatus],[NSThread currentThread]);
    if([self getSourceStatus] == ALPlayStatus_Stoped && [self.delegate respondsToSelector:@selector(playStop:)]) {
        [self.timer invalidate];
        [self.delegate playStop:self];
    }
}

- (void)releaseResource
{
    if (_sourceID != 0) {
        alSourcei(_sourceID, AL_BUFFER, 0);
        alDeleteSources(1, &_sourceID);
    }
    if (_bufferID != 0) {
        alDeleteBuffers(1, &_bufferID);
    }

    if (_bufferData) {

        free(_bufferData);
        _bufferData = NULL;
    }
}

-(void)dealloc
{
    [self releaseResource];
}
@end
