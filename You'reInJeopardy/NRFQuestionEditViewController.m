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
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UITextField *questionAnswerTextLabel;

@end

@implementation NRFQuestionEditViewController

- (id)initWithQuestion:(NRFQuestion *)question
{
    self = [super initWithNibName:@"NRFQuestionEditViewController" bundle:nil];
    if (self) {
        self.question = question;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.question.question != nil){
        self.questionTextView.text = self.question.question;
    }
    
    if(self.question.answer != nil){
        self.questionAnswerTextLabel.text = self.question.answer;
    }
    
    self.navigationItem.title = @"Enter Question";
    
}

- (IBAction)doneButtonPressed:(id)sender {
    
    self.question.question = self.questionTextView.text;
    self.question.answer = self.questionAnswerTextLabel.text;
    
    [self.delegate questionEditViewController:self didFinishWithQuestion:self.question];
    
}


@end
