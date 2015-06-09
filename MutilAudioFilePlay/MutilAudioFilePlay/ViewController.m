//
//  ViewController.m
//  MutilAudioFilePlay
//
//  Created by iOSDeveloper-zy on 15-4-28.
//  Copyright (c) 2015年 usc. All rights reserved.
//

#import "ViewController.h"
#import "ALPlay.h"

@interface ViewController ()<ALPlayDelegate>

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *timeProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *bgVolume;
@property (weak, nonatomic) IBOutlet UIProgressView *volumeProgressView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UISlider *bgSlider;
@property (weak, nonatomic) IBOutlet UISlider *effectSlider;

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong) NSURL *bgUrl;
@property (nonatomic,strong) NSURL *url;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;

// 播放两个音频文件，创建两个播放器
@property (nonatomic,strong) ALPlay *player;
@property (nonatomic,strong) ALPlay *anthorPlayer;

@end

@implementation ViewController

- (IBAction)offsetSet:(id)sender {
    
    NSLog(@"slider value =%f",((UISlider *)sender).value);
    [self.player setOffset:((UISlider *)sender).value];
    [self.player setOffset:((UISlider *)sender).value];
}

- (IBAction)stopPlay:(id)sender {
    
    [self.player stop];
    [self.anthorPlayer stop];
}

- (void)viewDidLoad {

    [super viewDidLoad];

//    self.player = [[ALPlay alloc]initWithSoundFile:@"main.mp3" doesLoop:NO];
    self.anthorPlayer = [[ALPlay alloc]initWithSoundFile:@"effect.mp3" doesLoop:NO];
//    self.player.delegate = self;
    self.anthorPlayer.delegate = self;

    // 播放
//    [self.player play];
    [self.anthorPlayer play];
}

//- (void)bgSliderMove:(id)sender
//{
//    NSLog(@"slider value =%f",((UISlider *)sender).value);
//    [self.player setOffset:((UISlider *)sender).value];
//    [self.player setOffset:((UISlider *)sender).value];
//}

- (void)setupAudioFile
{
   NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];

    self.bgUrl = [NSURL URLWithString:[document stringByAppendingPathComponent:@"bgMusic.mp3"]];
    self.url = [NSURL URLWithString:[document stringByAppendingPathComponent:@"main.mp3"]];
}

static int i = 1;

- (IBAction)pauseBtnClick:(id)sender
{
    i  = i > 0  ? 0 : 1 ;

    if (!i) {
//        [self.soundMgr pauseBackgroundMusic];
//        [self.soundMgr pauseSoundWithID:0];
//        [self.player pause];
        [self.anthorPlayer pause];

    }
    else
    {
//        [self.soundMgr resumeBackgroundMusic];
//        [self.soundMgr playSoundWithID:0];
        [self.anthorPlayer resume];
//        [self.anthorPlayer playWithOffset:0.5];
//        [self.anthorPlayer play];
    }
}


- (IBAction)effectVolumeChange:(id)sender {

    [self.anthorPlayer setVolume:((UISlider *)sender).value];
}

- (IBAction)btn:(id)sender {

    [self.anthorPlayer setOffset:0.5];
}

- (BOOL)stopMutiPlay
{
//    [soundMgr stopBackgroundMusic];
//    [soundMgr stopSoundWithID:1];

    [self.timer invalidate];
    self.timer =  nil;
    return YES;
}

- (void)playStop:(id)player
{

    NSLog(@"终于播放停止了=%d--%@",[player getSourceStatus],[NSThread currentThread]);
    [self.anthorPlayer stop];
    [self.player stop];
}

- (void)onEnd:(NSError *)error
{
    NSLog(@"error:%@",error.domain);
}

@end
