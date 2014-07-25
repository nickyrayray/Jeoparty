//
//  NRFOldGamesTableViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/25/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFOldGamesTableViewController.h"
#import "NRFJeopardyGame.h"
#import "NRFMainBoardViewController.h"

@interface NRFOldGamesTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *games;
@property (strong, nonatomic) NSString *mode;

@end

@implementation NRFOldGamesTableViewController

- (id)initInMode:(NSString *)mode
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.games = [NSMutableArray array];
        NRFJeopardyGame *test = [[NRFJeopardyGame alloc] init];
        test.gameTitle = @"Test Title";
        test.gameDescription = @"This is a test. Not a real game. It is only a test";
        NSMutableArray *mutableQuestions = [[NSMutableArray alloc] init];
        NSMutableArray *mutableCategories = [[NSMutableArray alloc] init];
        for(int i = 0; i < 30; i++){
            NSString *question = [NSString stringWithFormat:@"%d", i];
            NSString *answer = [NSString stringWithFormat:@"%d", i];
            NRFQuestion *questionToAdd = [[NRFQuestion alloc] initQuestion:question withValue:i andAnswer:answer];
            [mutableQuestions addObject:questionToAdd];
        }
        
        for(int i = 0; i < 6; i++){
            NSString *category = [NSString stringWithFormat:@"%c", i+65];
            [mutableCategories addObject:category];
        }
        
        test.questions = mutableQuestions;
        test.doubleQuestions = mutableQuestions;
        test.categories = mutableCategories;
        test.doubleCategories = mutableCategories;
    
        [self.games addObject:test];
        self.mode = mode;
    }
    return self;
}

-(void) loadView
{
    [super loadView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor blueColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView = tableView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    if([self isInEditMode])
        self.navigationItem.title = @"Edit a Game";
    else
        self.navigationItem.title = @"Choose a Game";

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.games.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NRFJeopardyGame *current = self.games[indexPath.row];
    cell.textLabel.text = current.gameTitle;
    cell.detailTextLabel.text = current.gameDescription;
    cell.backgroundColor = [UIColor blueColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.textLabel.textColor = [UIColor yellowColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = [UIColor yellowColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NRFJeopardyGame *gameSelected = self.games[indexPath.row];
    if([self isInEditMode]){
        NRFMainBoardViewController *editBoard = [[NRFMainBoardViewController alloc] initWithGame:gameSelected inMode:@"regJPrep"];
        [self.navigationController pushViewController:editBoard animated:YES];
    } else {
        NRFJeopardyGame *playableGame = [NRFJeopardyGame makeCopyOfGame:gameSelected];
        NRFScoreViewController *scoreVC = [[NRFScoreViewController alloc] initWithGame:playableGame inInitializeMode:YES];
        scoreVC.delegate = self;
        [self.navigationController pushViewController:scoreVC animated:YES];
    }
    
}

-(void)scoreVCDidFinishWithGame:(NRFJeopardyGame *)game{
    [self.navigationController popViewControllerAnimated:NO];
    NRFMainBoardViewController *playBoard = [[NRFMainBoardViewController alloc] initWithGame:game inMode:@"regJ"];
    [self.navigationController pushViewController:playBoard animated:YES];
}

-(void)scoreVCDidFinish{
    return;
}

-(BOOL)isInEditMode{
    if([self.mode isEqualToString:@"editMode"])
        return YES;
    else
        return NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    if([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
        [self.navigationController setNavigationBarHidden:YES];
    
}






@end
