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
    if(self){
        self.question = finalJeopartyQuestion;
        self.isFinalJeoparty = YES;
    }
    
    return self;
}

-(void)loadView
{
    [super loadView];
    [self registerForKeyboardNotifications];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.height, self.view.frame.size.width-200);
    scrollView.backgroundColor = [UIColor blueColor];
    self.view = scrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.isFinalJeoparty){
        self.finalJeopardyCategoryTextField = [self textFieldSetupWithPlaceHolderString:@"Enter Final Jeoparty Category" andFrame:CGRectMake(261, 30, 502, 30)];
        self.finalJeopardyCategoryTextField.delegate = self;
        self.questionTextView = [self textViewToSetupWithFrame:CGRectMake(161, 90, 702, 460)];
        self.questionAnswerTextLabel = [self textFieldSetupWithPlaceHolderString:@"Enter Final Jeoparty Answer" andFrame:CGRectMake(261, 570, 502, 30)];
        NRFFinalJeopartyQuestion *castedFJQuestion = (NRFFinalJeopartyQuestion *)self.question;
        if(castedFJQuestion.category && ![castedFJQuestion.category isEqualToString:@""])
            self.finalJeopardyCategoryTextField.text = castedFJQuestion.category;
        [self.view addSubview:self.finalJeopardyCategoryTextField];
    } else {
        self.questionTextView = [self textViewToSetupWithFrame:CGRectMake(161, 30, 702, 460)];
        self.questionAnswerTextLabel = [self textFieldSetupWithPlaceHolderString:@"Enter Question's Answer" andFrame:CGRectMake(261, 520, 502, 30)];
        self.navigationItem.title = @"Enter Jeoparty Question Below";
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
        self.navigationItem.rightBarButtonItem = doneButton;
    }
    
    self.questionAnswerTextLabel.delegate = self;
    self.questionTextView.delegate = self;
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
    textFieldToReturn.returnKeyType = UIReturnKeyDefault;
    return textFieldToReturn;
}

-(UITextView *)textViewToSetupWithFrame:(CGRect)frame
{
    UITextView *textViewToReturn = [[UITextView alloc]initWithFrame:frame];
    textViewToReturn.backgroundColor = [UIColor blueColor];
    textViewToReturn.font = [UIFont fontWithName:@"Hoefler Text" size:70];
    textViewToReturn.textColor = [UIColor whiteColor];
    textViewToReturn.textAlignment = NSTextAlignmentCenter;
    textViewToReturn.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    return textViewToReturn;
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.question.question = textView.text;
    [(NRFTabBarViewController *)self.tabBarController checkForGameIsCompletelyEditedAndUpdateTabBarController];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.questionAnswerTextLabel)
        self.question.answer = textField.text;
    else{
        NRFFinalJeopartyQuestion *castedFJQ = (NRFFinalJeopartyQuestion *)self.question;
        castedFJQ.category = textField.text;
    }
    [(NRFTabBarViewController *)self.tabBarController checkForGameIsCompletelyEditedAndUpdateTabBarController];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIScrollView *scrollView = (UIScrollView *)self.view;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(64, 0.0, kbSize.width + 20, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(64,0,0,0);
    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

@end
