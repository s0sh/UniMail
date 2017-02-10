//
//  MailView.h
//  ErmineMail
//
//  Created by Roman Bigun on 10.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailView : UIView


@property(nonatomic,retain)UILabel *from;
@property(nonatomic,retain)UILabel *subj;
@property(nonatomic,retain)UILabel *time;
@property(nonatomic,retain)NSString *ProviderStr;
@property(nonatomic,retain)UIImageView *providerIcon;
@property(nonatomic,retain)UITextView *messageBody;
@end
