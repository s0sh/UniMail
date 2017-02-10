//
//  DisplayEmail.h
//  ErmineMail
//
//  Created by Roman Bigun on 10.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCOMessageView.h"
#import "RBUEmailObject.h"
@interface DisplayEmail : UIViewController<UITextFieldDelegate,UITextViewDelegate ,MCOMessageViewDelegate>
{

    UIWebView *webView;
	bool requestedBodystructure;
	bool requestedContentPart;
    IBOutlet MCOMessageView * _messageView;
    NSMutableDictionary * _storage;
    NSMutableSet * _pending;
    NSMutableArray * _ops;
    MCOIMAPSession * _session;
    MCOIMAPMessage * _message;
    NSMutableDictionary * _callbacks;
    NSString * _folder;

}
@property (nonatomic, strong) MCOIMAPSession * session;
@property (nonatomic, strong) MCOIMAPMessage * message;
@property(nonatomic,retain)IBOutlet UILabel *from;
@property(nonatomic,retain)IBOutlet UILabel *subj;
@property(nonatomic,retain)IBOutlet UILabel *time;
@property(nonatomic,retain)IBOutlet NSString *ProviderStr;
@property(nonatomic,retain)IBOutlet UIImageView *providerIcon;
@property(nonatomic,retain)IBOutlet UITextView *messageBody;
@property (nonatomic, retain) IBOutlet UIView *viewForWeb;
@property (nonatomic, retain) NSString * fromStr;
@property (nonatomic, retain) NSString * subjStr;
@property (nonatomic, retain) NSString * timeStr;
@property (nonatomic, retain)RBUEmailObject *incomingMail;

@end
