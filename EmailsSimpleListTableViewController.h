//
//  EmailsSimpleListTableViewController.h
//  ErmineMail
//
//  Created by Roman Bigun on 09.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErmineMail/mailcore2-master/src/MailCore.h"

@interface EmailsSimpleListTableViewController : UITableViewController

@property(nonatomic,retain)NSArray *messages;
@property(nonatomic,strong)IBOutlet UIImageView *agentPic;
@property(nonatomic,strong)IBOutlet UILabel *curFolder;
@end
