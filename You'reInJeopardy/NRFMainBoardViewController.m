//
//  NRFMainBoardViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFMainBoardViewController.h"

@interface NRFMainBoardViewController ()

@property int mode;
@property BOOL transitioningToDouble;

@property (strong, nonatomic) NSMutableArray *questionPanels;
@property (strong, nonatomic) NSMutableArray *categoryPanels;

@property (strong, nonatomic) UIScrollView *scrollView;




@end

@implementation NRFMainBoardViewController


-(id)initWithEditableGame:(NRFJeopardyGameEditable *)game inMode:(int)mode
{
    self = [super init];
    if(self){
        self.game = game;
        self.mode = mode;
        self.transitioningToDouble = NO;
    }
    return self;
}

-(id)initWithPlayableGame:(NRFJeopardyGamePlayable *)game inMode:(int)mode
{
    self = [super init];
    if(self){
        self.game = game;
        self.mode = mode;
        self.transitioningToDouble = NO;
    }
    return self;
}

-(id)initWithPlayableGameFromEditableGame:(NRFJeopardyGameEditable *)game inMode:(int)mode
{
    self = [super init];
    if(self){
        self.game = [NRFJeopardyGamePlayable makeCopyOfGame:game];
        self.mode = mode;
        self.transitioningToDouble = NO;
    }
    return self;
}


-(void)loadView
{
    [super loadView];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.view = self.scrollView;
    self.categoryPanels = [[NSMutableArray alloc]init];
    self.questionPanels = [[NSMutableArray alloc]init];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frameSize = self.view.bounds;
    float buttonWidth = (frameSize.size.width)/6;
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
                [buttonToCreate addTarget:self action:@selector(choseCategoryPanel:) forControlEvents:UIControlEventTouchUpInside];
                [self.categoryPanels addObject:buttonToCreate];
                [self.view addSubview:buttonToCreate];
            } else {
                [buttonToCreate.titleLabel setFont:[UIFont boldSystemFontOfSize:50]];
                [buttonToCreate setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
                [buttonToCreate setTitle:[NSString stringWithFormat:@"$%d", i*200] forState:UIControlStateNormal];
                [buttonToCreate addTarget:self action:@selector(choseQuestionPanel:) forControlEvents:UIControlEventTouchUpInside];
                [self.questionPanels addObject:buttonToCreate];
                [self.view addSubview:buttonToCreate];
            }
        }
    }
    
    UIButton *current;
    
    if(self.mode == DOUBLE_JEOPARDY_SETUP || self.mode == DOUBLE_JEOPARDY_PLAY){
        
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
        }
        
    } else if(self.mode == REGULAR_JEOPARDY_SETUP){
        
        if(!self.game.questions){
            [self.game createQuestionArrayWithSize:self.questionPanels.count];
            [self.game createCategoryArrayWithSize:self.categoryPanels.count];
            [self.game setMaxQuestionCount:self.questionPanels.count];
            [self.game setMaxCategoryCount:self.categoryPanels.count];
        }
        
    }
    
    if([self wePlayin]){
        
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
        
        UIBarButtonItem *editScores = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                    target:self
                                                                                    action:@selector(editButtonPressed:)];
        editScores.title = @"Edit Scores";
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


-(void)editButtonPressed:(id)sender
{
    NRFJeopardyGamePlayable *castedPlayableGame = (NRFJeopardyGamePlayable *)self.game;
    NRFScoreViewController *scoreVC = [[NRFScoreViewController alloc] initWithGame:castedPlayableGame inInitializeMode:NO];
    scoreVC.delegate = self;
    [self.navigationController pushViewController:scoreVC animated:YES];
}

-(BOOL)wePlayin{
    if(self.mode == REGULAR_JEOPARDY_PLAY || self.mode == DOUBLE_JEOPARDY_PLAY)
        return YES;
    else
        return NO;
}

-(void)scoreVCDidFinish{
    [self.navigationController popViewControllerAnimated:YES];
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
    [self checkForFinishedGameAndUpdateTabViewController];
    
}

-(void)catEditViewController:(NRFCategoryEditViewController *)catEditVC didFinishWithCat:(NSString *)category forIndex:(int)index andMightNeedIncrement:(BOOL)mightNeedIncrement{
    
    UIButton *catPanel;
    NRFJeopardyGameEditable *castedEditVC = (NRFJeopardyGameEditable *)self.game;
    if(self.mode == REGULAR_JEOPARDY_SETUP){
        catPanel = [self.categoryPanels objectAtIndex:index];
        if((category == nil || [category isEqualToString:@""]) && !mightNeedIncrement)
            [castedEditVC decrementCategoriesCompleted];
        else if(category && ![category isEqualToString:@""] && mightNeedIncrement)
            [castedEditVC incrementCategoriesCompleted];
    }else{
        catPanel = [self.categoryPanels objectAtIndex:index];
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
    [self checkForFinishedGameAndUpdateTabViewController];
    
}

-(void)questionViewController:(NRFQuestionViewController *)questionVC didFinishWithQuestion:(NRFQuestion *)question
{
    question.chosen = YES;
    int index;
    
    if(self.mode == REGULAR_JEOPARDY_PLAY)
        index = [self.game.questions indexOfObject:question];
    else
        index = [self.game.doubleQuestions indexOfObject:question];
    
    UIButton *buttonToDisable = self.questionPanels[index];
    [buttonToDisable setUserInteractionEnabled:NO];
    [buttonToDisable setTitle:@"" forState:UIControlStateNormal];
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)questionViewControllerDidFinishTransition{
    
    self.transitioningToDouble = YES;
    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController popViewControllerAnimated:NO];
    
}


- (void)choseQuestionPanel:(UIButton *)sender {
        
    NRFQuestion *question;
    
    int index = [self.questionPanels indexOfObject:sender];
        
    if(self.mode == REGULAR_JEOPARDY_SETUP || self.mode == REGULAR_JEOPARDY_PLAY)
        question = [self.game getQuestionAtIndex:index];
    else
        question  = [self.game getDoubleQuestionAtIndex:index];
    
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
    
    if(![self wePlayin]){
        
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
    
    if(![self wePlayin]){
        
        NSString *categoryToEdit;
        
        int index = [self.categoryPanels indexOfObject:sender];
        
        if(self.mode == REGULAR_JEOPARDY_SETUP)
            categoryToEdit = [self.game getCatAtIndex:index];
        else
            categoryToEdit = [self.game getDoubleCatAtIndex:index];
        
        
        NRFCategoryEditViewController *catEditVC = [[NRFCategoryEditViewController alloc] initWithCat:categoryToEdit atIndex:index];
        catEditVC.delegate = self;
        
        [self.navigationController pushViewController:catEditVC animated:YES];
        
    } else {
        if([self.navigationController isNavigationBarHidden])
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        else
            [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
}

-(void)checkForFinishedGameAndUpdateTabViewController
{
    if([(NRFJeopardyGameEditable *)self.game checkForJeopartyGameCompletelyEdited])
        [(NRFTabBarViewController *)self.tabBarController gameIsCompletelyEdited];
}



@end
