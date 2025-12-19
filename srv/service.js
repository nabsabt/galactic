//npm install nodemailer->
//const nodemailer = require("nodemailer");


module.exports = srv => {

  /**
   * BEFORE CREATE NEW Spacefarer
   */
  srv.before('CREATE', 'Spacefarers', req => {
    console.log("user role: ", req.user?.roles);
    console.log("new user: ", req.data);
    const data = req.data;
    if(!req.user?.roles.admin){
      alert("Only admin can create new spacefarers!");
      return;
    }
    

    if (data.stardustCollection == null || data.stardustCollection < 0 || isNaN(data.stardustCollection)) {
      data.stardustCollection = 0;
    }

    if (data.wormholeSkill == null || data.wormholeSkill < 1 || isNaN(data.wormholeSkill)) {
      data.wormholeSkill = 1;
    }

    if (!data.spacesuitColor) {
      data.spacesuitColor = "white";
    }
  });

  /**
   * AFTER CREATE Spacefarer
   */
  srv.after('CREATE', 'Spacefarers', data => {
    console.log(
      `🚀 Cosmic email sent to ${data.name} from ${data.originPlanet}`
    );
  });

  /**
   * UPDATE Spacefarer
   */
  srv.after('UPDATE', 'Spacefarers', data => {
    console.log(
     "UPDATE történt: ", data
    );
  });

  /**
   * READ Spacefarers - restrict to user's originPlanet
   * !IMPORTANT: admin must be excluded, other wise
   */
  srv.before('READ', 'Spacefarers', req => {
    if (req.user?.roles.admin) {
      console.log("Admin user, restrict felülírva")
      return;
    }   

    const userPlanet = req.user?.attr?.originPlanet;
    if (userPlanet) {
      req.query.where({ originPlanet: userPlanet });
    }
  });

};
