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

      department         : Association to Departments
                             on department.ID = department_ID;
      department_ID      : UUID;

      position           : Association to Positions
                             on position.ID = position_ID;
      position_ID        : UUID;
}

/* annotate Spacefarers with @UI.LineItem: [
  {Value: ID},
  {Value: name},
  {Value: originPlanet},
  {Value: stardustCollection},
  {Value: wormholeSkill},
  {Value: spacesuitColor},
  {Value: department_ID},
  {Value: position_ID}
];
 */
annotate Galactic.Spacefarers with @odata.draft.enabled;
annotate Galactic.Spacefarers with @fiori.draft.enabled;


annotate Galactic.Spacefarers with @UI: {
  LineItem       : [
    {
      Value: name,
      Label: 'Name'
    },
    {
      Value: originPlanet,
      Label: 'Origin Planet'
    },
    {Value: stardustCollection},
    {Value: wormholeSkill},
    {Value: spacesuitColor},
    {Value: department.name},
    {Value: position.title}
  ],
  SelectionFields: [
    originPlanet,
    spacesuitColor,
    department_ID,
    position_ID
  ],
  Identification : [
    {Value: name},
    {Value: originPlanet},
    {Value: department.name},
    {Value: position.title},
    {Value: stardustCollection},
    {Value: wormholeSkill},
    {Value: spacesuitColor}
  ],
  Facets         : [{
    $Type : 'UI.ReferenceFacet',
    Label : 'Details',
    Target: '@UI.Identification'
  }]
};

annotate Positions with @UI.LineItem: [
  {Value: position_ID},
  {Value: title}
];

annotate Departments with @UI.LineItem: [
  {Value: department_ID},
  {Value: name}
];
