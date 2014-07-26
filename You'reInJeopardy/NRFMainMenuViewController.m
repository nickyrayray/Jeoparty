//
//  NRFMainMenuViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/8/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFMainMenuViewController.h"
#import "NRFMainBoardViewController.h"
#import "NRFOldGamesTableViewController.h"

@interface NRFMainMenuViewController ()

@property (strong, nonatomic) NSMutableArray *games;

@end

@implementation NRFMainMenuViewController

- (id)init
{
    self = [super initWithNibName:@"NRFMainMenuViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Main Menu";
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)createGame:(id)sender {
    
    NRFMainBoardViewController *createGameBoard = [[NRFMainBoardViewController alloc] initWithGame:nil inMode:@"regJPrep"];
    [self.navigationController pushViewController:createGameBoard animated:YES];
}
- (IBAction)playGame:(id)sender {
    NRFOldGamesTableViewController *oldGames = [[NRFOldGamesTableViewController alloc] initInMode:@"playMode"];
    [self.navigationController pushViewController:oldGames animated:YES];
}
- (IBAction)editGame:(id)sender {
    NRFOldGamesTableViewController *oldGames = [[NRFOldGamesTableViewController alloc] initInMode:@"editMode"];
    [self.navigationController pushViewController:oldGames animated:YES];
}
- (IBAction)options:(id)sender {
}


@end
