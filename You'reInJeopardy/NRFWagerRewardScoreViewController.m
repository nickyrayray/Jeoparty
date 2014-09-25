//
//  NRFWagerRewardScoreViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/3/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFWagerRewardScoreViewController.h"

@interface NRFWagerRewardScoreViewController ()

@end

@implementation NRFWagerRewardScoreViewController

- (id)initWithGame:(NRFJeopardyGamePlayable *)game
{
    self = [super initWithGame:game];
    return self;
}

-(void)loadView
{
    [super loadView];
    if(self.game.contestantOne.wager != -1){
        self.contestantOneWagerLabel = [self createWagerLabeWithFrame:CGRectMake(20, 133, 301, 78) forContestant:self.game.contestantOne];
        self.contestantOnePlus = [self createContestantPlusButtonWithFrame:CGRectMake(20, 518, 100, 100)];
        self.contestantOneMinus = [self createContestantMinusButtonWithFrame:CGRectMake(221, 518, 100, 100)];
        [self.contestantOnePlus addTarget:self action:@selector(contestantOnePlusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contestantOneMinus addTarget:self action:@selector(contestantOneMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(self.game.contestantTwo.wager != -1){
        self.contestantTwoWagerLabel = [self createWagerLabeWithFrame:CGRectMake(362, 133, 301, 78) forContestant:self.game.contestantTwo];
        self.contestantTwoPlus = [self createContestantPlusButtonWithFrame:CGRectMake(362, 518, 100, 100)];
        self.contestantTwoMinus = [self createContestantMinusButtonWithFrame:CGRectMake(563, 518, 100, 100)];
        [self.contestantTwoPlus addTarget:self action:@selector(contestantTwoPlusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contestantTwoMinus addTarget:self action:@selector(contestantTwoMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(self.game.contestantThree.wager != -1){
        self.contestantThreeWagerLabel = [self createWagerLabeWithFrame:CGRectMake(703, 133, 301, 78) forContestant:self.game.contestantThree];
        self.contestantThreePlus = [self createContestantPlusButtonWithFrame:CGRectMake(703, 518, 100, 100)];
        self.contestantThreeMinus = [self createContestantMinusButtonWithFrame:CGRectMake(904, 518, 100, 100)];
        [self.contestantThreePlus addTarget:self action:@selector(contestantThreePlusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contestantThreeMinus addTarget:self action:@selector(contestantThreeMinusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.contestantOnePlus];
    [self.view addSubview:self.contestantOneMinus];
    [self.view addSubview:self.contestantTwoPlus];
    [self.view addSubview:self.contestantTwoMinus];
    [self.view addSubview:self.contestantThreePlus];
    [self.view addSubview:self.contestantThreeMinus];
    [self.view addSubview:self.contestantOneWagerLabel];
    [self.view addSubview:self.contestantTwoWagerLabel];
    [self.view addSubview:self.contestantThreeWagerLabel];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

-(void)doneButtonPressed:(id)sender
{
    [self.delegate wagerRewardScoreViewControllerDelegateDidFinish];
}

- (void)contestantOnePlusButtonPressed:(id)sender {
    [self.game.contestantOne addThisAmountToContestantScore:self.game.contestantOne.wager];
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOne.score];
}

- (void)contestantOneMinusButtonPressed:(id)sender {
    [self.game.contestantOne subtractThisAmountFromContestantScore:self.game.contestantOne.wager];
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOne.score];
}

- (void)contestantTwoPlusButtonPressed:(id)sender {
    [self.game.contestantTwo addThisAmountToContestantScore:self.game.contestantTwo.wager];
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwo.score];
}

- (void)contestantTwoMinusButtonPressed:(id)sender {
    [self.game.contestantTwo subtractThisAmountFromContestantScore:self.game.contestantTwo.wager];
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwo.score];
}

- (void)contestantThreePlusButtonPressed:(id)sender {
    [self.game.contestantThree addThisAmountToContestantScore:self.game.contestantThree.wager];
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThree.score];
}

- (void)contestantThreeMinusButtonPressed:(id)sender {
    [self.game.contestantThree subtractThisAmountFromContestantScore:self.game.contestantThree.wager];
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThree.score];
}

-(UILabel *)createWagerLabeWithFrame:(CGRect)frame forContestant:(NRFJeopartyContestant *)contestant
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    if(contestant.wager != -1)
        label.text = [self createWagerStringFromValue:contestant.wager];
    else
        label.text = [self createWagerStringFromValue:0];
    return label;
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


-(NSString *)createWagerStringFromValue:(int)value
{
    return [NSString stringWithFormat:@"Wager: %@", [self stringifyAndAddDollarSignToNumber:value]];
}


@end
