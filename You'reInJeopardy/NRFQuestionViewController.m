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
@property (strong, nonatomic) NRFJeopardyGame *game;
@property (weak, nonatomic) IBOutlet UIButton *questionDisplay;
@property (weak, nonatomic) UIButton *dailyDouble;
@property BOOL isDailyDouble;
@property BOOL isTransition;
@property (strong, nonatomic) NSString *transitionMessage;


@end

@implementation NRFQuestionViewController

- (id)initWithQuestion:(NRFQuestion *)question andGame:(NRFJeopardyGame *)game isDailyDouble:(BOOL)isDailyDouble
{
    if(isDailyDouble){
        self = [super init];
    } else {
        self = [super initWithNibName:@"NRFQuestionViewController" bundle:nil];
    }
    if (self) {
        self.question = question;
        self.isDailyDouble = isDailyDouble;
        self.game = game;
    }
    return self;
}

-(id)initWithTransition:(NSString *)transitionMessage{
    
    self = [super initWithNibName:@"NRFQuestionViewController" bundle:nil];
    
    if(self){
        
        self.isTransition = YES;
        self.isDailyDouble = NO;
        self.transitionMessage = transitionMessage;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.isDailyDouble){
        UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
        UIImage *buttonImage = [UIImage imageNamed:@"DailyDouble.png"];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(dailyDoublePressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        self.dailyDouble = button;
    } else if(self.isTransition){
        [self.questionDisplay setTitle:self.transitionMessage forState:UIControlStateNormal];
    } else {
        [self.questionDisplay setTitle:self.question.question forState:UIControlStateNormal];

    }
    
    self.navigationItem.title = @"Selected Question";
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void) dailyDoublePressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)questionAnswered:(id)sender {
    
    NRFScoreViewController *scoreVC = [[NRFScoreViewController alloc] initWithGame:self.game andQuestion:self.question];
    scoreVC.delegate = self;
    [self.navigationController pushViewController:scoreVC animated:NO];
    
}

-(void)scoreVCDidFinish{
    if(self.isTransition)
        [self.delegate questionViewControllerDidFinishTransition];
    else
        [self.delegate questionViewController:self didFinishWithQuestion:self.question];
}

-(void) viewWillDisappear:(BOOL)animated {
    if(self.dailyDouble){
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
