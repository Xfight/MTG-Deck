//
//  Expansion.h
//  MTG Deck
//
//  Created by Luca Bertani on 16/05/11.
//  Copyright (c) 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface Expansion : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * expid;
@property (nonatomic, retain) NSSet* cards;

@end
