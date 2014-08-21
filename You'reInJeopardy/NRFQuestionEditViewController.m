//
//  NRFQuestionEditViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/11/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestionEditViewController.h"

@interface NRFQuestionEditViewController ()

@property (strong, nonatomic) NRFQuestion *question;
@property (strong, nonatomic) UITextView *questionTextView;
@property (strong, nonatomic) UITextField *questionAnswerTextLabel;
@property (strong, nonatomic) UITextField *finalJeopardyCategoryTextField;
@property BOOL mightNeedIncrement;
@property BOOL isFinalJeoparty;

@end

@implementation NRFQuestionEditViewController

- (id)initWithQuestion:(NRFQuestion *)question
{
    self = [super init];
    if (self) {
        self.question = question;
        if([self.question isFinished])
            self.mightNeedIncrement = NO;
        else
            self.mightNeedIncrement = YES;
        self.isFinalJeoparty = NO;
    }
    return self;
}

-(id)initWithFinalJeopartyQuestion:(NRFFinalJeopartyQuestion *)finalJeopartyQuestion;
{
    self = [super init];
    if(self) {
        self.question = finalJeopartyQuestion;
        self.isFinalJeoparty = YES;
    }
    
    return self;
}

-(void)loadView
{
    [super loadView];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.height, 600);
    scrollView.backgroundColor = [UIColor blueColor];
    self.view = scrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.isFinalJeoparty){
        self.finalJeopardyCategoryTextField = [self textFieldSetupWithPlaceHolderString:@"Enter Final Jeoparty Category" andFrame:CGRectMake(261, 30, 502, 30)];
        self.questionTextView = [self textViewToSetupWithFrame:CGRectMake(161, 90, 702, 460)];
        self.questionAnswerTextLabel = [self textFieldSetupWithPlaceHolderString:@"Enter Final Jeoparty Answer" andFrame:CGRectMake(261, 570, 502, 30)];
        [self.view addSubview:self.finalJeopardyCategoryTextField];
        NRFFinalJeopartyQuestion *castedFJQuestion = (NRFFinalJeopartyQuestion *)self.question;
        if(castedFJQuestion.category && ![castedFJQuestion.category isEqualToString:@""])
            self.finalJeopardyCategoryTextField.text = castedFJQuestion.category;
    } else {
        self.questionTextView = [self textViewToSetupWithFrame:CGRectMake(161, 30, 702, 460)];
        self.questionAnswerTextLabel = [self textFieldSetupWithPlaceHolderString:@"Enter Question's Answer" andFrame:CGRectMake(261, 520, 502, 30)];
        self.navigationController.title = @"Enter Jeoparty Question Below";
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
        self.navigationItem.rightBarButtonItem = doneButton;
    }
    
    [self.view addSubview:self.questionTextView];
    [self.view addSubview:self.questionAnswerTextLabel];
    
    if(self.question.question){
        self.questionTextView.text = self.question.question;
    }
    
    if(self.question.answer){
        self.questionAnswerTextLabel.text = self.question.answer;
    }
    
}

- (IBAction)doneButtonPressed:(id)sender {
    
    self.question.question = self.questionTextView.text;
    self.question.answer = self.questionAnswerTextLabel.text;
    if(self.isFinalJeoparty){
        NRFFinalJeopartyQuestion *castedFJQuestion = (NRFFinalJeopartyQuestion *)self.question;
        castedFJQuestion.category = self.finalJeopardyCategoryTextField.text;
    }
    [self.delegate questionEditViewControllerDidFinishWithQuestion:self.question mightNeedIncrement:self.mightNeedIncrement];
    
}

-(UITextField *)textFieldSetupWithPlaceHolderString:(NSString *)placeHolderString andFrame:(CGRect)frame
{
    UITextField *textFieldToReturn = [[UITextField alloc] initWithFrame:frame];
    textFieldToReturn.borderStyle = UITextBorderStyleRoundedRect;
    textFieldToReturn.font = [UIFont systemFontOfSize:17];
    textFieldToReturn.placeholder = placeHolderString;
    textFieldToReturn.autocorrectionType = UITextAutocorrectionTypeYes;
    textFieldToReturn.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textFieldToReturn.keyboardType = UIKeyboardTypeDefault;
    textFieldToReturn.returnKeyType = UIReturnKeyDone;
    return textFieldToReturn;
}

-(UITextView *)textViewToSetupWithFrame:(CGRect)frame
{
    UITextView *textViewToReturn = [[UITextView alloc]initWithFrame:frame];
    textViewToReturn.backgroundColor = [UIColor blueColor];
    textViewToReturn.font = [UIFont fontWithName:@"Hoefler Text" size:70];
    textViewToReturn.textAlignment = NSTextAlignmentCenter;
    textViewToReturn.autocapitalizationType = UITextAutocorrectionTypeDefault;
    return textViewToReturn;
}


@end
