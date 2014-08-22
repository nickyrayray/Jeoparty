//
//  NRFQuestionViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/13/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestionViewController.h"
#import "NRFScoreViewController.h"

@interface NRFQuestionViewController ()

@property (strong, nonatomic) NRFQuestion *question;
@property (strong, nonatomic) NRFJeopardyGamePlayable *game;
@property BOOL isDailyDouble;
@property BOOL isTransition;
@property (strong, nonatomic) NSString *transitionMessage;


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

-(id)initWithTransition:(NSString *)transitionMessage{
    
    self = [super init];
    
    if(self){
        
        self.isTransition = YES;
        self.isDailyDouble = NO;
        self.transitionMessage = transitionMessage;
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
        questionButton = [[UIButton alloc] initWithFrame:self.view.frame];
        UIImage *buttonImage = [UIImage imageNamed:@"DailyDouble.png"];
        [questionButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [questionButton addTarget:self action:@selector(dailyDoublePressed:) forControlEvents:UIControlEventTouchUpInside];
        [questionButton setAdjustsImageWhenHighlighted:NO];
        [self.view addSubview:questionButton];
    } else if(self.isTransition){
        questionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 984, 728)];
        [questionButton setTitle:self.transitionMessage forState:UIControlStateNormal];
    } else {
        questionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 984, 728)];
        questionButton.adjustsImageWhenHighlighted = NO;
        questionButton.backgroundColor = [UIColor blueColor];
        [questionButton.titleLabel setTextColor:[UIColor whiteColor]];
        UIFont *customFont = [UIFont fontWithName:@"Hoefler Text" size:70];
        questionButton.titleLabel.font = customFont;
        [questionButton addTarget:self action:@selector(questionAnswered:) forControlEvents:UIControlEventTouchUpInside];
        [questionButton setTitle:self.question.question forState:UIControlStateNormal];
        [self.view addSubview:questionButton];
    }
    
    self.navigationItem.title = @"Selected Question";
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void) dailyDoublePressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)questionAnswered:(id)sender {
    
    NRFScoreViewController *scoreVC = [[NRFScoreViewController alloc] initWithGame:self.game andQuestion:self.question];
    scoreVC.delegate = self;
    [self.navigationController pushViewController:scoreVC animated:YES];
    
}

-(void)scoreVCDidFinish{
    
    
    if(self.isTransition)
        [self.delegate questionViewControllerDidFinishTransition];
    else
        [self.delegate questionViewController:self didFinishWithQuestion:self.question];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillDisappear:(BOOL)animated {
    if(self.isDailyDouble){
        NRFQuestionViewController *questionVC = [[NRFQuestionViewController alloc] initWithQuestion:self.question
                                                                                            andGame:self.game
                                                                                      isDailyDouble:NO];
        questionVC.delegate = self.delegate;
        [self.navigationController pushViewController:questionVC animated:NO];
    } else {
        [super viewWillDisappear:animated];
    }
}


@end
