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

@property (strong, nonatomic) NRFJeopardyGame *game;
@property int contestantOneValueToAddOrSubtract;
@property int contestantTwoValueToAddOrSubtract;
@property int contestantThreeValueToAddOrSubtract;
@property BOOL isInEditMode;
@property BOOL isInInitializeMode;

@end

@implementation NRFScoreViewController

- (id)initWithGame:(NRFJeopardyGame *)game andQuestion:(NRFQuestion *)question
{
    self = [super initWithNibName:@"NRFScoreViewController" bundle:nil];
    if (self) {
        
        self.game = game;
        self.contestantOneValueToAddOrSubtract = question.value;
        self.contestantTwoValueToAddOrSubtract = question.value;
        self.contestantThreeValueToAddOrSubtract = question.value;
        self.isInEditMode = NO;
        self.isInInitializeMode = NO;
        
    }
    return self;
}

-(id)initWithGame:(NRFJeopardyGame *)game inInitializeMode:(BOOL)isInInitializeMode
{
    self = [super initWithNibName:@"NRFScoreViewController" bundle:nil];
    if(self) {
        
        self.game = game;
        if(isInInitializeMode)
            self.isInInitializeMode = YES;
        else{
            self.isInEditMode = YES;
            self.contestantOneValueToAddOrSubtract = 1;
            self.contestantTwoValueToAddOrSubtract = 1;
            self.contestantThreeValueToAddOrSubtract = 1;
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
        
        self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOneScore];
        self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwoScore];
        self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThreeScore];
        self.contestantOneName.text = self.game.contestantOneName;
        self.contestantTwoName.text = self.game.contestantTwoName;
        self.contestantThreeName.text = self.game.contestantThreeName;
        [self.contestantOneName setEditable:NO];
        [self.contestantTwoName setEditable:NO];
        [self.contestantThreeName setEditable:NO];
    
    }
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
}

-(void)doneButtonPressed:(id)sender{
    
    self.game.contestantOneName = self.contestantOneName.text;
    self.game.contestantTwoName = self.contestantTwoName.text;
    self.game.contestantThreeName = self.contestantThreeName.text;
    [self.navigationController setNavigationBarHidden:YES];
    if(self.isInInitializeMode)
        [self.delegate scoreVCDidFinishWithGame:self.game];
    else
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
    int numberToAddTo = [self getIntValueFromLabel:self.contestantOneScore.text];
    int newScore = numberToAddTo + self.contestantOneValueToAddOrSubtract;
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:newScore];
    self.game.contestantOneScore = newScore;
}
- (IBAction)contestantOneMinusButtonPressed:(id)sender {
    int numberToSubtractFrom = [self getIntValueFromLabel:self.contestantOneScore.text];
    int newScore = numberToSubtractFrom - self.contestantOneValueToAddOrSubtract;
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:newScore];
    self.game.contestantOneScore = newScore;
}
- (IBAction)contestantTwoPlusButtonPressed:(id)sender {
    int numberToAddTo = [self getIntValueFromLabel:self.contestantTwoScore.text];
    int newScore = numberToAddTo + self.contestantTwoValueToAddOrSubtract;
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:newScore];
    self.game.contestantTwoScore = newScore;
}
- (IBAction)contestantTwoMinusButtonPressed:(id)sender {
    int numberToSubtractFrom = [self getIntValueFromLabel:self.contestantTwoScore.text];
    int newScore = numberToSubtractFrom - self.contestantTwoValueToAddOrSubtract;
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:newScore];
    self.game.contestantTwoScore = newScore;
}
- (IBAction)contestantThreePlusButtonPressed:(id)sender {
    int numberToAddTo = [self getIntValueFromLabel:self.contestantThreeScore.text];
    int newScore = numberToAddTo + self.contestantThreeValueToAddOrSubtract;
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:newScore];
    self.game.contestantThreeScore = newScore;
}
- (IBAction)contestantThreeMinusButtonPressed:(id)sender {
    int numberToSubtractFrom = [self getIntValueFromLabel:self.contestantThreeScore.text];
    int newScore = numberToSubtractFrom - self.contestantThreeValueToAddOrSubtract;
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:newScore];
    self.game.contestantThreeScore = newScore;
}

- (IBAction)contestantOneIncrementValueSelected:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0)
        self.contestantOneValueToAddOrSubtract = 1;
    else if(sender.selectedSegmentIndex == 1)
        self.contestantOneValueToAddOrSubtract = 10;
    else
        self.contestantOneValueToAddOrSubtract = 100;
}
- (IBAction)contestantTwoIncrementValueSelected:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0)
        self.contestantTwoValueToAddOrSubtract = 1;
    else if(sender.selectedSegmentIndex == 1)
        self.contestantTwoValueToAddOrSubtract = 10;
    else
        self.contestantTwoValueToAddOrSubtract = 100;
}
- (IBAction)contestantThreeIncrementValueSelected:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0)
        self.contestantThreeValueToAddOrSubtract = 1;
    else if(sender.selectedSegmentIndex == 1)
        self.contestantThreeValueToAddOrSubtract = 10;
    else
        self.contestantThreeValueToAddOrSubtract = 100;
}
- (IBAction)topPressed:(id)sender {
    if([self.navigationController isNavigationBarHidden])
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    else
        [self.navigationController setNavigationBarHidden:YES animated:YES];
}


@end
