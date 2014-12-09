//
//  NRFOldGamesTableViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/25/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFOldGamesTableViewController.h"

@interface NRFOldGamesTableViewController ()<UITableViewDataSource, UITableViewDelegate, NRFInitializerScoreViewControllerProtocol>

@property (strong, nonatomic) NSMutableArray *games;
@property int mode;

@end

@implementation NRFOldGamesTableViewController

- (id)initWithGames:(NSMutableArray *)games inMode:(int)mode
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.mode = mode;
        if(self.games.count == 0){
            self.games = [NSMutableArray array];
            NRFJeopardyGamePlayable *test = [[NRFJeopardyGamePlayable alloc] init];
            test.maxCategoryCount = 6;
            test.maxQuestionCount = 30;
            test.gameTitle = @"Test Title";
            test.gameDescription = @"This is a test. Not a real game. It is only a test";
            NSMutableArray *mutableQuestions = [[NSMutableArray alloc] init];
            NSMutableArray *mutableDoubleQuestions = [[NSMutableArray alloc] init];
            NSMutableArray *mutableCategories = [[NSMutableArray alloc] init];
            for(int i = 0; i < 30; i++){
                NSString *question = [NSString stringWithFormat:@"%c", (i%6)+65];
                NSString *answer = [NSString stringWithFormat:@"%d", i];
                int value = ((i/6) + 1) * 200;
                NRFQuestion *questionToAdd = [[NRFQuestion alloc] initQuestion:question withValue:value andAnswer:answer];
                NRFQuestion *doubleQuestionToAdd = [[NRFQuestion alloc] initQuestion:question withValue:2*value andAnswer:answer];
                [mutableQuestions addObject:questionToAdd];
                [mutableDoubleQuestions addObject:doubleQuestionToAdd];
            }
        
            for(int i = 0; i < 6; i++){
                NSString *category = [NSString stringWithFormat:@"%c", i+65];
                [mutableCategories addObject:category];
            }
        
            test.questions = mutableQuestions;
            test.doubleQuestions = mutableDoubleQuestions;
            test.categories = mutableCategories;
            test.doubleCategories = mutableCategories;
    
            [self.games addObject:test];
        } else {
            if([self isInEditMode])
                self.games = games;
            else
                self.games = [self arrayOfPlayableGamesFromEditableGames:games];
        }
    }
    return self;
}

-(void) loadView
{
    [super loadView];
    
    if([self.games count] == 0){
        UILabel *label = [[UILabel alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
        label.text = @"NO GAMES FOUND";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:70.0];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blueColor];
        self.view = label;
        return;
    }
    
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
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
    NRFJeopardyGameEditable *gameSelected = self.games[indexPath.row];
    if([self isInEditMode]){
        NRFTabBarViewController *editGame = [[NRFTabBarViewController alloc]initWithGame:gameSelected];
        [self.navigationController pushViewController:editGame animated:YES];
    } else {
        NRFJeopardyGamePlayable *playableGame = [NRFJeopardyGamePlayable makeCopyOfGame:gameSelected];
        NRFInitializerScoreViewController *scoreVC = [[NRFInitializerScoreViewController alloc]initWithGame:playableGame];
        scoreVC.delegate = self;
        [self.navigationController pushViewController:scoreVC animated:YES];
    }
    
}

-(void)initializerScoreViewControllerDidFinishWithGame:(NRFJeopardyGamePlayable *)game{
    [self.navigationController popViewControllerAnimated:NO];
    NRFMainBoardViewController *playBoard = [[NRFMainBoardViewController alloc] initWithPlayableGame:game inMode:REGULAR_JEOPARDY_PLAY];
    [self.navigationController pushViewController:playBoard animated:YES];
}

-(BOOL)isInEditMode{
    if(self.mode == OLD_GAMES_EDIT_MODE)
        return YES;
    else
        return NO;
}

-(NSMutableArray *)arrayOfPlayableGamesFromEditableGames:(NSMutableArray *)games
{
    NSMutableArray *playableGames = [[NSMutableArray alloc]init];
    for(NRFJeopardyGameEditable *game in games){
        if([game checkForJeopartyGameCompletelyEdited])
            [playableGames addObject:game];
    }
    return playableGames;
}

-(void)viewWillDisappear:(BOOL)animated{
    if([self.navigationController.viewControllers indexOfObject:self] == NSNotFound){
        [self.navigationController setNavigationBarHidden:YES];
        
    }
    
}






@end
