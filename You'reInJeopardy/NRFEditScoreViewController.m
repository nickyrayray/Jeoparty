//
//  NRFEditScoreViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/1/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFEditScoreViewController.h"

@interface NRFEditScoreViewController ()

@end

@implementation NRFEditScoreViewController

- (id)initWithGame:(NRFJeopardyGamePlayable *)game
{
    self = [super initWithGame:game];
    return self;
}

-(void)loadView
{
    [super loadView];
    self.contestantOneIncrementValueSegment = [self createSegmentedControlWithFrame:CGRectMake(80, 663, 181, 29)];
    self.contestantTwoIncrementValueSegment = [self createSegmentedControlWithFrame:CGRectMake(422, 663, 181, 29)];
    self.contestantThreeIncrementValueSegment = [self createSegmentedControlWithFrame:CGRectMake(763, 663, 181, 29)];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.contestantOneIncrementValueSegment];
    [self.view addSubview:self.contestantTwoIncrementValueSegment];
    [self.view addSubview:self.contestantThreeIncrementValueSegment];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done Editing" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed:)];
    
}

-(void)doneButtonPressed:(id)sender
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)contestantOnePlusButtonPressed:(id)sender {
    int valueToAdd = [self getIntValueFromLabel:[self.contestantOneIncrementValueSegment titleForSegmentAtIndex:self.contestantOneIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantOne addThisAmountToContestantScore:valueToAdd];
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOne.score];
}

- (void)contestantOneMinusButtonPressed:(id)sender {
    int valueToSubtract = [self getIntValueFromLabel:[self.contestantOneIncrementValueSegment titleForSegmentAtIndex:self.contestantOneIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantOne subtractThisAmountFromContestantScore:valueToSubtract];
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOne.score];
}

- (void)contestantTwoPlusButtonPressed:(id)sender {
    int valueToAdd = [self getIntValueFromLabel:[self.contestantTwoIncrementValueSegment titleForSegmentAtIndex:self.contestantTwoIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantTwo addThisAmountToContestantScore:valueToAdd];
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwo.score];
}

- (void)contestantTwoMinusButtonPressed:(id)sender {
    int valueToSubtract = [self getIntValueFromLabel:[self.contestantTwoIncrementValueSegment titleForSegmentAtIndex:self.contestantTwoIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantTwo subtractThisAmountFromContestantScore:valueToSubtract];
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwo.score];
}

- (void)contestantThreePlusButtonPressed:(id)sender {
    int valueToAdd = [self getIntValueFromLabel:[self.contestantThreeIncrementValueSegment titleForSegmentAtIndex:self.contestantThreeIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantThree addThisAmountToContestantScore:valueToAdd];
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThree.score];
}

- (void)contestantThreeMinusButtonPressed:(id)sender {
    int valueToSubtract = [self getIntValueFromLabel:[self.contestantThreeIncrementValueSegment titleForSegmentAtIndex:self.contestantThreeIncrementValueSegment.selectedSegmentIndex]];
    [self.game.contestantThree subtractThisAmountFromContestantScore:valueToSubtract];
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThree.score];
}

-(UISegmentedControl *)createSegmentedControlWithFrame:(CGRect)frame
{
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithFrame:frame];
    segmentedControl.backgroundColor = [UIColor blackColor];
    segmentedControl.tintColor = [UIColor blackColor];
    [segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor yellowColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    int j = 0;
    for(int i = 1; i != 1000; i *= 10){
        [segmentedControl insertSegmentWithTitle:[NSString stringWithFormat:@"$%d", i] atIndex:j animated:NO];
        j++;
    }
    segmentedControl.selectedSegmentIndex = 0;
    return segmentedControl;
}

@end
