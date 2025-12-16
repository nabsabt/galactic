using {Galactic as db} from '../db/schema/schema';

service gsas {
    entity Spacefarers as projection on db.Spacefarers;

    @odata.draft.enabled
    entity Departments as projection on db.Departments;

    entity Positions   as projection on db.Positions;
}
