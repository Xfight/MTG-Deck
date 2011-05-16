//
//  Card.m
//  MTG Deck
//
//  Created by Luca Bertani on 16/05/11.
//  Copyright (c) 2011 home. All rights reserved.
//

#import "Card.h"
#import "CardExpansion.h"


@implementation Card
@dynamic colour;
@dynamic name;
@dynamic type;
@dynamic cost;
@dynamic expansions;

- (void)addExpansionsObject:(CardExpansion *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"expansions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"expansions"] addObject:value];
    [self didChangeValueForKey:@"expansions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeExpansionsObject:(CardExpansion *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"expansions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"expansions"] removeObject:value];
    [self didChangeValueForKey:@"expansions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addExpansions:(NSSet *)value {    
    [self willChangeValueForKey:@"expansions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"expansions"] unionSet:value];
    [self didChangeValueForKey:@"expansions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeExpansions:(NSSet *)value {
    [self willChangeValueForKey:@"expansions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"expansions"] minusSet:value];
    [self didChangeValueForKey:@"expansions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
