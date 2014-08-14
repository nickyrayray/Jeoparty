//
//  NRFMainMenuViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/8/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFMainMenuViewController.h"


@interface NRFMainMenuViewController () <NRFTabBarViewControllerDelegate>

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
    
    NRFTabBarViewController *boardsTabViewController = [[NRFTabBarViewController alloc] init];
    boardsTabViewController.myDelegate = self;
    
    [self.navigationController pushViewController:boardsTabViewController animated:YES];
    
}

- (IBAction)playGame:(id)sender {
    NRFOldGamesTableViewController *oldGames = [[NRFOldGamesTableViewController alloc] initWithGames:self.games inMode:OLD_GAMES_PLAY_MODE];
    [self.navigationController pushViewController:oldGames animated:YES];
}
- (IBAction)editGame:(id)sender {
    NRFOldGamesTableViewController *oldGames = [[NRFOldGamesTableViewController alloc] initWithGames:self.games inMode:OLD_GAMES_EDIT_MODE];
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
