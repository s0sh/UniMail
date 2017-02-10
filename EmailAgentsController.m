//
//  EmailAgentsController.m
//  ErmineMail
//
//  Created by Roman Bigun on 11.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import "EmailAgentsController.h"
#import "constants.h"

@interface EmailAgentsController ()
{

    NSArray *agentsArray;

}
@end

@implementation EmailAgentsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    
    NSLog(@"%hhd",[[NSUserDefaults standardUserDefaults] boolForKey:@"ukrnet"]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@Password",@"ukrnet"]]);
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"%@Address",@"ukrnet"]]);
    
    
    
    agentsArray = [[NSArray alloc] initWithArray:MAIL_AGENTS_LIST];
    [super viewDidLoad];
   
    
    for(int i=0;i<agentsArray.count;i++)
    {
        NSLog(@"%hhd",[[NSUserDefaults standardUserDefaults] boolForKey:[agentsArray objectAtIndex:i]]);
        
        if([[NSUserDefaults standardUserDefaults] boolForKey:[agentsArray objectAtIndex:i]]==NO)
        {
        
            for (UIView *v in self.view.subviews)
            {
                if ([v isKindOfClass:[UIButton class]] && (v.tag==i))
                {
                    //ROMA
                    [(UIButton*)v setEnabled:NO];//Enable/Disable installed providers.
                    
                }
            }
        
        }
        
    
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)saveCurrentAgent:(UIButton*)sender
{

    [app setCurrentAgent:[agentsArray objectAtIndex:sender.tag]];
    

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
