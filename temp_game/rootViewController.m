//
//  rootViewController.m
//  temp_game
//
//  Created by 海野 竜也 on 2014/09/11.
//  Copyright (c) 2014年 海野 竜也. All rights reserved.
//

#import "rootViewController.h"
#import "MySceneTop.h"



@interface rootViewController (){
}
@property (weak, nonatomic) IBOutlet UILabel *titleName;
- (IBAction)soundFlg:(UISwitch *)sender;
@end

@implementation rootViewController

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError* error;
    NSURL* bgmURL = [[NSBundle mainBundle]URLForResource:@"ani_ge_mos01"withExtension:@"mp3"];
    self.bgmPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:&error];
    self.bgmPlayer.numberOfLoops = -1;                        
    _titleName.font = [UIFont fontWithName:@"Chalkduster" size:30];
    // Do any additional setup after loading the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MySceneTop sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)soundFlg:(UISwitch *)sender {
    if(sender.on==YES){
        [self.bgmPlayer prepareToPlay];
        [self.bgmPlayer play];
        flg=true;
    }else{
        [self.bgmPlayer pause];
        flg=false;
    }
}

@end
