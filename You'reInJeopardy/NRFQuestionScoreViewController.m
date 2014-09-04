//
//  NRFQuestionScoreViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/1/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestionScoreViewController.h"

@interface NRFQuestionScoreViewController ()

@end

@implementation NRFQuestionScoreViewController

- (id)initWithGame:(NRFJeopardyGamePlayable *)game andQuestion:(NRFQuestion *)question
{
    self = [super initWithGame:game];
    if(self){
        self.questionValue = question.value;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    self.contestantOnePlus = [self createContestantPlusButtonWithFrame:CGRectMake(20, 518, 100, 100)];
    self.contestantOneMinus = [self createContestantMinusButtonWithFrame:CGRectMake(221, 518, 100, 100)];
    self.contestantTwoPlus = [self createContestantPlusButtonWithFrame:CGRectMake(362, 518, 100, 100)];
    self.contestantTwoMinus = [self createContestantMinusButtonWithFrame:CGRectMake(563, 518, 100, 100)];
    self.contestantThreePlus = [self createContestantPlusButtonWithFrame:CGRectMake(703, 518, 100, 100)];
    self.contestantThreeMinus = [self createContestantMinusButtonWithFrame:CGRectMake(904, 518, 100, 100)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.contestantOnePlus addTarget:self action:@selector(contestantOnePlusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contestantOneMinus addTarget:self action:@selector(contestantOneMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contestantTwoPlus addTarget:self action:@selector(contestantTwoPlusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contestantTwoMinus addTarget:self action:@selector(contestantTwoMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contestantThreePlus addTarget:self action:@selector(contestantThreePlusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contestantThreeMinus addTarget:self action:@selector(contestantThreeMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.contestantOnePlus];
    [self.view addSubview:self.contestantOneMinus];
    [self.view addSubview:self.contestantTwoPlus];
    [self.view addSubview:self.contestantTwoMinus];
    [self.view addSubview:self.contestantThreePlus];
    [self.view addSubview:self.contestantThreeMinus];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"Increase/Decrease Scores According to Previous Question Results";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    
}

-(void)doneButtonPressed:(id)sender
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.delegate questionScoreViewControllerDidFinish];
}

- (void)contestantOnePlusButtonPressed:(id)sender {
    [self.game.contestantOne addThisAmountToContestantScore:self.questionValue];
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOne.score];
}

- (void)contestantOneMinusButtonPressed:(id)sender {
    [self.game.contestantOne subtractThisAmountFromContestantScore:self.questionValue];
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOne.score];
}

- (void)contestantTwoPlusButtonPressed:(id)sender {
    [self.game.contestantTwo addThisAmountToContestantScore:self.questionValue];
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwo.score];
}

- (void)contestantTwoMinusButtonPressed:(id)sender {
    [self.game.contestantTwo subtractThisAmountFromContestantScore:self.questionValue];
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwo.score];
}

- (void)contestantThreePlusButtonPressed:(id)sender {
    [self.game.contestantThree addThisAmountToContestantScore:self.questionValue];
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThree.score];
}

- (void)contestantThreeMinusButtonPressed:(id)sender {
    [self.game.contestantThree subtractThisAmountFromContestantScore:self.questionValue];
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThree.score];
}


-(UIButton *)createContestantPlusButtonWithFrame:(CGRect)frame
{
    
    UIButton *plusButton = [[UIButton alloc]initWithFrame:frame];
    plusButton.backgroundColor = [UIColor greenColor];
    plusButton.titleLabel.textColor = [UIColor whiteColor];
    plusButton.titleLabel.font = [UIFont boldSystemFontOfSize:65];
    [plusButton setTitle:@"+" forState:UIControlStateNormal];
    return plusButton;
    
}

-(UIButton *)createContestantMinusButtonWithFrame:(CGRect)frame
{
    UIButton *minusButton = [[UIButton alloc]initWithFrame:frame];
    minusButton.backgroundColor = [UIColor redColor];
    minusButton.titleLabel.textColor = [UIColor whiteColor];
    minusButton.titleLabel.font = [UIFont boldSystemFontOfSize:85];
    [minusButton setTitle:@"-" forState:UIControlStateNormal];
    return minusButton;
    
}

@end
