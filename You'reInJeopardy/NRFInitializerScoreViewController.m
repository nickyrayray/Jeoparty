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
    [self.navigationController setNavigationBarHidden:YES];
    self.game.contestantOne = [[NRFJeopartyContestant alloc] initWithName:self.contestantOneName.text];
    self.game.contestantTwo = [[NRFJeopartyContestant alloc] initWithName:self.contestantTwoName.text];
    self.game.contestantThree = [[NRFJeopartyContestant alloc] initWithName:self.contestantThreeName.text];
    [self.delegate initializerScoreViewControllerDidFinishWithGame:self.game];
}



@end
