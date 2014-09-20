//
//  NRFMainBoardViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFMainBoardViewController.h"

@interface NRFMainBoardViewController () <NRFQuestionEditViewControllerDelegate, NRFQuestionViewControllerDelegate, NRFCategoryEditViewControllerDelegate>

@property int mode;

@end

@implementation NRFMainBoardViewController


-(id)initWithEditableGame:(NRFJeopardyGameEditable *)game inMode:(int)mode
{
    self = [super init];
    if(self){
        self.game = game;
        self.mode = mode;
    }
    return self;
}

-(id)initWithPlayableGame:(NRFJeopardyGamePlayable *)game inMode:(int)mode
{
    self = [super init];
    if(self){
        self.game = game;
        self.mode = mode;
    }
    return self;
}

-(id)initWithPlayableGameFromEditableGame:(NRFJeopardyGameEditable *)game inMode:(int)mode
{
    self = [super init];
    if(self){
        self.game = [NRFJeopardyGamePlayable makeCopyOfGame:game];
        self.mode = mode;
    }
    return self;
}


-(void)loadView
{
    [super loadView];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.height, scrollView.frame.size.width + self.tabBarController.tabBar.frame.size.height);
    scrollView.backgroundColor = [UIColor blueColor];
    self.view = scrollView;
    self.categoryPanels = [[NSMutableArray alloc]init];
    self.questionPanels = [[NSMutableArray alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frameSize = self.view.frame;
    float buttonWidth = (frameSize.size.width)/6 + (20/(TOTAL_QUESTION_PANELS/TOTAL_CATEGORY_PANELS + 1));
    float buttonHeight = (frameSize.size.height/6);
    UIButton *buttonToCreate;
    
    for(int i = 0; i < TOTAL_CATEGORY_PANELS; i++){
        for(int j = 0; j < (TOTAL_QUESTION_PANELS / TOTAL_CATEGORY_PANELS) + 1; j++){
            buttonToCreate = [[UIButton alloc] initWithFrame:CGRectMake(j*buttonHeight, i*buttonWidth, buttonHeight, buttonWidth)];
            [buttonToCreate setBackgroundImage:[UIImage imageNamed:@"Square.png"] forState:UIControlStateNormal];
            buttonToCreate.adjustsImageWhenDisabled = NO;
            buttonToCreate.adjustsImageWhenHighlighted = NO;
            if(i == 0){
                buttonToCreate.titleLabel.font = [UIFont systemFontOfSize:18];
                [buttonToCreate setTitle:@"Select Category" forState:UIControlStateNormal];
                buttonToCreate.titleLabel.numberOfLines = 2;
                [buttonToCreate addTarget:self action:@selector(choseCategoryPanel:) forControlEvents:UIControlEventTouchUpInside];
                [self.categoryPanels addObject:buttonToCreate];
                [self.view addSubview:buttonToCreate];
            } else {
                [buttonToCreate.titleLabel setFont:[UIFont boldSystemFontOfSize:50]];
                [buttonToCreate setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
                [buttonToCreate setTitle:[NSString stringWithFormat:@"$%d", i*200] forState:UIControlStateNormal];
                buttonToCreate.titleLabel.numberOfLines = 4;
                buttonToCreate.titleLabel.textAlignment = NSTextAlignmentCenter;
                [buttonToCreate addTarget:self action:@selector(choseQuestionPanel:) forControlEvents:UIControlEventTouchUpInside];
                [self.questionPanels addObject:buttonToCreate];
                [self.view addSubview:buttonToCreate];
            }
        }
    }
    
    UIButton *current;
    
    if(![self isBoardRegularType]){
        
        for(int i = 0; i < self.questionPanels.count; i++){ //Loop just doubles the titles on the buttons.
            current = self.questionPanels[i];
            NSString *currentAmount = current.currentTitle;
            currentAmount = [currentAmount stringByReplacingOccurrencesOfString:@"$" withString:@""];
            int value = [currentAmount intValue];
            [current setTitle:[NSString stringWithFormat:@"$%d", value*2] forState:UIControlStateNormal];
        }
        
        if(!self.game.doubleQuestions){
            [self.game createDoubleQuestionArrayWithSize:self.questionPanels.count];
            [self.game createDoubleCategoryArrayWithSize:self.categoryPanels.count];
        } else {
            [self updateViewWithGameData];
        }
        
    } else if(self.mode == REGULAR_JEOPARDY_SETUP){
        
        if(!self.game.questions){
            [self.game createQuestionArrayWithSize:self.questionPanels.count];
            [self.game createCategoryArrayWithSize:self.categoryPanels.count];
            [self.game setMaxQuestionCount:(int)self.questionPanels.count];
            [self.game setMaxCategoryCount:(int)self.categoryPanels.count];
        } else {
            [self updateViewWithGameData];
        }
        
    }
    
    if([self isBoardInPlayMode]){
        
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
        NSMutableArray *cats;
        UIButton *current;
        
        NRFJeopardyGamePlayable *castedPlayableGame = (NRFJeopardyGamePlayable *)self.game;
        
        if(self.mode == REGULAR_JEOPARDY_PLAY){
            
            if(![castedPlayableGame dailyDoublesAreSet]){
                [castedPlayableGame setDailyDoubles];
            }
            
            cats = castedPlayableGame.categories;
            
        } else
            cats = castedPlayableGame.doubleCategories;
        
        for(int i = 0; i < self.categoryPanels.count; i++){
            current = self.categoryPanels[i];
            current.showsTouchWhenHighlighted = NO;
            [current setTitle:cats[i] forState:UIControlStateNormal];
        }
        
        UIBarButtonItem *editScores = [[UIBarButtonItem alloc] initWithTitle:@"Edit Scores" style:UIBarButtonItemStyleDone target:self action:@selector(editButtonPressed:)];
        self.navigationItem.rightBarButtonItem = editScores;
        
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                    target:self
                                                                                    action:@selector(saveButtonPressed:)];
        self.navigationItem.leftBarButtonItem = saveButton;
        self.navigationItem.title = castedPlayableGame.gameTitle;
    } else {
        
        [self.navigationController setNavigationBarHidden:NO];
        
    }

    
    
}

-(void)saveButtonPressed:(id)sender
{
    NRFMainMenuViewController *mainMenuVC = self.navigationController.viewControllers[0];
    NRFJeopardyGamePlayable *castedPG = (NRFJeopardyGamePlayable *)self.game;
    [mainMenuVC mainBoardViewControllerDidFinishWithGame:castedPG];
}

-(void)editButtonPressed:(id)sender
{
    NRFJeopardyGamePlayable *castedPlayableGame = (NRFJeopardyGamePlayable *)self.game;
    NRFEditScoreViewController *scoreVC = [[NRFEditScoreViewController alloc]initWithGame:castedPlayableGame];
    [self.navigationController pushViewController:scoreVC animated:YES];
}

-(void) questionEditViewControllerDidFinishWithQuestion:(NRFQuestion *)question mightNeedIncrement:(BOOL)mightNeedIncrement
{
    
    UIButton *questionPanel;
    
    NRFJeopardyGameEditable *castedEditGame = (NRFJeopardyGameEditable *)self.game;
    
    if(self.mode == REGULAR_JEOPARDY_SETUP){
        questionPanel = [self.questionPanels objectAtIndex:[self.game.questions indexOfObject:question]];
        if([question isFinished] && mightNeedIncrement)
            [castedEditGame incrementQuestionsEdited];
        else if(![question isFinished] && !mightNeedIncrement)
            [castedEditGame decrementQuestionsEdited];
    }else{
        questionPanel = [self.questionPanels objectAtIndex:[self.game.doubleQuestions indexOfObject:question]];
        if([question isFinished] && mightNeedIncrement)
            [castedEditGame incrementDoubleQuestionsEdited];
        else if(![question isFinished] && !mightNeedIncrement)
            [castedEditGame decrementDoubleQuestionsEdited];
    }
    
    if([question isFinished]){
        questionPanel.titleLabel.font = [UIFont systemFontOfSize:17];
        [questionPanel setTitle:question.question forState:UIControlStateNormal];
    } else {
        questionPanel.titleLabel.font = [UIFont boldSystemFontOfSize:50];
        [questionPanel setTitle:[NSString stringWithFormat:@"$%d", question.value] forState:UIControlStateNormal];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    [(NRFTabBarViewController *)self.tabBarController checkForGameIsCompletelyEditedAndUpdateTabBarController];
    
}

-(void)catEditViewController:(NRFCategoryEditViewController *)catEditVC didFinishWithCat:(NSString *)category forIndex:(int)index andMightNeedIncrement:(BOOL)mightNeedIncrement{
    
    UIButton *catPanel;
    NRFJeopardyGameEditable *castedEditVC = (NRFJeopardyGameEditable *)self.game;
    if(self.mode == REGULAR_JEOPARDY_SETUP){
        catPanel = [self.categoryPanels objectAtIndex:index];
        castedEditVC.categories[index] = category;
        if((category == nil || [category isEqualToString:@""]) && !mightNeedIncrement)
            [castedEditVC decrementCategoriesCompleted];
        else if(category && ![category isEqualToString:@""] && mightNeedIncrement)
            [castedEditVC incrementCategoriesCompleted];
    }else{
        catPanel = [self.categoryPanels objectAtIndex:index];
        castedEditVC.doubleCategories[index] = category;
        if((category == nil || [category isEqualToString:@""]) && !mightNeedIncrement)
            [castedEditVC decrementDoubleCategoriesCompleted];
        else if(category && ![category isEqualToString:@""] && mightNeedIncrement)
            [castedEditVC incrementDoubleCategoriesCompleted];
    }
    
    if(category && ![category isEqualToString:@""])
        [catPanel setTitle:category forState:UIControlStateNormal];
    else
        [catPanel setTitle:@"Select Category" forState:UIControlStateNormal];
    
    [self.navigationController popViewControllerAnimated:YES];
    [(NRFTabBarViewController *)self.tabBarController checkForGameIsCompletelyEditedAndUpdateTabBarController];
    
}

-(void)questionViewController:(NRFQuestionViewController *)questionVC didFinishWithQuestion:(NRFQuestion *)question
{
    question.chosen = YES;
    NSUInteger index;
    NRFJeopardyGamePlayable *castedPlayableGame = (NRFJeopardyGamePlayable *)self.game;
    
    if(self.mode == REGULAR_JEOPARDY_PLAY){
        index = [self.game.questions indexOfObject:question];
        [castedPlayableGame incrementQuestionsAnswered];
    }else{
        index = [self.game.doubleQuestions indexOfObject:question];
        [castedPlayableGame incrementDoubleQuestionsAnswered];
    }
    
    UIButton *buttonToDisable = self.questionPanels[index];
    [buttonToDisable setUserInteractionEnabled:NO];
    [buttonToDisable setTitle:@"" forState:UIControlStateNormal];
    
    [self.navigationController popViewControllerAnimated:NO];
    
    if([castedPlayableGame regularJeopartyIsCompletelyPlayed] && self.mode == REGULAR_JEOPARDY_PLAY){
        NRFQuestionViewController *messageVC = [[NRFQuestionViewController alloc]initWithTransition:@"Ready for Double Jeoparty?\n\nTap Here to Play!"];
        messageVC.delegate = self;
        [self.navigationController pushViewController:messageVC animated:YES];
    } else if([castedPlayableGame doubleJeopartyIsCompletelyPlayed] && self.mode == DOUBLE_JEOPARDY_PLAY){
        NRFQuestionViewController *messageVC = [[NRFQuestionViewController alloc]initWithTransition:@"Final Jeoparty"];
        messageVC.delegate = self;
        [self.navigationController pushViewController:messageVC animated:YES];
    }
}

-(void)questionViewControllerDidFinishTransition{
    NRFJeopardyGamePlayable *game = (NRFJeopardyGamePlayable *)self.game;
    NRFMainBoardViewController *mainBoardDoubleVC = [[NRFMainBoardViewController alloc]initWithPlayableGame:game inMode:DOUBLE_JEOPARDY_PLAY];
    NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
    NSMutableArray *mutableViewControllers = [self.navigationController.viewControllers mutableCopy];
    [mutableViewControllers insertObject:mainBoardDoubleVC atIndex:index];
    self.navigationController.viewControllers = mutableViewControllers;
    [self.navigationController popToViewController:mainBoardDoubleVC animated:YES];
}

-(void)questionViewControllerDidFinishFinalJeopartyTransition
{
}


- (void)choseQuestionPanel:(UIButton *)sender {
    
    int index = (int)[self.questionPanels indexOfObject:sender];
    
    NRFQuestion *question = [self getQuestionForProperModeAtIndex:index];
    
    if(question.value == 0){
        NRFJeopardyGameEditable *castedEditGame = (NRFJeopardyGameEditable *)self.game;
        UIButton *current = self.questionPanels[index];
        NSString *currentAmount = current.currentTitle;
        currentAmount = [currentAmount stringByReplacingOccurrencesOfString:@"$" withString:@""];
        question = [[NRFQuestion alloc] initWithValue:[currentAmount intValue]];
        if(self.mode == REGULAR_JEOPARDY_SETUP)
            [castedEditGame addQuestion:question atIndex:index];
        else
            [castedEditGame addDoubleQuestion:question atIndex:index];
    }
    
    if(![self isBoardInPlayMode]){
        
        NRFQuestionEditViewController *questionEditVC = [[NRFQuestionEditViewController alloc] initWithQuestion:question];
        questionEditVC.delegate = self;
        
        [self.navigationController pushViewController:questionEditVC animated:YES];
        
    } else {
        
        NRFQuestionViewController *questionVC;
        NRFJeopardyGamePlayable *castedPlayableGame = (NRFJeopardyGamePlayable *)self.game;
        if(self.mode == REGULAR_JEOPARDY_PLAY){
            if([castedPlayableGame questionIsDailyDouble:index forMode:REGULAR_JEOPARDY_PLAY])
                questionVC = [[NRFQuestionViewController alloc] initWithQuestion:question andGame:self.game isDailyDouble:YES];
            else
                questionVC = [[NRFQuestionViewController alloc] initWithQuestion:question andGame:self.game isDailyDouble:NO];
        } else {
            if([castedPlayableGame questionIsDailyDouble:index forMode:DOUBLE_JEOPARDY_PLAY])
                questionVC = [[NRFQuestionViewController alloc] initWithQuestion:question andGame:self.game isDailyDouble:YES];
            else
                questionVC = [[NRFQuestionViewController alloc] initWithQuestion:question andGame:self.game isDailyDouble:NO];
        }
        questionVC.delegate = self;
        
        [self.navigationController pushViewController:questionVC animated:NO];
        
    }
    
}

- (void)choseCategoryPanel:(UIButton *)sender {
    
    if(![self isBoardInPlayMode]){
        
        int index = (int)[self.categoryPanels indexOfObject:sender];
        
        NSString *categoryToEdit = [self getCategoryForProperModeAtIndex:index];
        
        NRFCategoryEditViewController *catEditVC = [[NRFCategoryEditViewController alloc] initWithCat:categoryToEdit atIndex:index];
        catEditVC.delegate = self;
        
        [self.navigationController pushViewController:catEditVC animated:YES];
        
    } else {
        if([self.navigationController isNavigationBarHidden]){
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }else{
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            [[UIApplication sharedApplication]setStatusBarHidden:YES];
        }
    }
    
}

-(void)updateViewWithGameData
{
    UIButton *buttonInQuestion;
    NRFQuestion *questionInQuestion;
    if(self.mode == REGULAR_JEOPARDY_SETUP){
        for(int i = 0; i < self.game.questions.count; i++){
            if([[self.game getQuestionAtIndex:i] isFinished]){
                buttonInQuestion = self.questionPanels[i];
                questionInQuestion = [self.game getQuestionAtIndex:i];
                buttonInQuestion.titleLabel.font = [UIFont systemFontOfSize:17];
                buttonInQuestion.titleLabel.text = questionInQuestion.question;
            }
        }
        
        for(int i = 0; i < self.game.categories.count; i++){
            if(self.game.categories[i] && ![self.game.categories[i] isEqualToString:@""]){
                buttonInQuestion = self.categoryPanels[i];
                buttonInQuestion.titleLabel.text = self.game.categories[i];
            }
        }
    } else if(self.mode == DOUBLE_JEOPARDY_SETUP){
        for(int i = 0; i < self.game.doubleQuestions.count; i++){
            if([[self.game getQuestionAtIndex:i] isFinished]){
                buttonInQuestion = self.questionPanels[i];
                questionInQuestion = [self.game getDoubleQuestionAtIndex:i];
                buttonInQuestion.titleLabel.font = [UIFont systemFontOfSize:17];
                buttonInQuestion.titleLabel.text = questionInQuestion.question;
            }
        }
        
        for(int i = 0; i < self.game.doubleCategories.count; i++){
            if(self.game.doubleCategories[i] && ![self.game.doubleCategories[i] isEqualToString:@""]){
                buttonInQuestion = self.categoryPanels[i];
                buttonInQuestion.titleLabel.text = self.game.doubleCategories[i];
            }
        }
    }
}

-(BOOL)isBoardInPlayMode{
    if(self.mode == REGULAR_JEOPARDY_PLAY || self.mode == DOUBLE_JEOPARDY_PLAY)
        return YES;
    else
        return NO;
}

-(BOOL)isBoardRegularType
{
    if(self.mode == REGULAR_JEOPARDY_PLAY || self.mode == REGULAR_JEOPARDY_SETUP)
        return YES;
    else
        return NO;
}

-(NRFQuestion *)getQuestionForProperModeAtIndex:(int)index
{
    if([self isBoardRegularType])
        return [self.game getQuestionAtIndex:index];
    else
        return [self.game getDoubleQuestionAtIndex:index];
}

-(NSString *)getCategoryForProperModeAtIndex:(int)index
{
    if([self isBoardRegularType])
        return [self.game getCatAtIndex:index];
    else
        return [self.game getDoubleCatAtIndex:index];
}

@end
