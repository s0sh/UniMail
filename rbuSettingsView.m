//
//  rbuSettingsView.m
//  ErmineMail
//
//  Created by Roman Bigun on 08.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import "rbuSettingsView.h"
#import "constants.h"
@interface rbuSettingsView ()

@end



@implementation rbuSettingsView

@synthesize email,password,provider;


#define VIEW_PADDING 0
#define VIEW_DIMENSIONS 85
#define VIEWS_OFFSET 85
@synthesize emailField,passwordField;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    int offsetX=0;
    self.providers.delegate=self;
    
    passwordField.delegate = self;
    emailField.delegate = self;
    NSArray *agentsPicsArray = MAIL_AGENTS_PICS;
    
    for(int i=0;i<8;i++)
    {
    
        UIButton *btn=[[UIButton alloc] init];
        [btn setBackgroundImage:[UIImage imageNamed:[agentsPicsArray objectAtIndex:i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(offsetX, 0,85, 85);
        [self.providers addSubview:btn];
        offsetX+=90;
    }
    
    [self.providers setContentSize:CGSizeMake(offsetX,[self.providers bounds].size.height)];
    
    [self centerCurrentView];
    [super viewDidLoad];
}
- (void)centerCurrentView
{
    int xFinal = self.providers.contentOffset.x + (VIEWS_OFFSET / 2) + VIEW_PADDING;
    int viewIndex = xFinal / (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
    xFinal = viewIndex * (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
    [self.providers setContentOffset:CGPointMake(xFinal, 0) animated:YES];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self centerCurrentView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self centerCurrentView];
}

-(IBAction)choose:(UIButton*)sender
{
    NSArray *agentsPicsArray = MAIL_AGENTS_LIST;
    provider = [NSString stringWithFormat:@"%@",[agentsPicsArray objectAtIndex:sender.tag]];
    NSLog(@"%@",provider);
    
    
}
-(IBAction)save:(UIButton *)sender
{
    if(provider.length>0)
    {
    
             //Save users credentials for particular agent
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:provider];//result hotmail:YES
             NSLog(@"%hhd",[[NSUserDefaults standardUserDefaults] boolForKey:provider]);
        
             [[NSUserDefaults standardUserDefaults] setValue:password
                                                       forKey:[NSString stringWithFormat:@"%@Password",provider]];
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@Password",provider]]);
              //output - hotmailPassword:1q2w3e4r
             [[NSUserDefaults standardUserDefaults] setValue:email
                                                       forKey:[NSString stringWithFormat:@"%@Address",provider]];
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@Address",provider]]);
             //output - hotmailAddress:rbu@hotmail.com
        
           [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    } return YES;
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag==0)
    {
    
        email = [NSString stringWithFormat:@"%@",textField.text];
    
    }
    else
    {
       
       password = [NSString stringWithFormat:@"%@",textField.text];
    }
    
    [passwordField resignFirstResponder];
    return YES;
}
@end
