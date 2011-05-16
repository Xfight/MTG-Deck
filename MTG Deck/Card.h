//
//  Card.h
//  MTG Deck
//
//  Created by Luca Bertani on 16/05/11.
//  Copyright (c) 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Expansion;

@interface Card : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * colour;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * cost;
@property (nonatomic, retain) NSSet* expansions;

- (void)addExpansionsObject:(Expansion *)value;

@end
