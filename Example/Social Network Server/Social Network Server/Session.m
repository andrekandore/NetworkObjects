//
//  Session.m
//  NetworkObjects
//
//  Created by Alsey Coleman Miller on 10/13/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "Session.h"
#import "Client.h"
#import "User.h"

#import "Session+NOSessionProtocol.h"

@implementation Session

@dynamic created;
@dynamic lastUse;
@dynamic resourceID;
@dynamic token;
@dynamic client;
@dynamic user;

-(void)awakeFromInsert
{
    [super awakeFromInsert];
    
    self.created = [NSDate date];
}

@end
