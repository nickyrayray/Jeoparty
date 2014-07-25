//
//  NRFMainBoardViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFMainBoardViewController.h"

@interface NRFMainBoardViewController ()

@property (strong, nonatomic) NSString *mode;
@property int questionsRemaining;
@property BOOL transitioningToDouble;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *categoryPanels;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *questionPanels;




@end

@implementation NRFMainBoardViewController

-(id)initWithGame:(NRFJeopardyGame *)game inMode:(NSString *)mode
{
    self = [super initWithNibName:@"NRFMainBoardViewController" bundle:nil];
    if(self){
        if(game == nil)
            self.game = [[NRFJeopardyGame alloc] init];
        else
            self.game = game;
        
        self.mode = mode;
        self.transitioningToDouble = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *current;
    
    if([self.mode isEqualToString:@"doubleJPrep"]){
        
        for(int i = 0; i < self.questionPanels.count; i++){
            current = self.questionPanels[i];
            NSString *currentAmount = current.currentTitle;
            currentAmount = [currentAmount stringByReplacingOccurrencesOfString:@"$" withString:@""];
            int value = [currentAmount intValue];
            [current setTitle:[NSString stringWithFormat:@"$%d", value*2] forState:UIControlStateNormal];
        }
        
        for(int i = 0; i < self.questionPanels.count; i++){
            current = self.questionPanels[i];
            NSString *currentAmount = current.currentTitle;
            currentAmount = [currentAmount stringByReplacingOccurrencesOfString:@"$" withString:@""];
            [self.game addDoubleQuestionWithValue:[currentAmount intValue] atIndex:i];
        }
        
        for(int i =0; i < self.categoryPanels.count; i++) {
            [self.game addDoubleCategoryAtIndex:i];
        }

    } else if([self.mode isEqualToString:@"regJPrep"]){
    
        for(int i = 0; i < self.questionPanels.count; i++){
            current = self.questionPanels[i];
            NSString *currentAmount = current.currentTitle;
            currentAmount = [currentAmount stringByReplacingOccurrencesOfString:@"$" withString:@""];
            [self.game addQuestionWithValue:[currentAmount intValue] atIndex:i];
        }
        
        for(int i =0; i < self.categoryPanels.count; i++) {
            [self.game addCategoryAtIndex:i];
        }
        
    } else if ([self.mode isEqualToString:@"doubleJ"]){
        
        for(int i = 0; i < self.questionPanels.count; i++){
            current = self.questionPanels[i];
            NSString *currentAmount = current.currentTitle;
            currentAmount = [currentAmount stringByReplacingOccurrencesOfString:@"$" withString:@""];
            int value = [currentAmount intValue];
            [current setTitle:[NSString stringWithFormat:@"$%d", value*2] forState:UIControlStateNormal];
        }
        
    }
    
    if([self wePlayin]){
        
        NSMutableArray *cats;
        UIButton *current;
        
         if([self.mode isEqualToString:@"regJ"]){
             
            if(![self.game dailyDoublesAreSet]){
                [self.game setDailyDoubles];
            }
             
            cats = self.game.categories;
             
         } else
            cats = self.game.doubleCategories;
        
        for(int i = 0; i < self.categoryPanels.count; i++){
            current = self.categoryPanels[i];
            current.showsTouchWhenHighlighted = NO;
            [current setTitle:cats[i] forState:UIControlStateNormal];
        }
    } else {
        self.navigationItem.title = @"Main Board: Edit Mode";
        [self.navigationController setNavigationBarHidden:NO];
    }
    
}

-(BOOL)wePlayin{
    if([self.mode isEqualToString:@"regJ"] || [self.mode isEqualToString:@"doubleJ"])
        return YES;
    else
        return NO;
}

-(void) questionEditViewController:(NRFQuestionEditViewController *)questionEditVC didFinishWithQuestion:(NRFQuestion *)question
{
    
    UIButton *questionPanel;
    
    if([self.mode isEqualToString:@"regJPrep"])
        questionPanel = [self.questionPanels objectAtIndex:[self.game.questions indexOfObject:question]];
    else
        questionPanel = [self.questionPanels objectAtIndex:[self.game.doubleQuestions indexOfObject:question]];
    
    if([question isFinished]){
        questionPanel.titleLabel.font = [UIFont systemFontOfSize:17];
        [questionPanel setTitle:question.question forState:UIControlStateNormal];
    } else {
        questionPanel.titleLabel.font = [UIFont boldSystemFontOfSize:50];
        [questionPanel setTitle:[NSString stringWithFormat:@"$%d", question.value] forState:UIControlStateNormal];
    }
    
    [self updateUI];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)catEditViewController:(NRFCategoryEditViewController *)catEditVC didFinishWithCat:(NSString *)category forIndex:(int)index{
    
    UIButton *catPanel;
    if([self.mode isEqualToString:@"regJPrep"]){
        catPanel = [self.categoryPanels objectAtIndex:index];
        [self.game updateCategory:category atIndex:index];
    }else{
        catPanel = [self.categoryPanels objectAtIndex:index];
        [self.game updateDoubleCategory:category atIndex:index];
    }
    
    [catPanel setTitle:category forState:UIControlStateNormal];
    
    [self updateUI];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)questionViewController:(NRFQuestionViewController *)questionVC didFinishWithQuestion:(NRFQuestion *)question
{
    question.chosen = YES;
    int index;
    
    if([self.mode isEqualToString:@"regJ"])
        index = [self.game.questions indexOfObject:question];
    else
        index = [self.game.doubleQuestions indexOfObject:question];
    
    UIButton *buttonToDisable = self.questionPanels[index];
    [buttonToDisable setUserInteractionEnabled:NO];
    [buttonToDisable setTitle:@"" forState:UIControlStateNormal];
    
    [self.navigationController popViewControllerAnimated:NO];
    [self updateUI];
    
}

-(void)questionViewControllerDidFinishTransition{
    
    self.transitioningToDouble = YES;
    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController popViewControllerAnimated:NO];
    
}


