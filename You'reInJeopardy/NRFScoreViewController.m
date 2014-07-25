//
//  NRFScoreViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/22/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFScoreViewController.h"

@interface NRFScoreViewController ()

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
@property int valueToAddOrSubtract;
@property BOOL isInEditMode;
@property BOOL isInInitializeMode;

@end

@implementation NRFScoreViewController

- (id)initWithGame:(NRFJeopardyGame *)game andQuestion:(NRFQuestion *)question
{
    self = [super initWithNibName:@"NRFScoreViewController" bundle:nil];
    if (self) {
        
        self.game = game;
        self.valueToAddOrSubtract = question.value;
        self.isInEditMode = NO;
        self.isInInitializeMode = NO;
        
    }
    return self;
}

-(id)initWithGame:(NRFJeopardyGame *)game
{
    self = [super initWithNibName:@"NRFScoreViewController" bundle:nil];
    if(self) {
        
        self.game = game;
        self.isInEditMode = YES;
        self.isInInitializeMode = NO;
        
    }
    
    return self;
}

-(id)init{
    
    self = [super initWithNibName:@"NRFScoreViewController" bundle:nil];
    if(self) {
        
        self.isInEditMode = NO;
        self.isInInitializeMode = YES;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contestantOneScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantOneScore];
    self.contestantTwoScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantTwoScore];
    self.contestantThreeScore.text = [self stringifyAndAddDollarSignToNumber:self.game.contestantThreeScore];
    
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
        [self.contestantOneName setEditable:NO];
        [self.contestantTwoName setEditable:NO];
        [self.contestantThreeName setEditable:NO];
    }
    
}

-(NSString *)stringifyAndAddDollarSignToNumber:(int)number
{
    return [NSString stringWithFormat:@"$%d", number];
}

-(int)getIntValueFromLabel:(NSString *)labelValue
{
    NSString *numberValue = [labelValue stringByReplacingOccurrencesOfString:@"$" withString:@""];
    return [numberValue intValue];
    
}
- (IBAction)contestantOnePlusButtonPressed:(id)sender {
}
- (IBAction)contestantOneMinusButtonPressed:(id)sender {
}
- (IBAction)contestantTwoPlusButtonPressed:(id)sender {
}
- (IBAction)contestantTwoMinusButtonPressed:(id)sender {
}
- (IBAction)contestantThreePlusButtonPressed:(id)sender {
}
- (IBAction)contestantThreeMinusButtonPressed:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
