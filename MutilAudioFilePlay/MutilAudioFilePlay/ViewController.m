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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *timeProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *bgVolume;
@property (weak, nonatomic) IBOutlet UIProgressView *volumeProgressView;
@property (weak, nonatomic) IBOutlet UIButton *btn;


@property (nonatomic, retain) CMOpenALSoundManager *soundMgr;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong) NSURL *bgUrl;
@property (nonatomic,strong) NSURL *url;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;

@property (nonatomic,strong) ALPlay *player;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.soundMgr = [[CMOpenALSoundManager alloc] init];
//    self.soundMgr.soundFileNames =  [NSArray arrayWithObjects:@"main.mp3",@"effect.mp3",nil];


//    [self setupAudioFile];

//    [self.soundMgr playSoundWithID:0];


    self.player = [[ALPlay alloc]initWithSoundFile:@"main.mp3" doesLoop:NO];
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

- (IBAction)pauseBtnClick:(id)sender {
    i  = i > 0  ? 0 : 1 ;

    if (!i) {
//        [self.soundMgr pauseBackgroundMusic];
//        [self.soundMgr pauseSoundWithID:0];
        [self.player pause];
    }
    else
    {
//        [self.soundMgr resumeBackgroundMusic];
//        [self.soundMgr playSoundWithID:0];
        [self.player play];
    }


}

- (IBAction)btn:(id)sender {

//    self.timer = [NSTimer scheduledTimerWithTimeInterval:[self shortDurationWithFile:nil andFile:nil] target:self selector:@selector(stopMutiPlay) userInfo:nil repeats:NO];

    [self.soundMgr playBackgroundMusic:self.bgUrl];
    [self.soundMgr playSoundWithID:0];
}

- (BOOL)stopMutiPlay
{
//    [soundMgr stopBackgroundMusic];
//    [soundMgr stopSoundWithID:1];

    [self.timer invalidate];
    self.timer =  nil;
    return YES;
}

@end
