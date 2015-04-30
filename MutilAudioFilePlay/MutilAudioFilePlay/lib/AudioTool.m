//
//  AudioTool.m
//  AudioSample
//
//  Created by iOSDeveloper-zy on 15-4-28.
//
//

#import "AudioTool.h"
#import <AudioToolbox/AudioToolbox.h>





@implementation AudioTool


+ (double)getAudioDurationWithFileName:(NSURL *)fileUrl
{
    OSStatus						err = noErr;
    ExtAudioFileRef					extRef = NULL;

    // Open a file with ExtAudioFileOpen()
    err = ExtAudioFileOpenURL((__bridge CFURLRef)fileUrl, &extRef);

    AudioFileID audioID;
    UInt32 audioIDSize = sizeof(audioID);
    err = ExtAudioFileGetProperty(extRef, kExtAudioFileProperty_AudioFile, &audioIDSize, &audioID);

    double soundDuration;
    UInt32 durationSize = sizeof(soundDuration);
    err = AudioFileGetProperty(audioID, kAudioFilePropertyEstimatedDuration, &durationSize, &soundDuration);

    return soundDuration;
}

+ (NSString *)getErrorMeessge:(int)errorCode
{
    switch (errorCode) {
        case -1:
            return @"没找到音频文件";
            break;
        case -2:
            return @"";
            break;

        default:
            return @"";
            break;
    }
}
@end
