const mailBodyServer = require("../mail/mailService").mailBodyServer;
const nodemailer = require("nodemailer");

let transportPromise;

/**
 * Creates a nodemailer account (if not yet created).
 * NEVER use testAccount in production!!!
 * @returns created nodemailer transport
 */
async function getTransport() {
  if (!transportPromise) {
    transportPromise = nodemailer.createTestAccount().then((acc) =>
      nodemailer.createTransport({
        host: "smtp.ethereal.email",
        port: 587,
        secure: false,
        auth: {
          user: acc.user,
          pass: acc.pass,
        },
      })
    );
  }
  return transportPromise;
}

module.exports = (srv) => {
  /**
   * BEFORE CREATE NEW Spacefarer
   */
  srv.before("CREATE", "Spacefarers", (req) => {
    const data = req.data;
    isAdmin(req);

    if (
      data.stardustCollection == null ||
      data.stardustCollection < 0 ||
      isNaN(data.stardustCollection)
    ) {
      data.stardustCollection = 0;
    }

    if (
      data.wormholeSkill == null ||
      data.wormholeSkill < 1 ||
      isNaN(data.wormholeSkill)
    ) {
      data.wormholeSkill = 1;
    }

    if (!data.spacesuitColor) {
      data.spacesuitColor = "white";
    }
  });

  /**
   * AFTER CREATE Spacefarer
   */
  srv.after("CREATE", "Spacefarers", async (data) => {
    const transport = await getTransport();
    const mail = await transport.sendMail({
      from: "noreply.gsas@galactic.com",
      to: data.email,
      subject: "Welcome to the Galactic Spacefarer Adventure!",
      html: mailBodyServer(data.name),
    });
    console.info("Message sent: ", nodemailer.getTestMessageUrl(mail));
  });

  /**
   * BEFORE READ Spacefarers
   */
  srv.before("READ", "Spacefarers", (req) => {
    isUser(req);
    if (req.user?.roles.admin) return;

    /**
     * Planet-X ihabitants cannot see Planet-Y inhabitants- y
     */
    const userPlanetName = req.user?.attr?.originPlanetName;

    if (userPlanetName && userPlanetName === "Planet-X") {
      const planetYID = "52611125-5ffd-438b-a289-60bbf9e61315";
      req.query.where([{ ref: ["planet_ID"] }, "!=", { val: planetYID }]);
    }
  });

  /**
   * BEFORE UPDATE Spacefarer
   */
  srv.before("UPDATE", "Spacefarers", (req) => {
    isUser(req);
  });

  /**
   * BEFORE DELETE Spacefarer
   */
  srv.before("DELETE", "Spacefarers", (req) => {
    isAdmin(req);
  });
};

function isAdmin(req) {
  if (req.user?.roles.admin) {
    return true;
  } else {
    req.reject(403, "Only users with admin role can perform this operation!");
    return false;
  }
}

function isUser(req) {
  if (req.user?.roles.user) {
    return true;
  } else {
    req.reject(403, "Only authenticated users  can perform this operation!");
    return false;
  }
}