-(void)updateUI
{
    if([self.mode isEqualToString:@"regJPrep"] && [self.game isDoneWithReg]){
        NRFMainBoardViewController *doubleJMBVC = [[NRFMainBoardViewController alloc] initWithGame:self.game inMode:@"doubleJPrep"];
        [self presentViewController:doubleJMBVC animated:YES completion:nil];
    }
    
    /*else if([self.mode isEqualToString:@"doubleJPrep"] && [self.game isDoneWithDouble]){
        NRFMainBoardViewController *regJRoundMBVC = [[NRFMainBoardViewController alloc] initWithGame:self.game inMode:@"regJ"];
        [self presentViewController:regJRoundMBVC animated:YES completion:nil];*/
      else if ([self.mode isEqualToString:@"regJ"] && [self.game isDoneWithRegRound]){
          NRFQuestionViewController *questionVC = [[NRFQuestionViewController alloc] initWithTransition:@"Ready For Double Jeopardy?"];
          questionVC.delegate = self;
          [self.navigationController pushViewController:questionVC animated:NO];
      }
    
}


- (IBAction)choseQuestionPanel:(UIButton *)sender {
        
    NRFQuestion *question;
    
    int index = [self.questionPanels indexOfObject:sender];
        
    if([self.mode isEqualToString:@"regJPrep"] || [self.mode isEqualToString:@"regJ"])
        question = [self.game getQuestionAtIndex:index];
    else
        question  = [self.game getDoubleQuestionAtIndex:index];
    
    
    if(![self wePlayin]){
        
        NRFQuestionEditViewController *questionEditVC = [[NRFQuestionEditViewController alloc] initWithQuestion:question];
        questionEditVC.delegate = self;
        
        [self.navigationController pushViewController:questionEditVC animated:YES];
        
    } else {
        
        NRFQuestionViewController *questionVC;
        if([self.mode isEqualToString:@"regJ"]){
            if([self.game questionIsDailyDouble:index forMode:@"regJ"])
                questionVC = [[NRFQuestionViewController alloc] initWithQuestion:question andGame:self.game isDailyDouble:YES];
            else
                questionVC = [[NRFQuestionViewController alloc] initWithQuestion:question andGame:self.game isDailyDouble:NO];
        } else {
            if([self.game questionIsDailyDouble:index forMode:@"doubleJ"])
                questionVC = [[NRFQuestionViewController alloc] initWithQuestion:question andGame:self.game isDailyDouble:YES];
            else
                questionVC = [[NRFQuestionViewController alloc] initWithQuestion:question andGame:self.game isDailyDouble:NO];
        }
        questionVC.delegate = self;
        
        [self.navigationController pushViewController:questionVC animated:NO];
        
    }
    
}

- (IBAction)choseCategoryPanel:(UIButton *)sender {
    
    if([self.mode isEqualToString:@"regJPrep"] || [self.mode isEqualToString:@"doubleJPrep"]){
        
        NSString *categoryToEdit;
        int index = [self.categoryPanels indexOfObject:sender];
        
        if([self.mode isEqualToString:@"regJPrep"])
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

-(BOOL)doesGameExist
{
    if([self.game.questions count] != 0)
        return YES;
    else
        return NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    if([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
        [self.navigationController setNavigationBarHidden:YES];
    else
        [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    if(self.transitioningToDouble){
        NRFMainBoardViewController *doubleJ = [[NRFMainBoardViewController alloc] initWithGame:self.game inMode:@"doubleJ"];
        [self.navigationController pushViewController:doubleJ animated:NO];
    }
}





@end
