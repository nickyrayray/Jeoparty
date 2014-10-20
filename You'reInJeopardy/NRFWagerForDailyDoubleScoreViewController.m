//
//  NRFWagerForDailyDoubleScoreViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/3/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFWagerForDailyDoubleScoreViewController.h"

@interface NRFWagerForDailyDoubleScoreViewController ()

@property (strong, nonatomic) UIButton *firstContestantSelectionButton;
@property (strong, nonatomic) UIButton *secondContestantSelectionButton;
@property (strong, nonatomic) UIButton *thirdContestantSelectionButton;

@end

@implementation NRFWagerForDailyDoubleScoreViewController

- (id)initWithGame:(NRFJeopardyGamePlayable *)game
{
    self = [super initWithGame:game];
    return self;
}

-(void)loadView
{
    [super loadView];
    CGRect appScreen = [[UIScreen mainScreen]applicationFrame];
    self.firstContestantSelectionButton = [self createSelectButtonWithFrame:CGRectMake(0, 0, appScreen.size.height/3, appScreen.size.width) forContestant:self.game.contestantOne];
    self.secondContestantSelectionButton = [self createSelectButtonWithFrame:CGRectMake(appScreen.size.height/3 + 1, 0, appScreen.size.height/3, appScreen.size.width) forContestant:self.game.contestantTwo];
    self.thirdContestantSelectionButton = [self createSelectButtonWithFrame:CGRectMake((appScreen.size.height/3) * 2 + 2, 0, appScreen.size.height/3, appScreen.size.width) forContestant:self.game.contestantThree];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.firstContestantSelectionButton];
    [self.view addSubview:self.secondContestantSelectionButton];
    [self.view addSubview:self.thirdContestantSelectionButton];
    self.navigationItem.title = @"Select Contestant Who Chose Daily Double";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
}

-(void)contestantSelected:(id)sender
{
    if(sender == self.firstContestantSelectionButton){
        [self removeAllWagerEditSubviewsForAllContestantsExcept:self.game.contestantOne];
        self.navigationItem.title = [NSString stringWithFormat:@"Enter Wager for %@", self.game.contestantOne.name];
    }else if(sender == self.secondContestantSelectionButton){
        [self removeAllWagerEditSubviewsForAllContestantsExcept:self.game.contestantTwo];
        self.navigationItem.title = [NSString stringWithFormat:@"Enter Wager for %@", self.game.contestantTwo.name];
    }else{
        [self removeAllWagerEditSubviewsForAllContestantsExcept:self.game.contestantThree];
        self.navigationItem.title = [NSString stringWithFormat:@"Enter Wager for %@", self.game.contestantThree.name];
    }
    
    [self.firstContestantSelectionButton removeFromSuperview];
    [self.secondContestantSelectionButton removeFromSuperview];
    [self.thirdContestantSelectionButton removeFromSuperview];
}

-(void)doneButtonPressed:(id)sender
{
    [self.delegate wagerForDailyDoubleScoreViewControllerDidFinish];
}

- (void)contestantOnePlusButtonPressed:(id)sender {
    int valueToAdd = [self getIntValueFromLabel:[self.contestantOneIncrementValueSegment titleForSegmentAtIndex:self.contestantOneIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantOne increaseDailyDoubleWagerBy:valueToAdd];
    self.contestantOneWagerLabel.text = [self createWagerStringFromValue:self.game.contestantOne.wager];
}

- (void)contestantOneMinusButtonPressed:(id)sender {
    int valueToSubtract = [self getIntValueFromLabel:[self.contestantOneIncrementValueSegment titleForSegmentAtIndex:self.contestantOneIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantOne decreaseDailyDoubleWagerBy:valueToSubtract];
    self.contestantOneWagerLabel.text = [self createWagerStringFromValue:self.game.contestantOne.wager];
}

- (void)contestantTwoPlusButtonPressed:(id)sender {
    int valueToAdd = [self getIntValueFromLabel:[self.contestantTwoIncrementValueSegment titleForSegmentAtIndex:self.contestantTwoIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantTwo increaseDailyDoubleWagerBy:valueToAdd];
    self.contestantTwoWagerLabel.text = [self createWagerStringFromValue:self.game.contestantTwo.wager];
}

- (void)contestantTwoMinusButtonPressed:(id)sender {
    int valueToSubtract = [self getIntValueFromLabel:[self.contestantTwoIncrementValueSegment titleForSegmentAtIndex:self.contestantTwoIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantTwo decreaseDailyDoubleWagerBy:valueToSubtract];
    self.contestantTwoWagerLabel.text = [self createWagerStringFromValue:self.game.contestantTwo.wager];
}

- (void)contestantThreePlusButtonPressed:(id)sender {
    int valueToAdd = [self getIntValueFromLabel:[self.contestantThreeIncrementValueSegment titleForSegmentAtIndex:self.contestantThreeIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantThree increaseDailyDoubleWagerBy:valueToAdd];
    self.contestantThreeWagerLabel.text = [self createWagerStringFromValue:self.game.contestantThree.wager];
}

- (void)contestantThreeMinusButtonPressed:(id)sender {
    int valueToSubtract = [self getIntValueFromLabel:[self.contestantThreeIncrementValueSegment titleForSegmentAtIndex:self.contestantThreeIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantThree decreaseDailyDoubleWagerBy:valueToSubtract];
    self.contestantThreeWagerLabel.text = [self createWagerStringFromValue:self.game.contestantThree.wager];
}


-(UIButton *)createSelectButtonWithFrame:(CGRect)frame forContestant:(NRFJeopartyContestant *)contestant
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.titleLabel.font = [UIFont fontWithName:@"Chalkboard SE" size:60];
    button.titleLabel.numberOfLines = 4;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:contestant.name forState:UIControlStateNormal];
    [button addTarget:self action:@selector(contestantSelected:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)removeAllWagerEditSubviewsForAllContestantsExcept:(NRFJeopartyContestant *)contestant
{
    if(contestant == self.game.contestantOne || contestant == self.game.contestantTwo){
        [self.contestantThreePlus removeFromSuperview];
        [self.contestantThreeMinus removeFromSuperview];
        [self.contestantThreeIncrementValueSegment removeFromSuperview];
        [self.contestantThreeWagerLabel removeFromSuperview];
    }
    
    if(contestant == self.game.contestantOne || contestant == self.game.contestantThree){
        [self.contestantTwoPlus removeFromSuperview];
        [self.contestantTwoMinus removeFromSuperview];
        [self.contestantTwoIncrementValueSegment removeFromSuperview];
        [self.contestantTwoWagerLabel removeFromSuperview];
    }
    
    if(contestant == self.game.contestantTwo || contestant == self.game.contestantThree){
        [self.contestantOnePlus removeFromSuperview];
        [self.contestantOneMinus removeFromSuperview];
        [self.contestantOneIncrementValueSegment removeFromSuperview];
        [self.contestantOneWagerLabel removeFromSuperview];
    }
}

@end
