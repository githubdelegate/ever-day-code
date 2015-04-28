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

@interface ALPlay : NSObject
@property (nonatomic, readonly) ALenum error;
@property (nonatomic, readonly) ALdouble duration;
@property (nonatomic) ALfloat volume;
@property (nonatomic) ALfloat pitch;
@property (nonatomic, copy, readonly) NSString *sourceFileName;

- (id)initWithSoundFile:(NSString *)file doesLoop:(BOOL)loops;

- (BOOL) play;
- (BOOL) stop;
- (BOOL) pause;
- (BOOL)resume;
- (BOOL) rewind;
- (BOOL) isPlaying;
- (BOOL) isAnyPlaying;
@end
