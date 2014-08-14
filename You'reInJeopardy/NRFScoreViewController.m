//
//  NRFScoreViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/22/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFScoreViewController.h"

@interface NRFScoreViewController ()

@property (weak, nonatomic) IBOutlet UIButton *navAppearDisappearButton;

@property (weak, nonatomic) IBOutlet UILabel *contestantOneScore;
@property (weak, nonatomic) IBOutlet UITextView *contestantOneName;
@property (weak, nonatomic) IBOutlet UIButton *contestantOnePlus;
@property (weak, nonatomic) IBOutlet UIButton *contestantOneMinus;
@property (weak, nonatomic) IBOutlet UISegmentedControl *contestantOneIncrementValueSegment;


@property (weak, nonatomic) IBOutlet UILabel *contestantTwoScore;
@property (weak, nonatomic) IBOutlet UITextView *contestantTwoName;
@property (weak, nonatomic) IBOutlet UIButton *contestantTwoPlus;
@property (weak, nonatomic) IBOutlet UIButton *contestantTwoMinus;
@property (weak, nonatomic) IBOutlet UISegmentedControl *contestantTwoIncrementValueSegment;


@property (weak, nonatomic) IBOutlet UILabel *contestantThreeScore;
@property (weak, nonatomic) IBOutlet UITextView *contestantThreeName;
@property (weak, nonatomic) IBOutlet UIButton *contestantThreePlus;
@property (weak, nonatomic) IBOutlet UIButton *contestantThreeMinus;
@property (weak, nonatomic) IBOutlet UISegmentedControl *contestantThreeIncrementValueSegment;

@property (strong, nonatomic)NRFJeopardyGamePlayable *game;
@property int questionValue;
@property BOOL isInEditMode;
@property BOOL isInInitializeMode;
@property BOOL isInFinalJeopartyMode;

@end

@implementation NRFScoreViewController

- (id)initWithGame:(NRFJeopardyGamePlayable *)game andQuestion:(NRFQuestion *)question
{
    self = [super initWithNibName:@"NRFScoreViewController" bundle:nil];
    if (self) {
        
        self.game = game;
        self.questionValue = question.value;
        self.isInEditMode = NO;
        self.isInInitializeMode = NO;
        
    }
    return self;
}

-(id)initWithGame:(NRFJeopardyGamePlayable *)game inInitializeMode:(BOOL)isInInitializeMode
{
    self = [super initWithNibName:@"NRFScoreViewController" bundle:nil];
    if(self) {
        
        self.game = game;
        if(isInInitializeMode)
            self.isInInitializeMode = YES;
        else{
            self.isInEditMode = YES;
        }
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    if(!self.isInEditMode){
        [self.contestantOneIncrementValueSegment setHidden:YES];
        [self.contestantTwoIncrementValueSegment setHidden:YES];
        [self.contestantThreeIncrementValueSegment setHidden:YES];
    }
    
    if(self.isInInitializeMode){
        
        [self.contestantOneMinus setHidden:YES];
        [self.contestantOnePlus setHidden:YES];
        [self.contestantTwoMinus setHidden:YES];
        [self.contestantTwoPlus setHidden:YES];
        [self.contestantThreePlus setHidden:YES];
        [self.contestantThreeMinus setHidden:YES];
        
    } else {
        
        self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOne.score];
        self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwo.score];
        self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThree.score];
        self.contestantOneName.text = self.game.contestantOne.name;
        self.contestantTwoName.text = self.game.contestantTwo.name;
        self.contestantThreeName.text = self.game.contestantThree.name;
        [self.contestantOneName setEditable:NO];
        [self.contestantTwoName setEditable:NO];
        [self.contestantThreeName setEditable:NO];
    
    }
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
}

-(void)doneButtonPressed:(id)sender{
    
    [self.navigationController setNavigationBarHidden:YES];
    if(self.isInInitializeMode){
        self.game.contestantOne = [[NRFJeopartyContestant alloc] initWithName:self.contestantOneName.text];
        self.game.contestantTwo = [[NRFJeopartyContestant alloc] initWithName:self.contestantTwoName.text];
        self.game.contestantThree = [[NRFJeopartyContestant alloc] initWithName:self.contestantThreeName.text];
        [self.delegate scoreVCDidFinishWithGame:self.game];
    } else
        [self.delegate scoreVCDidFinish];
}

