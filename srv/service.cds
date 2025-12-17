using {Galactic as db} from '../db/schema/schema';

/**
 *@odata.draft.enabled to add Create/Delete button.
 *If an Entity is draft-enabled, every relational entity must also be draft-enabled!!!
 *When draft.enabled, CAP generates a xy_draft psuedo-table with relations.
 */

service gsas @(requires: 'user') {
    //@odata.draft.enabled
    entity Spacefarers @(restrict: [
        {
            grant: ['READ'],
            to   : [
                'admin',
                'user'
            ]
        },
        {
            grant: [
                'WRITE',
                'CREATE',
                'DELETE'
            ],
            to   : 'admin'
        }
    ])                 as projection on db.Spacefarers;

    //@odata.draft.enabled
    entity Departments as projection on db.Departments;

    //@odata.draft.enabled
    entity Positions   as projection on db.Positions;
}
