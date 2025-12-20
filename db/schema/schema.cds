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
      name               : String @mandatory;
      stardustCollection : Integer;
      wormholeSkill      : Integer;
      spacesuitColor     : String;
      email              : String @mandatory;

      department         : Association to Departments;

      position           : Association to Positions;

      planet             : Association to Planets;
}


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
