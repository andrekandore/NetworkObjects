//
//  PostsViewController.h
//  NetworkObjectsClient
//
//  Created by Alsey Coleman Miller on 11/11/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface PostsViewController : UITableViewController
{
    NSMutableArray *_posts;
}

-(IBAction)unwindToPostsVC:(UIStoryboardSegue *)segue;

-(void)downloadData;

-(void)refreshFromCache;

@end
