//
//  NRFTabBarViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/31/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFTabBarViewController.h"

@interface NRFTabBarViewController ()

@end

@implementation NRFTabBarViewController

-(id)init
{
    self = [super init];
    if(self){
        NRFJeopardyGameEditable *gameToInitialize = [[NRFJeopardyGameEditable alloc] init];
        NRFMainBoardViewController *createRegJGameBoard = [[NRFMainBoardViewController alloc] initWithEditableGame:gameToInitialize inMode:REGULAR_JEOPARDY_SETUP];
        createRegJGameBoard.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Regular Jeoparty" image:nil tag:0];
        NRFMainBoardViewController *createDoubleJGameBoard = [[NRFMainBoardViewController alloc] initWithEditableGame:gameToInitialize inMode:DOUBLE_JEOPARDY_SETUP];
        createDoubleJGameBoard.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Double Jeopardy" image:nil tag:0];
        NRFQuestionEditViewController *finalJeopartySetup = [[NRFQuestionEditViewController alloc] initWithFinalJeopartyQuestion:gameToInitialize.finalJeopartyQuestion];
        finalJeopartySetup.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Final Jeoparty" image:nil tag:0];
        self.viewControllers = [NSArray arrayWithObjects:createRegJGameBoard, createDoubleJGameBoard, finalJeopartySetup, nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadButtons];
    self.navigationItem.title = @"Main Board: Edit Mode";
    
}

-(void)saveButtonPressed:(id)sender
{
    NRFMainBoardViewController *mainBoardVC = self.viewControllers[0];
    NRFJeopardyGameEditable *editGameToSendToDelegate = (NRFJeopardyGameEditable *)mainBoardVC.game;
    [self.myDelegate tabBarViewControllerDidFinishWithEditedGame:editGameToSendToDelegate];
}

-(void)gameIsCompletelyEdited
{
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"This Game Is Ready" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonPressed:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
}

-(void)gameIsNoLongerCompletelyEdited

{
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

-(void)loadButtons
{
    NRFMainBoardViewController *mainBoardVC = self.viewControllers[0];
    NRFJeopardyGameEditable *editGameToDetermineIfDoneEditing = (NRFJeopardyGameEditable *)mainBoardVC.game;
    if([editGameToDetermineIfDoneEditing checkForJeopartyGameCompletelyEdited])
        [self gameIsCompletelyEdited];
    else
        [self gameIsNoLongerCompletelyEdited];
}

@end
