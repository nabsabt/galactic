using gsas as service from '../../srv/service';

annotate service.Spacefarers with {
    department @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Departments',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: department_ID,
                ValueListProperty: 'ID',
            }, ],
        },
        Common.ValueListWithFixedValues: true,
        Common.ExternalID              : department.name,
    )
};

annotate service.Spacefarers with {
    position @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Positions',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: position_ID,
                ValueListProperty: 'ID',
            }, ],
            Label         : 'Set position',
        },
        Common.ValueListWithFixedValues: true,
        Common.ExternalID              : position.name,
    )
};

annotate service.Spacefarers with @(UI.LineItem: [
    {
        Value: name,
        Label: 'Name of the Spacefarer',
    },
    {
        Value: stardustCollection,
        Label: 'Stardust',
    },
    {
        Value: spacesuitColor,
        Label: 'Spacesuit Color',
    }
]);

annotate service.Spacefarers with @(UI.HeaderInfo: {
    TypeName      : 'Spacefarer',
    TypeNamePlural: 'Spacefarers',
    Title         : {Value: name},
});

annotate service.Spacefarers with @(UI.SelectionFields: [
    name,
    stardustCollection,
    spacesuitColor,
]);

annotate service.Spacefarers with @(UI.FieldGroup #Details: {Data: [
    {
        $Type: 'UI.DataField',
        Value: stardustCollection,
        Label: 'Stardusts Collected',
    },
    {
        $Type: 'UI.DataField',
        Value: wormholeSkill,
        Label: 'Wormhole Skill Level',
    },
    {
        $Type   : 'UI.DataField',
        Value   : spacesuitColor,
        Label   : 'Spacesuit Color',
        required: false,
    },
    {
        $Type: 'UI.DataField',
        Value: email,
        Label: 'Email Address',
    },
    {
        $Type: 'UI.DataField',
        Value: department_ID,
        Label: '{i18n>Department}',
    },
    {
        $Type: 'UI.DataField',
        Value: position_ID,
        Label: '{i18n>Position}',
    },
    {
        $Type   : 'UI.DataField',
        Value   : name,
        Label   : '{i18n>NameOfTheSpacefarer}',
        required: true,
    },
    {
        $Type: 'UI.DataField',
        Value: planet_ID,
        Label: 'Planet',
    },
], });

annotate service.Spacefarers with @(UI.Facets: [{
    $Type : 'UI.ReferenceFacet',
    Label : 'Details of the Spacefarer',
    Target: '@UI.FieldGroup#Details'
}]);

annotate service.Spacefarers with {
    email @Common.FieldControl: #Mandatory;
    name  @Common.FieldControl: #Mandatory;
};

annotate service.Departments with {
    ID @(
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.Positions with {
    ID @(
        Common.Text                    : name,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};

annotate service.Spacefarers with {
    originPlanet @Common.ExternalID: planet.name
};

annotate service.Spacefarers with {
    planet @(
        Common.ExternalID              : planet.name,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Planets',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: planet_ID,
                ValueListProperty: 'ID',
            }, ],
        },
        Common.ValueListWithFixedValues: true,
    )
};
