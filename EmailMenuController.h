//
//  EmailMenuController.h
//  ErmineMail
//
//  Created by Roman Bigun on 11.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailMenuController : UIViewController

@property(nonatomic,strong)IBOutlet UIImageView *agentPic;
@property(nonatomic,retain)IBOutlet UILabel *emailsCountLabel;
@property(nonatomic,retain)IBOutlet UIImageView *mailRoundBg;

-(IBAction)saveCurrentFolder:(UIButton*)sender;

@end
