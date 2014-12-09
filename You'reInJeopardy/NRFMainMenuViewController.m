//
//  NRFMainMenuViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/8/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFMainMenuViewController.h"


@interface NRFMainMenuViewController () <NRFTabBarViewControllerDelegate>

@property (strong, nonatomic) UIButton *resumeGameButton;

@end

@implementation NRFMainMenuViewController

- (id)init
{
    self = [super init];
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

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frameSize = [[UIScreen mainScreen]applicationFrame];
    float buttonWidth = (frameSize.size.height)/6 + (20/(TOTAL_QUESTION_PANELS/TOTAL_CATEGORY_PANELS + 1));
    float buttonHeight = (frameSize.size.width/6);
    NSMutableArray *buttonArray = [[NSMutableArray alloc]init];
    UIButton *buttonToCreate;
    
    for(int i = 0; i < TOTAL_CATEGORY_PANELS; i++){
        for(int j = 0; j < (TOTAL_QUESTION_PANELS / TOTAL_CATEGORY_PANELS) + 1; j++){
            buttonToCreate = [[UIButton alloc] initWithFrame:CGRectMake(j*buttonHeight, i*buttonWidth, buttonHeight, buttonWidth)];
            [buttonToCreate setBackgroundImage:[UIImage imageNamed:@"Square.png"] forState:UIControlStateNormal];
            buttonToCreate.adjustsImageWhenDisabled = NO;
            buttonToCreate.titleLabel.textColor = [UIColor yellowColor];
            [buttonToCreate setEnabled:NO];
            [buttonArray addObject:buttonToCreate];
            [self.view addSubview:buttonToCreate];
        }
    }
    
    for(int i = 7; i < 11; i++){
        [[buttonArray objectAtIndex:7] removeFromSuperview];
        [buttonArray removeObjectAtIndex:7];
    }
    
    for(int i = 9; i < 13; i++){
        [[buttonArray objectAtIndex:9] removeFromSuperview];
        [buttonArray removeObjectAtIndex:9];
    }
    
    UIButton *buttonToFormat;
    for(int i = 17; i < 21; i++){
        buttonToFormat= [buttonArray objectAtIndex:i];
        [buttonToFormat.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [buttonToFormat setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [buttonToFormat setEnabled:YES];
        if(i == 17){
            [buttonToFormat setTitle:@"Create Game" forState:UIControlStateNormal];
            [buttonToFormat addTarget:self action:@selector(createGame:) forControlEvents:UIControlEventTouchUpInside];
        } else if(i == 18){
            [buttonToFormat setTitle:@"Play Game" forState:UIControlStateNormal];
            [buttonToFormat addTarget:self action:@selector(playGame:) forControlEvents:UIControlEventTouchUpInside];
        } else if(i == 19){
            [buttonToFormat setTitle:@"Edit Game" forState:UIControlStateNormal];
            [buttonToFormat addTarget:self action:@selector(editGame:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            self.resumeGameButton = buttonToFormat;
            if(self.currentGame){
                [buttonToFormat setTitle:@"Resume Game" forState:UIControlStateNormal];
                [buttonToFormat addTarget:self action:@selector(resumeGame:) forControlEvents:UIControlEventTouchUpInside];
            } else
                [buttonToFormat setEnabled:NO];
        }
    }
    
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(buttonHeight, buttonWidth, 4*buttonHeight, 2*buttonWidth)];
    titleImage.image = [UIImage imageNamed:@"Logo.png"];
    [self.view addSubview:titleImage];
    
    self.navigationItem.title = @"Main Menu";
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)createGame:(id)sender {
    
    [self.navigationController setNavigationBarHidden:NO];
    
    NRFTabBarViewController *boardsTabViewController = [[NRFTabBarViewController alloc] initWithGame:nil];
    boardsTabViewController.myDelegate = self;
    
    [self.navigationController pushViewController:boardsTabViewController animated:YES];
    
}

- (void)playGame:(id)sender {
    NRFOldGamesTableViewController *oldGames = [[NRFOldGamesTableViewController alloc] initWithGames:self.games inMode:OLD_GAMES_PLAY_MODE];
    [self.navigationController pushViewController:oldGames animated:YES];
}
- (void)editGame:(id)sender {
    NRFOldGamesTableViewController *oldGames = [[NRFOldGamesTableViewController alloc] initWithGames:self.games inMode:OLD_GAMES_EDIT_MODE];
    [self.navigationController pushViewController:oldGames animated:YES];
}
-(void)resumeGame:(id)sender{
    
}

-(void)tabBarViewControllerDidFinishWithEditedGame:(NRFJeopardyGameEditable *)editableGame
{
    [self.games addObject:editableGame];
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)mainBoardViewControllerDidFinishWithGame:(NRFJeopardyGamePlayable *)currentGame
{
    self.currentGame = currentGame;
    UIButton *button = self.resumeGameButton;
    [button setEnabled:YES];
    [button setTitle:@"Resume Game" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(resumeGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController popToViewController:self animated:YES];

}


@end
