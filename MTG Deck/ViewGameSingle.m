//
//  ViewGameSingle.m
//  MTG Score
//
//  Created by Luca Bertani on 19/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import "ViewGameSingle.h"


@implementation ViewGameSingle

@synthesize dateFormat;

- (NSDateFormatter *)dateFormat
{
    if ( dateFormat == nil )
    {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy hh:mma"];
        [dateFormat setLocale:[NSLocale currentLocale]];
    }
    
    return dateFormat;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [dateFormat release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"Game", @"Title of ViewGameSingle");
    
    NSManagedObjectContext *context = [[CoreDataManager sharedCoreDataManager] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Card" inManagedObjectContext:context];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    request.predicate = nil; //[NSPredicate predicateWithFormat:@"whoHistory = %@", self.gameHistory];
    request.fetchBatchSize = 20;
    
    //[NSFetchedResultsController deleteCacheWithName:@"MyGameHistory"];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    [request release];
    
    self.fetchedResultsController = frc;
    [frc release];
    
    self.titleKey = @"timestamp";
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.dateFormat = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation != UIDeviceOrientationPortraitUpsideDown);
}

#pragma mark - Table View Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForManagedObject:(NSManagedObject *)managedObject
{
    static NSString *ReuseIdentifier = @"CoreDataTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (cell == nil) {
		UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
        cell = [[[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:ReuseIdentifier] autorelease];
    }
    
    Card *card = (Card *) managedObject;
    NSString *s = card.name;
    
    cell.textLabel.text = s;
    //cell.accessoryType = [self accessoryTypeForManagedObject:managedObject];
	
	/*if (self.titleKey) 
     {
     cell.textLabel.text = [[managedObject valueForKey:self.titleKey] description];
     }
     
     if (self.subtitleKey) cell.detailTextLabel.text = [managedObject valueForKey:self.subtitleKey];
     cell.accessoryType = [self accessoryTypeForManagedObject:managedObject];
     UIImage *thumbnail = [self thumbnailImageForManagedObject:managedObject];
     if (thumbnail) cell.imageView.image = thumbnail;*/
    
    //NSLog(@"%@", [managedObject description]);
	
	return cell;
}

/*- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
    ViewGameLineStatus *vgls = [[ViewGameLineStatus alloc] initWithStyle:UITableViewStyleGrouped];
    vgls.gameSingle = (GameSingle *)managedObject;
    vgls.gameHistory = gameHistory;
    [self.navigationController pushViewController:vgls animated:YES];
    [vgls release];
}*/


@end
