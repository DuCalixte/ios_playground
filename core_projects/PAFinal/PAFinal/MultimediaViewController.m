//
//  MultimediaViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/12/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "MultimediaViewController.h"

@interface MultimediaViewController ()
{
    
    AVAudioPlayer *audioPlayer;
    MPMoviePlayerViewController *viewController;
}

@end

@implementation MultimediaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self mp3DidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mp3DidLoad
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"20th_hq" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.delegate = nil;
}

-(void)mp4DidLoad
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"black_bear_fishing" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    viewController = [[MPMoviePlayerViewController alloc] initWithContentURL:url ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)play_video_button:(id)sender {
    [self mp4DidLoad];
    [self presentMoviePlayerViewControllerAnimated:viewController];
}

- (IBAction)play_audio_button:(id)sender {
    if (audioPlayer.isPlaying){
        [audioPlayer stop];
    }
    else // I choose to pause the play causing to behave like a toggle.
    {
        [audioPlayer play];
    }
}
@end
