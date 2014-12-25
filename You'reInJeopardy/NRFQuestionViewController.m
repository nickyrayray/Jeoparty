//
//  NRFQuestionViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/13/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestionViewController.h"

@interface NRFQuestionViewController () <NRFQuestionScoreViewControllerDelegate, NRFWagerForDailyDoubleScoreViewControllerDelegate>

@property (strong, nonatomic) NRFQuestion *question;
@property (strong, nonatomic) NRFJeopardyGamePlayable *game;
@property BOOL isDailyDouble;

@end

@implementation NRFQuestionViewController

- (id)initWithQuestion:(NRFQuestion *)question andGame:(NRFJeopardyGamePlayable *)game isDailyDouble:(BOOL)isDailyDouble
{
    self = [super init];
    if (self) {
        self.question = question;
        self.isDailyDouble = isDailyDouble;
        self.game = game;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *questionButton;
    
    if(self.isDailyDouble){
        CGRect portraitScreen = [[UIScreen mainScreen]applicationFrame];
        questionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, portraitScreen.size.width, portraitScreen.size.height)];
        UIImage *buttonImage = [UIImage imageNamed:@"DailyDouble.png"];
        [questionButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [questionButton addTarget:self action:@selector(dailyDoublePressed:) forControlEvents:UIControlEventTouchUpInside];
        [questionButton setAdjustsImageWhenHighlighted:NO];
    } else {
        questionButton = [self createQuestionButton];
    }
    
    [self.view addSubview:questionButton];
    
    self.navigationItem.title = @"Selected Question";
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void) dailyDoublePressed:(UIButton *)sender
{
    NRFWagerForDailyDoubleScoreViewController *wagerScoreVC = [[NRFWagerForDailyDoubleScoreViewController alloc]initWithGame:self.game];
    wagerScoreVC.delegate = self;
    [self.navigationController pushViewController:wagerScoreVC animated:NO];
    [sender removeFromSuperview];
    [self.view addSubview:[self createQuestionButton]];
}

-(void)viewAnswer:(id)sender
{
    UIButton *answerButton = [self createAnswerButton];
    [sender removeFromSuperview];
    [self.view addSubview:answerButton];
}

-(void)questionAnswered:(id)sender
{
    
    if(self.isDailyDouble){
        NRFWagerRewardScoreViewController *scoreVC = [[NRFWagerRewardScoreViewController alloc]initWithGame:self.game];
        scoreVC.delegate = self;
        [self.navigationController pushViewController:scoreVC animated:NO];
    }else{
        NRFQuestionScoreViewController *scoreVC = [[NRFQuestionScoreViewController alloc]initWithGame:self.game andQuestion:self.question];
        scoreVC.delegate = self;
        [self.navigationController pushViewController:scoreVC animated:NO];
    }
    
}

-(void)questionScoreViewControllerDidFinish
{
    [self.navigationController popViewControllerAnimated:NO];
    [self.delegate questionViewController:self didFinishWithQuestion:self.question];
}

-(void)wagerForDailyDoubleScoreViewControllerDidFinish{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)wagerRewardScoreViewControllerDelegateDidFinish
{
    [self.navigationController popViewControllerAnimated:NO];
    [self.delegate questionViewController:self didFinishWithQuestion:self.question];
}

-(UIButton *)createQuestionButton
{
    UIButton *questionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 984, 728)];
    questionButton.adjustsImageWhenHighlighted = NO;
    questionButton.backgroundColor = [UIColor blueColor];
    [questionButton.titleLabel setTextColor:[UIColor whiteColor]];
    UIFont *customFont = [UIFont fontWithName:@"Hoefler Text" size:70];
    questionButton.titleLabel.font = customFont;
    [questionButton addTarget:self action:@selector(viewAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [questionButton setTitle:self.question.question forState:UIControlStateNormal];
    return questionButton;
}

-(UIButton *)createAnswerButton
{
    UIButton *questionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 984, 728)];
    questionButton.adjustsImageWhenHighlighted = NO;
    questionButton.backgroundColor = [UIColor blueColor];
    [questionButton.titleLabel setTextColor:[UIColor whiteColor]];
    UIFont *customFont = [UIFont fontWithName:@"Hoefler Text" size:70];
    questionButton.titleLabel.font = customFont;
    [questionButton addTarget:self action:@selector(questionAnswered:) forControlEvents:UIControlEventTouchUpInside];
    [questionButton setTitle:self.question.answer forState:UIControlStateNormal];
    return questionButton;
}




@end
