sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"galacticspacefarers/test/integration/pages/SpacefarersList",
	"galacticspacefarers/test/integration/pages/SpacefarersObjectPage"
], function (JourneyRunner, SpacefarersList, SpacefarersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('galacticspacefarers') + '/test/flpSandbox.html#galacticspacefarers-tile',
        pages: {
			onTheSpacefarersList: SpacefarersList,
			onTheSpacefarersObjectPage: SpacefarersObjectPage
        },
        async: true
    });

    return runner;
});

