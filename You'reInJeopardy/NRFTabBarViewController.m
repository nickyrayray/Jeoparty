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

-(id)initWithGame:(NRFJeopardyGameEditable *)game;
{
    self = [super init];
    if(self){
        NRFJeopardyGameEditable *gameToInitialize;
        if(game)
            gameToInitialize = game;
        else
            gameToInitialize = [[NRFJeopardyGameEditable alloc] init];
        NRFGameDescriptionViewController *gameDescripVC = [[NRFGameDescriptionViewController alloc]initWithGame:gameToInitialize];
        gameDescripVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Game Description" image:nil tag:0];
        [self setAttributesForTabBarItem:gameDescripVC.tabBarItem];
        NRFMainBoardViewController *createRegJGameBoard = [[NRFMainBoardViewController alloc] initWithEditableGame:gameToInitialize inMode:REGULAR_JEOPARDY_SETUP];
        [self addOffsetToMainBoardViewController:createRegJGameBoard];
        createRegJGameBoard.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Regular Jeoparty" image:nil tag:0];
        [self setAttributesForTabBarItem:createRegJGameBoard.tabBarItem];
        NRFMainBoardViewController *createDoubleJGameBoard = [[NRFMainBoardViewController alloc] initWithEditableGame:gameToInitialize inMode:DOUBLE_JEOPARDY_SETUP];
        [self addOffsetToMainBoardViewController:createDoubleJGameBoard];
        createDoubleJGameBoard.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Double Jeopardy" image:nil tag:0];
        [self setAttributesForTabBarItem:createDoubleJGameBoard.tabBarItem];
        gameToInitialize.finalJeopartyQuestion = [[NRFFinalJeopartyQuestion alloc]init];
        NRFQuestionEditViewController *finalJeopartySetup = [[NRFQuestionEditViewController alloc] initWithFinalJeopartyQuestion:gameToInitialize.finalJeopartyQuestion];
        [self addOffsetToFinalJeopartyViewController:finalJeopartySetup];
        finalJeopartySetup.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Final Jeoparty" image:nil tag:0];
        [self setAttributesForTabBarItem:finalJeopartySetup.tabBarItem];
        self.viewControllers = [NSArray arrayWithObjects:gameDescripVC, createRegJGameBoard, createDoubleJGameBoard, finalJeopartySetup, nil];
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    [self.tabBar setItemPositioning:UITabBarItemPositioningFill];
    [self.tabBar setBarStyle:UIBarStyleBlack];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self loadButtons];
    self.navigationItem.title = @"Main Board: Edit Mode";
    
}

-(void)saveButtonPressed:(id)sender
{
    NRFMainBoardViewController *mainBoardVC = self.viewControllers[1];
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

-(void)checkForGameIsCompletelyEditedAndUpdateTabBarController
{
    NRFMainBoardViewController *mainBoardVC = self.viewControllers[0];
    NRFJeopardyGameEditable *editGameToCheck = (NRFJeopardyGameEditable *)mainBoardVC.game;
    if([editGameToCheck checkForJeopartyGameCompletelyEdited])
        [self gameIsCompletelyEdited];
    else
        [self gameIsNoLongerCompletelyEdited];
}

-(void)addOffsetToMainBoardViewController:(UIViewController *)viewController{
    UIScrollView *scrollView = (UIScrollView *)viewController.view;
    [scrollView setContentInset:UIEdgeInsetsMake(64, 0, 44, 0)];
}

-(void)addOffsetToFinalJeopartyViewController:(UIViewController *)viewController{
    UIScrollView *scrollView = (UIScrollView *)viewController.view;
    [scrollView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
}

-(NSDictionary *)setSelectedTextAttributes
{
    return [NSDictionary dictionaryWithObjectsAndKeys:[UIColor yellowColor], NSForegroundColorAttributeName, nil];
}

-(NSDictionary *)setUnselectedTextAttributes
{
    return [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
}

-(void)setAttributesForTabBarItem:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[self setUnselectedTextAttributes] forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:[self setSelectedTextAttributes] forState:UIControlStateSelected];
}



@end
