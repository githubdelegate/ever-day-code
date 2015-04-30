//
//  ViewController.m
//  MutilAudioFilePlay
//
//  Created by iOSDeveloper-zy on 15-4-28.
//  Copyright (c) 2015年 usc. All rights reserved.
//

#import "ViewController.h"
#import "CMOpenALSoundManager.h"
#import "ALPlay.h"

@interface ViewController ()<ALPlayDelegate>

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *timeProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *bgVolume;
@property (weak, nonatomic) IBOutlet UIProgressView *volumeProgressView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UISlider *bgSlider;
@property (weak, nonatomic) IBOutlet UISlider *effectSlider;

@property (nonatomic, retain) CMOpenALSoundManager *soundMgr;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong) NSURL *bgUrl;
@property (nonatomic,strong) NSURL *url;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;

@property (nonatomic,strong) ALPlay *player;

@property (nonatomic,strong) ALPlay *anthorPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.soundMgr = [[CMOpenALSoundManager alloc] init];
//    self.soundMgr.soundFileNames =  [NSArray arrayWithObjects:@"main.mp3",@"effect.mp3",nil];


//    [self setupAudioFile];

//    [self.soundMgr playSoundWithID:0];

//    [self.bgSlider addTarget:self action:@selector(bgSliderMove:) forControlEvents:UIControlEventEditingDidEnd];


    self.player = [[ALPlay alloc]initWithSoundFile:@"main.mp3" doesLoop:NO];
    self.anthorPlayer = [[ALPlay alloc]initWithSoundFile:@"effect.mp3" doesLoop:NO];
    self.player.delegate = self;
    self.anthorPlayer.delegate = self;

    [self.anthorPlayer play];
//    [self.player playWithOffset:0.4];
}

- (void)bgSliderMove:(id)sender
{
   NSLog(@"slider value =%f",((UISlider *)sender).value);

}

- (void)setupAudioFile
{
   NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
   self.soundMgr.soundFileNames = [NSArray arrayWithObjects:@"main.mp3",@"effect.mp3",@"bgMusic.mp3",nil];

    self.bgUrl = [NSURL URLWithString:[document stringByAppendingPathComponent:@"bgMusic.mp3"]];
    self.url = [NSURL URLWithString:[document stringByAppendingPathComponent:@"main.mp3"]];
}

static int i = 1;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   [self.soundMgr playSoundWithID:0];
}

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

- (IBAction)bgVolumeEdit:(id)sender {

    [self.anthorPlayer playWithOffset:0.6];
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
