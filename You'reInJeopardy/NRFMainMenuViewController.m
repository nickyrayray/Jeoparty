//
//  NRFMainMenuViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/8/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFMainMenuViewController.h"
#import "NRFMainBoardViewController.h"

@interface NRFMainMenuViewController ()

@end

@implementation NRFMainMenuViewController

- (id)init
{
    self = [super initWithNibName:@"NRFMainMenuViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)createGame:(id)sender {
    
    NRFMainBoardViewController *createGameBoard = [[NRFMainBoardViewController alloc] initWithGame:nil inMode:@"regJPrep"];
    [self presentViewController:createGameBoard animated:YES completion:nil];
}
- (IBAction)playGame:(id)sender {
}
- (IBAction)editGame:(id)sender {
}
- (IBAction)options:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
