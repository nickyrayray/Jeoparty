//
//  NRFMainMenuViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/8/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFMainMenuViewController.h"


@interface NRFMainMenuViewController ()

@end

@implementation NRFMainMenuViewController

- (id)init
{
    self = [super initWithNibName:@"NRFMainMenuViewController" bundle:nil];
    if (self) {
        self.games = [NSMutableArray array];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if(self){
        
        NSArray *array = [decoder decodeObjectForKey:@"games"];
        self.games = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.games forKey:@"games"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Main Menu";
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)createGame:(id)sender {
    
    [self.navigationController setNavigationBarHidden:NO];
    
    NRFJeopardyGameEditable *gameToInitialize = [[NRFJeopardyGameEditable alloc] init];
    NRFMainBoardViewController *createRegJGameBoard = [[NRFMainBoardViewController alloc] initWithEditableGame:gameToInitialize inMode:@"regJPrep"];
    UITabBarItem *createRegJGameBoardTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Regular Jeoparty" image:nil tag:0];
    createRegJGameBoard.tabBarItem = createRegJGameBoardTabBarItem;
    NRFMainBoardViewController *createDoubleJGameBoard = [[NRFMainBoardViewController alloc] initWithEditableGame:gameToInitialize inMode:@"doubleJPrep"];
    UITabBarItem *createDoubleJGameBoardTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Double Jeopardy" image:nil tag:0];
    createDoubleJGameBoard.tabBarItem = createDoubleJGameBoardTabBarItem;
    NSArray *tabBarObjects = [[NSArray alloc] initWithObjects:createRegJGameBoard,createDoubleJGameBoard, nil];
    NRFTabBarViewController *boardsTabViewController = [[NRFTabBarViewController alloc] init];
    boardsTabViewController.viewControllers = tabBarObjects;
    boardsTabViewController.myDelegate = self;
    
    [self.navigationController pushViewController:boardsTabViewController animated:YES];
    
}

- (IBAction)playGame:(id)sender {
    NRFOldGamesTableViewController *oldGames = [[NRFOldGamesTableViewController alloc] initWithGames:self.games inMode:@"playMode"];
    [self.navigationController pushViewController:oldGames animated:YES];
}
- (IBAction)editGame:(id)sender {
    NRFOldGamesTableViewController *oldGames = [[NRFOldGamesTableViewController alloc] initWithGames:self.games inMode:@"editMode"];
    [self.navigationController pushViewController:oldGames animated:YES];
}
- (IBAction)options:(id)sender {
}

-(void)tabBarViewControllerDidFinishWithEditedGame:(NRFJeopardyGameEditable *)editableGame
{
    [self.games addObject:editableGame];
    [self.navigationController popViewControllerAnimated:NO];
}


@end
