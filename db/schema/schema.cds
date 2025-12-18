namespace Galactic;
/**
 * Schema for Galactic Spacefarer Adventure System
 */

entity Departments {
  key ID   : UUID;
      name : String;
}

entity Positions {
  key ID   : UUID;
      name : String;
}

entity Spacefarers {
  key ID                 : UUID;
      name               : String;
      originPlanet       : String;
      stardustCollection : Integer;
      wormholeSkill      : Integer;
      spacesuitColor     : String;

      department         : Association to Departments;

      position           : Association to Positions;
}

/**
 * ANNOTATIONS FOR FIORI GUI (can be set in Page Map)
 */

/**
 * Columns in Object List
 * (Label is the column title)
 */
annotate Galactic.Spacefarers with @UI.LineItem: [
  {
    Value: name,
    Label: 'Name of the Spacefarer'
  },
  {
    Value: stardustCollection,
    Label: 'Number of Stardusts'
  },
  {
    Value: spacesuitColor,
    Label: 'Suit color'
  }
];

/**
 * Object Page Header info
 */
annotate Galactic.Spacefarers with @UI.HeaderInfo: {
  TypeName      : 'Spacefarer',
  TypeNamePlural: 'Spacefarers',
  Title         : {Value: name},
};

/**
 *Field groups showing data ob the selected object
 */
annotate Galactic.Spacefarers with @UI.FieldGroup #Details: {Data: [
  {
    Value: name,
    Label: 'Name of the Spacefarer'
  },
  {
    Value: stardustCollection,
    Label: 'Stardusts Collected'
  },
  {
    Value: originPlanet,
    Label: 'Birth of Planet'
  },
  {
    Value: wormholeSkill,
    Label: 'Wormhole Skill Level'
  },
  {
    Value: spacesuitColor,
    Label: 'Spacesuit Color'
  },

/* {
 Value                  : department.name,
 Label                  : 'Department',
 ![@Common.FieldControl]: #ReadOnly,
},
{
 Value                  : position.name,
 Label                  : 'Position',
 ![@Common.FieldControl]: #ReadOnly,
} */

]};


/**
* describes the structure of the Object Page
*/
annotate Galactic.Spacefarers with @UI.Facets: [{
  $Type : 'UI.ReferenceFacet',
  Label : 'Details of the Spacefarer',
  Target: '@UI.FieldGroup#Details'
}];


/////////
annotate Positions with @UI.LineItem: [
  {Value: ID},
  {Value: name}
];

annotate Departments with @UI.LineItem: [
  {Value: ID},
  {Value: name}
];
