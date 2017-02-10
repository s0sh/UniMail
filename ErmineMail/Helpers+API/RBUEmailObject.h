//
//  RBUEmailObject.h
//  ErmineMail
//
//  Created by Roman Bigun on 09.09.14.
//  Copyright (c) 2014 Roman Bigun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBUEmailObject : NSObject

@property (nonatomic, retain) NSNumber* mailID;
@property (strong, nonatomic) NSString *mailAdress;
@property (strong, nonatomic) NSString *mailAdressBBC;
@property (strong, nonatomic) NSString *mailAdressCB;
@property (strong, nonatomic) NSString *mailSubject;
@property (strong, nonatomic) NSString *mailBody;
//--------------------------------------------------
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *idN;
@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *to;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *Bcc_Cc;
@end
