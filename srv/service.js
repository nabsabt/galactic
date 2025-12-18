//npm install nodemailer->
//const nodemailer = require("nodemailer");


module.exports = srv => {

  /**
   * CREATE NEW Spacefarer
   */
  srv.before('CREATE', 'Spacefarers', req => {
    console.log("Creating new: ", req.user, req.user.roles)
    console.log("new user: ", req.data);
    const data = req.data;

    if (data.stardustCollection == null || data.stardustCollection < 0) {
      data.stardustCollection = 0;
    }

    if (data.wormholeSkill == null || data.wormholeSkill < 1) {
      data.wormholeSkill = 1;
    }

    if (!data.spacesuitColor) {
      data.spacesuitColor = "white";
    }
  });

  // AFTER CREATE – cosmic email (mocked)
  srv.after('CREATE', 'Spacefarers', data => {
    console.log(
      `🚀 Cosmic email sent to ${data.name} from ${data.originPlanet}`
    );
  });

  srv.after('UPDATE', 'Spacefarers', data => {
    console.log(
     "UPDATE történt: ", data
    );
  });

  // Planet-based access restriction (Planet X vs Y)
  srv.before('READ', 'Spacefarers', req => {
    const userPlanet = req.user?.attr?.originPlanet;
    if (userPlanet) {
      req.query.where({ originPlanet: userPlanet });
    }
  });

};
