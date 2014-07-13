//
//  NRFOldGamesTableViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/25/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFOldGamesTableViewController.h"

@interface NRFOldGamesTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *games;

@end

@implementation NRFOldGamesTableViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.games = [NSMutableArray array];
    }
    return self;
}

-(void) loadView
{
    [super loadView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}



@end