-(NSString *)stringifyAndAddDollarSignToNumber:(int)number
{
    return [NSString stringWithFormat:@"$%d", number];
}

-(int)getIntValueFromLabel:(NSString *)labelString
{
    NSString *numberValue = [labelString stringByReplacingOccurrencesOfString:@"$" withString:@""];
    return [numberValue intValue];
    
}

- (IBAction)contestantOnePlusButtonPressed:(id)sender {
    int contestantOneValueToAdd;
    if(self.isInEditMode)
        contestantOneValueToAdd = [self getIntValueFromLabel:[self.contestantOneIncrementValueSegment titleForSegmentAtIndex:self.contestantOneIncrementValueSegment.selectedSegmentIndex]];
    else if(self.isInFinalJeopartyMode)
        contestantOneValueToAdd = -1;
    else
        contestantOneValueToAdd = self.questionValue;
    [self.game.contestantOne addThisAmountToContestantScore:contestantOneValueToAdd];
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOne.score];
}

- (IBAction)contestantOneMinusButtonPressed:(id)sender {
    int contestantOneValueToSubtract;
    if(self.isInEditMode)
        contestantOneValueToSubtract = [self getIntValueFromLabel:[self.contestantOneIncrementValueSegment titleForSegmentAtIndex:self.contestantOneIncrementValueSegment.selectedSegmentIndex]];
    else if(self.isInFinalJeopartyMode)
        contestantOneValueToSubtract = -1;
    else
        contestantOneValueToSubtract = self.questionValue;
    [self.game.contestantOne subtractThisAmoutnFromContestantScore:contestantOneValueToSubtract];
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOne.score];
}

- (IBAction)contestantTwoPlusButtonPressed:(id)sender {
    int contestantTwoValueToAdd;
    if(self.isInEditMode)
        contestantTwoValueToAdd = [self getIntValueFromLabel:[self.contestantTwoIncrementValueSegment titleForSegmentAtIndex:self.contestantTwoIncrementValueSegment.selectedSegmentIndex]];
    else if(self.isInFinalJeopartyMode)
        contestantTwoValueToAdd = -1;
    else
        contestantTwoValueToAdd = self.questionValue;
    [self.game.contestantTwo addThisAmountToContestantScore:contestantTwoValueToAdd];
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwo.score];
}

- (IBAction)contestantTwoMinusButtonPressed:(id)sender {
    int contestantTwoValueToSubtract;
    if(self.isInEditMode)
        contestantTwoValueToSubtract = [self getIntValueFromLabel:[self.contestantTwoIncrementValueSegment titleForSegmentAtIndex:self.contestantTwoIncrementValueSegment.selectedSegmentIndex]];
    else if(self.isInFinalJeopartyMode)
        contestantTwoValueToSubtract = -1;
    else
        contestantTwoValueToSubtract = self.questionValue;
    [self.game.contestantTwo subtractThisAmoutnFromContestantScore:contestantTwoValueToSubtract];
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwo.score];
}
- (IBAction)contestantThreePlusButtonPressed:(id)sender {
    int contestantThreeValueToAdd;
    if(self.isInEditMode)
        contestantThreeValueToAdd = [self getIntValueFromLabel:[self.contestantThreeIncrementValueSegment titleForSegmentAtIndex:self.contestantThreeIncrementValueSegment.selectedSegmentIndex]];
    else if(self.isInFinalJeopartyMode)
        contestantThreeValueToAdd = -1;
    else
        contestantThreeValueToAdd = self.questionValue;
    [self.game.contestantThree addThisAmountToContestantScore:contestantThreeValueToAdd];
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThree.score];
}

- (IBAction)contestantThreeMinusButtonPressed:(id)sender {
    int contestantThreeValueToSubtract;
    if(self.isInEditMode)
        contestantThreeValueToSubtract = [self getIntValueFromLabel:[self.contestantThreeIncrementValueSegment titleForSegmentAtIndex:self.contestantOneIncrementValueSegment.selectedSegmentIndex]];
    else if(self.isInFinalJeopartyMode)
        contestantThreeValueToSubtract = -1;
    else
        contestantThreeValueToSubtract = self.questionValue;
    [self.game.contestantThree subtractThisAmoutnFromContestantScore:contestantThreeValueToSubtract];
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThree.score];
}

- (IBAction)topPressed:(id)sender {
    if([self.navigationController isNavigationBarHidden])
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    else
        [self.navigationController setNavigationBarHidden:YES animated:YES];
}


@end
