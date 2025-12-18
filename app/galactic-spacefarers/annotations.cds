using gsas as service from '../../srv/service';

annotate service.Spacefarers with {
    department @(
        Common.ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Departments',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: department_ID,
                    ValueListProperty: 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.ExternalID : department.name,
        )
};

annotate service.Spacefarers with {
    position @(
        Common.ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Positions',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: position_ID,
                    ValueListProperty: 'ID',
                },
            ],
            Label : 'Set position',
        },
        Common.ValueListWithFixedValues : true,
        Common.ExternalID : position.name,
        )
};
annotate service.Spacefarers with @(
    UI.FieldGroup #Details : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : stardustCollection,
                Label : 'Stardusts Collected',
            },
            {
                $Type : 'UI.DataField',
                Value : originPlanet,
                Label : 'Birth of Planet',
            },
            {
                $Type : 'UI.DataField',
                Value : wormholeSkill,
                Label : 'Wormhole Skill Level',
            },
            {
                $Type : 'UI.DataField',
                Value : spacesuitColor,
                Label : 'Spacesuit Color',
            },
            {
                $Type : 'UI.DataField',
                Value : department_ID,
                Label : '{i18n>Department}',
            },
            {
                $Type : 'UI.DataField',
                Value : position_ID,
                Label : '{i18n>Position}',
            },
            {
                $Type : 'UI.DataField',
                Value : name,
                Label : '{i18n>NameOfTheSpacefarer}',
            },
        ],
    }
);

annotate service.Departments with {
    ID @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

annotate service.Positions with {
    ID @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

