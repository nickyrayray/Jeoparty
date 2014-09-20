//
//  NRFInitializerScoreViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 9/1/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFInitializerScoreViewController.h"

@interface NRFInitializerScoreViewController ()

@end

@implementation NRFInitializerScoreViewController

- (id)initWithGame:(NRFJeopardyGamePlayable *)game
{
    self = [super initWithGame:game];
    return self;
}

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.contestantOneName setEditable:YES];
    [self.contestantTwoName setEditable:YES];
    [self.contestantThreeName setEditable:YES];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

-(void)doneButtonPressed:(id)sender
{
    if([self isEverythingDone]){
        [self.navigationController setNavigationBarHidden:YES];
        self.game.contestantOne = [[NRFJeopartyContestant alloc] initWithName:self.contestantOneName.text];
        self.game.contestantTwo = [[NRFJeopartyContestant alloc] initWithName:self.contestantTwoName.text];
        self.game.contestantThree = [[NRFJeopartyContestant alloc] initWithName:self.contestantThreeName.text];
        [self.delegate initializerScoreViewControllerDidFinishWithGame:self.game];
    } else {
        [[[UIAlertView alloc]initWithTitle:@"Enter Contestant Names!" message:[self formulateDebateString] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

-(BOOL)isEverythingDone
{
    NSString *placeHolder = @"Tap to Enter Contestant Name";
    if([self.contestantOneName.text isEqualToString:placeHolder] || [self.contestantOneName.text isEqualToString:@""]
       || [self.contestantTwoName.text isEqualToString:placeHolder] || [self.contestantTwoName.text isEqualToString:@""]
       || [self.contestantThreeName.text isEqualToString:placeHolder] || [self.contestantThreeName.text isEqualToString:@""])
        return NO;
    else
        return YES;
}

-(NSString *)formulateDebateString
{
    NSString *placeHolder = @"Tap to Enter Contestant Name";
    NSString *stringToReturn = @"Enter names for the following contestants:";
    if([self.contestantOneName.text isEqualToString:placeHolder] || [self.contestantOneName.text isEqualToString:@""])
        stringToReturn = [stringToReturn stringByAppendingString:@"\nContestant One"];
    if([self.contestantTwoName.text isEqualToString:placeHolder] || [self.contestantTwoName.text isEqualToString:@""])
        stringToReturn = [stringToReturn stringByAppendingString:@"\nContestant Two"];
    if([self.contestantThreeName.text isEqualToString:placeHolder] || [self.contestantThreeName.text isEqualToString:@""])
        stringToReturn = [stringToReturn stringByAppendingString:@"\nContestant Three"];
    return stringToReturn;
}



@end
