//
//  EmailsSimpleListTableViewController.m
//  ErmineMail
//
//  Created by Roman Bigun on 09.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import "EmailsSimpleListTableViewController.h"
#import "MailsVCCell.h"
#import "RBUEmailHelper.h"
#import "DisplayEmail.h"
#import "constants.h"
@interface EmailsSimpleListTableViewController ()

@end

@implementation EmailsSimpleListTableViewController

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotData) name:@"messagesLoaded" object:nil];
    [super viewDidLoad];
    
}
-(void)gotData
{

    self.messages = [[NSArray alloc] initWithArray:[[RBUEmailHelper sharedInstance] messagesObjects]];
    [self.tableView reloadData];

}
-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:YES];
    self.curFolder.text = [app curFolder];
    [self.agentPic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[app currentAgent]]]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MailsVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MailsVCCell"];
    
    if (!cell) {
        NSArray* xibCell = [[NSBundle mainBundle] loadNibNamed:@"MailsVCCell" owner:self options:nil];
        
        cell = [xibCell objectAtIndex:0];
        [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    MCOIMAPMessage *message = self.messages[indexPath.row];
    
    /*
    if ([[mc getDataFromArchive:@"tipeENG"] isEqualToString:@"Sent Mail"]) {
        cell.toLBL.text = @"   To:";
        
        NSString *str = [NSString stringWithFormat:@"%@",message.header.to];
        NSString *search = @"  ";
        NSString *sub = [str substringFromIndex:NSMaxRange([str rangeOfString:search])];
        
        NSString *sub1 = [sub substringFromIndex:NSMaxRange([sub rangeOfString:search])];
        
        NSString *search1 = @" ";
        NSString *sub2 = [sub1 substringFromIndex:NSMaxRange([sub1 rangeOfString:search1])];
        
        cell.adressLable.text =[NSString stringWithFormat:@"%@", sub2];
        
        
        
    }else{
      */
        NSString *str = [NSString stringWithFormat:@"%@",message.header.from];
        NSString *search = @" ";
        NSString *sub = [str substringFromIndex:NSMaxRange([str rangeOfString:search])];
        cell.adressLable.text =[NSString stringWithFormat:@"%@", sub];
        
    //}
    
    
    
    
    
    if (message.header.subject!=nil) {
        cell.subjectLable.text = [NSString stringWithFormat:@"%@", message.header.subject];
    }
    
    
    
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    df.dateStyle = NSDateFormatterShortStyle;
    
    df.doesRelativeDateFormatting = YES;
    
    NSString *text = [df stringFromDate:message.header.date];
    
    NSLog(@"%@",text);
    
    if ([text isEqualToString:@"Today"]) {
        
        
        [df setDateFormat:@"HH:mm"];
        
        
        text = [df stringFromDate:message.header.date];
        
        
        cell.sendTimeLable.text = [NSString stringWithFormat:@"%@",(text.length > 0 ? text : @"")];
        
    }else{
        
        [df setDateFormat:@"MMM dd"];
        
        text = [df stringFromDate:message.header.date];
        
        cell.sendTimeLable.text = [NSString stringWithFormat:@"%@",(text.length > 0 ? text : @"")];
    }
    
    
    
    
    
    cell.sendTimeLable.text = [self sentTime:message.header.date];
    //			NSString *uidKey = [NSString stringWithFormat:@"%d", message.uid];
    //			NSString *cachedPreview = self.messagePreviews[uidKey];
    
    
    return cell;
}
-(NSString *)sentTime:(id)timeObj
{

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    df.dateStyle = NSDateFormatterShortStyle;
    
    df.doesRelativeDateFormatting = YES;
    
    NSString *text = [df stringFromDate:timeObj];
    
    
    if ([text isEqualToString:@"Today"]) {
        
        
        [df setDateFormat:@"HH:mm"];
        
        
        text = [df stringFromDate:timeObj];
        
        
         return [NSString stringWithFormat:@"%@",(text.length > 0 ? text : @"")];
        
    }else{
        
        [df setDateFormat:@"MMM dd"];
        
        text = [df stringFromDate:timeObj];
        
        return [NSString stringWithFormat:@"%@",(text.length > 0 ? text : @"")];
    }


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MCOIMAPMessage *msg = self.messages[indexPath.row];
    
    DisplayEmail *ctr = [self.storyboard instantiateViewControllerWithIdentifier:@"DisplayMail"];
    
    ctr.ProviderStr = @"gmail";
    ctr.message = msg;
    ctr.session = [app getSession];
    ctr.subjStr = msg.header.subject;
    ctr.timeStr = [self sentTime:msg.header.date];
 
    
    [self presentViewController:ctr animated:YES completion:nil];
   
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:

*/

@end
