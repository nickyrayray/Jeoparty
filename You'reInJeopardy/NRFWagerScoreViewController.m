//
//  NRFWagerScoreViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/2/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFWagerScoreViewController.h"

@interface NRFWagerScoreViewController ()

@end

@implementation NRFWagerScoreViewController

-(id)initWithGame:(NRFJeopardyGamePlayable *)game
{
    self = [super initWithGame:game];
    return self;
}

-(void)loadView
{
    [super loadView];
    self.contestantOneWagerLabel = [self createWagerLabeWithFrame:CGRectMake(20, 133, 301, 78) forContestant:self.game.contestantOne];
    self.contestantTwoWagerLabel = [self createWagerLabeWithFrame:CGRectMake(362, 133, 301, 78) forContestant:self.game.contestantTwo];
    self.contestantThreeWagerLabel = [self createWagerLabeWithFrame:CGRectMake(703, 133, 301, 78) forContestant:self.game.contestantThree];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.contestantOneWagerLabel];
    [self.view addSubview:self.contestantTwoWagerLabel];
    [self.view addSubview:self.contestantThreeWagerLabel];
}

- (void)contestantOnePlusButtonPressed:(id)sender {
    int valueToAdd = [self getIntValueFromLabel:[self.contestantOneIncrementValueSegment titleForSegmentAtIndex:self.contestantOneIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantOne increaseWagerBy:valueToAdd];
    self.contestantOneScore.text = [self createWagerStringFromValue:self.game.contestantOne.score];
}

- (void)contestantOneMinusButtonPressed:(id)sender {
    int valueToSubtract = [self getIntValueFromLabel:[self.contestantOneIncrementValueSegment titleForSegmentAtIndex:self.contestantOneIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantOne decreaseWagerBy:valueToSubtract];
    self.contestantOneScore.text = [self createWagerStringFromValue:self.game.contestantOne.score];
}

- (void)contestantTwoPlusButtonPressed:(id)sender {
    int valueToAdd = [self getIntValueFromLabel:[self.contestantTwoIncrementValueSegment titleForSegmentAtIndex:self.contestantTwoIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantTwo increaseWagerBy:valueToAdd];
    self.contestantTwoScore.text = [self createWagerStringFromValue:self.game.contestantTwo.score];
}

- (void)contestantTwoMinusButtonPressed:(id)sender {
    int valueToSubtract = [self getIntValueFromLabel:[self.contestantTwoIncrementValueSegment titleForSegmentAtIndex:self.contestantTwoIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantTwo decreaseWagerBy:valueToSubtract];
    self.contestantTwoScore.text = [self createWagerStringFromValue:self.game.contestantTwo.score];
}

- (void)contestantThreePlusButtonPressed:(id)sender {
    int valueToAdd = [self getIntValueFromLabel:[self.contestantThreeIncrementValueSegment titleForSegmentAtIndex:self.contestantThreeIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantThree increaseWagerBy:valueToAdd];
    self.contestantThreeScore.text = [self createWagerStringFromValue:self.game.contestantThree.score];
}

- (void)contestantThreeMinusButtonPressed:(id)sender {
    int valueToSubtract = [self getIntValueFromLabel:[self.contestantThreeIncrementValueSegment titleForSegmentAtIndex:self.contestantThreeIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantThree decreaseWagerBy:valueToSubtract];
    self.contestantThreeScore.text = [self createWagerStringFromValue:self.game.contestantThree.score];
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

-(NSString *)createWagerStringFromValue:(int)value
{
    return [NSString stringWithFormat:@"Wager: %@", [self stringifyAndAddDollarSignToNumber:value]];
}

@end
