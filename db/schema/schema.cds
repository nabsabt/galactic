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

entity Planets {
  key ID   : UUID;
      name : String;
}

entity Spacefarers {
  key ID                 : UUID;
      name               : String;
      //originPlanet       : String;
      stardustCollection : Integer;
      wormholeSkill      : Integer;
      spacesuitColor     : String;
      email              : String;

      department         : Association to Departments;

      position           : Association to Positions;

      planet             : Association to Planets;
}

/**
 * ANNOTATIONS FOR FIORI GUI (can be set in Page Map)
 */

/**
 * Columns in Object List
 * (Label is the column title)
 */
/* annotate Galactic.Spacefarers with @UI.LineItem: [
  {
    Value               : name,
    Label               : 'Name of the Spacefarer',
    ![HTML5.CssDefaults]: {backgroundColor: 'red'}
  },
  {
    Value               : stardustCollection,
    Label               : 'Number of Stardusts',
    ![HTML5.CssDefaults]: {width: '20px'}
  },
  {
    Value               : spacesuitColor,
    Label               : 'Suit color',
    ![HTML5.CssDefaults]: {width: '20px'}
  }
]; */


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
  /*  {
     Value: originPlanet,
     Label: 'Birth of Planet'
   }, */
  {
    Value: wormholeSkill,
    Label: 'Wormhole Skill Level'
  },
  {
    Value: spacesuitColor,
    Label: 'Spacesuit Color'
  },
  {
    Value: email,
    Label: 'Email Address'
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

annotate Planets with @UI.LineItem: [
  {Value: ID},
  {Value: name}
];
