//
//  EmailMenuController.m
//  ErmineMail
//
//  Created by Roman Bigun on 11.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import "EmailMenuController.h"
#import "constants.h"
#import "RBUEmailHelper.h"
@interface EmailMenuController ()

@end

@implementation EmailMenuController


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
    [super viewDidLoad];
    [self.agentPic setImage:nil];
    NSLog(@"%@",[app currentAgent]);
    [self.agentPic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[app currentAgent]]]];
    
    [app setCurFolder:@"INBOX"];//Для того что-бы выкусить/показать количество не прочитаной почты
    [[RBUEmailHelper sharedInstance] loginToHostAndFetchEmails];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:YES];
    
    [self.agentPic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[app currentAgent]]]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)saveCurrentFolder:(UIButton*)sender;
{

    if(sender.tag==101)
    {
        
        [app setCurFolder:@"INBOX"];
        
    }
    else if(sender.tag==102)
    {
        
        [app setCurFolder:@"Sent"];
        
    }
    else if(sender.tag==103)
    {
        
        [app setCurFolder:@"Drafts"];
        
    }
    else if(sender.tag==104)
    {
        
        [app setCurFolder:@"Spam"];
        
    }
    else if(sender.tag==105)
    {
        
        [app setCurFolder:@"Deleted"];
        
    }
    /* Получаем письма из выбраного ящика.
     TODO: адаптировать ко всем провайдерам так как название ящиков отличаются*/
    
     [[RBUEmailHelper sharedInstance] loginToHostAndFetchEmails];
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
