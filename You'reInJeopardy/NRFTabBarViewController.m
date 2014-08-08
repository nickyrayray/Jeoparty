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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    self.navigationItem.title = @"Main Board: Edit Mode";
    self.navigationItem.rightBarButtonItem = saveButton;
    
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

@end
