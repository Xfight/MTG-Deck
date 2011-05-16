//
//  Expansion.m
//  MTG Deck
//
//  Created by Luca Bertani on 16/05/11.
//  Copyright (c) 2011 home. All rights reserved.
//

#import "Expansion.h"
#import "CardExpansion.h"


@implementation Expansion
@dynamic expid;
@dynamic cards;

- (void)addCardsObject:(CardExpansion *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"cards" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"cards"] addObject:value];
    [self didChangeValueForKey:@"cards" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeCardsObject:(CardExpansion *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"cards" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"cards"] removeObject:value];
    [self didChangeValueForKey:@"cards" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addCards:(NSSet *)value {    
    [self willChangeValueForKey:@"cards" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"cards"] unionSet:value];
    [self didChangeValueForKey:@"cards" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeCards:(NSSet *)value {
    [self willChangeValueForKey:@"cards" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"cards"] minusSet:value];
    [self didChangeValueForKey:@"cards" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
