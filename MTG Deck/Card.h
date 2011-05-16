//
//  Card.h
//  MTG Deck
//
//  Created by Luca on 16/05/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Card : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * colour;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * cost;
@property (nonatomic, retain) NSManagedObject * expansions;

@end
