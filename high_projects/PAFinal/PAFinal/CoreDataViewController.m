//
//  CoreDataViewController.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 5/26/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "CoreDataViewController.h"

@interface CoreDataViewController ()

@end

@implementation CoreDataViewController

- (void) displayAlert:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!!!" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)insertDocumentToCoreData
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *manage = app.managedObjectContext;
    
    Documents *document = [NSEntityDescription insertNewObjectForEntityForName:@"Documents" inManagedObjectContext:manage];
    
    document.contents = self.textContent.text;
    document.timeStamp = [NSDate date];
    
    [app saveContext];
}

- (void)retrieveDocumentFromCoreData
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *manage = app.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Documents"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:NO];
    
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSFetchedResultsController *request_controller  = [[ NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:manage sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error = nil;
    [request_controller performFetch:&error];
    
    if (error){
        [self displayAlert:[error localizedDescription]];
        return;
    }
    if ([request_controller.fetchedObjects count])
    {
        Documents *last = [request_controller.fetchedObjects objectAtIndex:0];
    
        NSMutableString *ms = [[NSMutableString alloc]init];
        [ms appendFormat:@"%@", last.contents];
    
        self.textContent.text = ms;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self retrieveDocumentFromCoreData];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self insertDocumentToCoreData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Core Data";
    [self.textContent becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
