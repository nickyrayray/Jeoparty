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
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

-(void)saveButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
