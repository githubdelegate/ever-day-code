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

- (BOOL)pause
{
    alSourcePause(_sourceID);
    return ((_error = alGetError()) != AL_NO_ERROR);
}

- (BOOL)play
{
    if ([self isPlaying]) {

    }else
    {
        alSourcePlay(_sourceID);
    }
    return ((_error = alGetError()) != AL_NO_ERROR);
}

@end
