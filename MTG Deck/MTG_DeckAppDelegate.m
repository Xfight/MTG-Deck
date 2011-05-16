//
//  MTG_DeckAppDelegate.m
//  MTG Deck
//
//  Created by Luca on 16/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MTG_DeckAppDelegate.h"

@implementation MTG_DeckAppDelegate


@synthesize window=_window;

@synthesize managedObjectContext=__managedObjectContext;

@synthesize managedObjectModel=__managedObjectModel;

@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;

- (NSString *)findInString:(NSString *)content withStart:(NSString *)start andEnd:(NSString *)end startFrom:(NSUInteger *) pos
{
    NSUInteger length = [content length];
    NSString *s = nil;
    NSRange r, r1;
    r.location = *pos;
    r.length = length - *pos;
    r = [content rangeOfString:start options:0 range:r];
    if ( r.location == NSNotFound )
        return s;
    
    r1.location = r.location + r.length;
    r1.length = length - r1.location;
    r1 = [content rangeOfString:end options:0 range:r1];
    if ( r1.location == NSNotFound )
        return s;
    
    r.location = r.location + r.length;
    r.length = r1.location - r.location;
    
    *pos = r.location + r.length;
    
    s = [content substringWithRange:r];
    return s;
}

- (void)loadDatabase
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"html"];
    if (filePath) {
        //NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSISOLatin1StringEncoding error:NULL];
        NSString *myText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
        if (myText) {
            //textView.text= myText;
            //NSLog(@"%@", myText);
            
            /*
            <B><A NAME="6E055">Abduction</A></B> <I>(Rapimento)</I><UL> 
            <TABLE BORDER="1" cellpadding="4"><TR><TD> Colore= Blu </TD><TD>Tipo= Incantesimo - Aura </TD><TD>Costo= 2LL</TD> <TD ALIGN=RIGHT>CA(NC)/6E(NC)</TD></TR> 
            <TR><TD COLSPAN="4">Testo (6E): Incanta creatura  ; Quando il Rapimento entra nel campo di battaglia, STAPpa la creatura incantata.  ; Prendi il controllo della creatura incantata.  ; Quando la creatura incantata viene messa in un cimitero, rimetti quella carta sul campo di battaglia sotto il controllo del suo proprietario.</TR></TD></TABLE> 
            <li type=disc>Può essere lanciata bersagliando una creatura già STAPpata. <EM>[D'Angelo 1997/12/29]</EM> </ul><p>
            */
            
            NSUInteger totalSize = [myText length];
            NSUInteger cur = 0;
            
            NSRange r, r2;
            r = [myText rangeOfString:@"<B><A NAME=\""];
            cur = r.location + r.length;
            
            NSManagedObjectContext *context = [self managedObjectContext];
            Card *card;// = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
            Expansion *expansion;
            
            while ( cur < totalSize )
            {
                //NSString *name, *colour, *type, *cost, *exp;
                NSString *exp;
                card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
                
                card.name = [self findInString:myText withStart:@"\">" andEnd:@"</A>" startFrom:&cur];
                //NSLog(@"name : %@", name);
                
                card.colour = [self findInString:myText withStart:@"<TR><TD> Colore= " andEnd:@" </TD>" startFrom:&cur];
                //NSLog(@"colour : %@", colour);
                
                card.type = [self findInString:myText withStart:@"<TD>Tipo= " andEnd:@" </TD>" startFrom:&cur];
                //NSLog(@"type : %@", type);
                
                card.cost = [self findInString:myText withStart:@"<TD>Costo= " andEnd:@"</TD>" startFrom:&cur];
                //NSLog(@"cost : %@", cost);
                
                // <TD ALIGN=RIGHT>OR(NC)/5E(NC)</TD></TR>
                exp = [self findInString:myText withStart:@"<TD ALIGN=RIGHT>" andEnd:@"</TD></TR>" startFrom:&cur];
                //NSLog(@"exp : %@", exp);
                
                NSArray *arr = [exp componentsSeparatedByString:@"/"];
                NSMutableArray *arrSplit = [NSMutableArray array];
                
                for (NSString *s in arr) {
                    r2 = [s rangeOfString:@"("];
                    s = [s substringToIndex:r2.location];
                    [arrSplit addObject:s];
                }
                
                NSMutableSet* existingNames = [NSMutableSet set];
                NSMutableArray* filteredArray = [NSMutableArray array];
                for (NSString *object in arrSplit) {
                    if (![existingNames containsObject:object]) {
                        [existingNames addObject:object];
                        [filteredArray addObject:object];
                    }
                }
                
                
                
                //NSLog(@"Filtered array : %@", filteredArray);
                //cur = totalSize;
                
                r.location = cur;
                r.length = totalSize - cur;
                
                r = [myText rangeOfString:@"<B><A NAME=\"" options:0 range:r];
                cur = r.location + r.length;
                //NSLog(@"\n");
            }
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    [self loadDatabase];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}

- (void)awakeFromNib
{
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.<#View controller#>.managedObjectContext = self.managedObjectContext;
    */
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MTG_Deck" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MTG_Deck.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
