//
//  NRFScoreViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/22/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFScoreViewController.h"

@interface NRFScoreViewController ()<UITextViewDelegate>

@property (strong, nonatomic) UIButton *navAppearDisappearButton;

@end

@implementation NRFScoreViewController

-(id)initWithGame:(NRFJeopardyGamePlayable *)game
{
    self = [super init];
    if(self){
        self.game = game;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    CGRect screen = [[UIScreen mainScreen]applicationFrame];
    self.view = [[UIScrollView alloc]initWithFrame:screen];
    self.view.backgroundColor = [UIColor blueColor];
    self.contestantOneName = [self createContestantNameTextViewWithFrame:CGRectMake(20, 219, 301, 219) forContestant:self.game.contestantOne];
    self.contestantTwoName = [self createContestantNameTextViewWithFrame:CGRectMake(362, 219, 301, 219) forContestant:self.game.contestantTwo];
    self.contestantThreeName = [self createContestantNameTextViewWithFrame:CGRectMake(703, 219, 301, 219) forContestant:self.game.contestantThree];
    self.contestantOneScore = [self createScoreDisplayLabelWithFrame:CGRectMake(0, 0, 341, 125) forContestant:self.game.contestantOne];
    self.contestantTwoScore = [self createScoreDisplayLabelWithFrame:CGRectMake(343, 0, 341, 125) forContestant:self.game.contestantTwo];
    self.contestantThreeScore = [self createScoreDisplayLabelWithFrame:CGRectMake(685, 0, 341, 125) forContestant:self.game.contestantThree];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.contestantOneScore];
    [self.view addSubview:self.contestantTwoScore];
    [self.view addSubview:self.contestantThreeScore];
    [self.view addSubview:self.contestantOneName];
    [self.view addSubview:self.contestantTwoName];
    [self.view addSubview:self.contestantThreeName];
    [self createContestantDividers];
}

-(NSString *)stringifyAndAddDollarSignToNumber:(int)number
{
    return [NSString stringWithFormat:@"$%d", number];
}

-(int)getIntValueFromLabel:(NSString *)labelString
{
    NSString *numberValue = [labelString stringByReplacingOccurrencesOfString:@"$" withString:@""];
    return [numberValue intValue];
    
}
/*

- (IBAction)topPressed:(id)sender {
    if([self.navigationController isNavigationBarHidden])
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    else
        [self.navigationController setNavigationBarHidden:YES animated:YES];
}
*/

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"Tap to Enter Contestant Name"])
        textView.text = @"";
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@""] || textView.text == nil)
        textView.text = @"Tap to Enter Contestant Name";
}

-(UILabel *)createScoreDisplayLabelWithFrame:(CGRect)frame forContestant:(NRFJeopartyContestant *)contestant{
    
    UILabel *labelToReturn = [[UILabel alloc]initWithFrame:frame];
    labelToReturn.font = [UIFont boldSystemFontOfSize:55];
    labelToReturn.textColor = [UIColor whiteColor];
    labelToReturn.backgroundColor = [UIColor blueColor];
    labelToReturn.textAlignment = NSTextAlignmentCenter;
    if(contestant && ![contestant.name isEqualToString:@""])
        labelToReturn.text = [self stringifyAndAddDollarSignToNumber:contestant.score];
    else
        labelToReturn.text = @"$0";
    
    return labelToReturn;
    
}

-(UITextView *)createContestantNameTextViewWithFrame:(CGRect)frame forContestant:(NRFJeopartyContestant *)contestant{
    
    UITextView *textViewToReturn = [[UITextView alloc]initWithFrame:frame];
    textViewToReturn.backgroundColor = [UIColor blueColor];
    textViewToReturn.textColor = [UIColor whiteColor];
    textViewToReturn.font = [UIFont fontWithName:@"Chalkboard SE" size:40];
    textViewToReturn.textAlignment = NSTextAlignmentCenter;
    textViewToReturn.editable = NO;
    textViewToReturn.delegate = self;
    if(contestant)
        textViewToReturn.text = contestant.name;
    else
        textViewToReturn.text = @"Tap to Enter Contestant Name";
    return textViewToReturn;
}

-(void)createContestantDividers
{
    CGRect screen = [[UIScreen mainScreen]applicationFrame];
    UIView *dividerOne = [[UIView alloc]initWithFrame:CGRectMake(screen.size.height/3, 0, 1, screen.size.width)];
    UIView *dividerTwo = [[UIView alloc]initWithFrame:CGRectMake((screen.size.height * 2)/3 + 1, 0, 1, screen.size.width)];
    dividerOne.backgroundColor = [UIColor whiteColor];
    dividerTwo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dividerOne];
    [self.view addSubview:dividerTwo];
}

@end
