//
//  MasterViewController.h
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/25/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

#import <CoreData/CoreData.h>

#import "AboutViewController.h"
#import "ConcurrencyViewController.h"
#import "FilesViewController.h"
#import "LocalNotificationViewController.h"
#import "EmailViewController.h"

#import "MapKitViewController.h"
#import "ViewAnimationViewController.h"
#import "ContactsViewController.h"
#import "SQLiteViewController.h"
#import "CoreDataViewController.h"

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>


@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
