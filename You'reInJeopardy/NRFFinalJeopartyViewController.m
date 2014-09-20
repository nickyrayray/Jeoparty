//
//  NRFFinalJeopartyViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/19/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFFinalJeopartyViewController.h"

@interface NRFFinalJeopartyViewController ()<NRFQuestionScoreViewControllerDelegate>

@property (strong, nonatomic) NRFJeopardyGamePlayable *game;
@property (strong, nonatomic) NRFFinalJeopartyQuestion *question;
@property (strong, nonatomic) UIButton *displayButton;

@end

@implementation NRFFinalJeopartyViewController

- (id)initWithFinalJeopartyQuestion:(NRFFinalJeopartyQuestion *)question andGame:(NRFJeopardyGamePlayable *)game;
{
    self = [super init];
    if(self){
        self.question = question;
        self.game = game;
    }
    return self;
}

-(void)loadView
{
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screen = [[UIScreen alloc]applicationFrame];
    UIButton *button = [[UIButton alloc]initWithFrame:screen];
    button.titleLabel.font = [UIFont systemFontOfSize:70.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:self.question.category forState:UIControlStateNormal];
    [button addTarget:self action:@selector(categoryAcknowledged:) forControlEvents:UIControlEventTouchUpInside];
    self.displayButton = button;
    [self.view addSubview:button];
}

-(void)categoryAcknowledged:(id)sender
{
    NRFWagerScoreViewController *wagerVC = [[NRFWagerScoreViewController alloc]initWithGame:self.game];
    wagerVC.delegate = self;
    [self.navigationController pushViewController:wagerVC animated:YES];
}

-(void)questionScoreViewControllerDidFinish
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.displayButton setTitle:self.question.question forState:UIControlStateNormal];
    [self.displayButton removeTarget:self action:@selector(categoryAcknowledged:) forControlEvents:UIControlEventTouchUpInside];
    [self.displayButton addTarget:self action:@selector(answerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)answerButtonPressed:(id)sender
{
    NRFWagerRewardScoreViewController *wagerRewardVC = [[NRFWagerRewardScoreViewController alloc]initWithGame:self.game];
    wagerRewardVC.delegate = self;
    [self.navigationController pushViewController:wagerRewardVC animated:YES];
}

@end
