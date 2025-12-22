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

/**
 *
 * @param {*} input : input value of the field, needed to be validated
 * @returns true if input is not null/greater or equal to 0/is a Number
 */
function isNumericInputValid(input) {
  if (input == null || input < 0 || isNaN(input)) {
    return false;
  } else {
    return true;
  }
}

module.exports = (server) => {
  /**
   * BEFORE CREATE NEW Spacefarer
   */
  server.before("CREATE", "Spacefarers", (req) => {
    const data = req.data;
    isAdmin(req);

    if (!isNumericInputValid(data.stardustCollection)) {
      data.stardustCollection = 0;
    }

    if (!isNumericInputValid(data.wormholeSkill)) {
      data.wormholeSkill = 0;
    }

    if (!data.spacesuitColor) {
      data.spacesuitColor = "white";
    }
  });

  /**
   * AFTER CREATE Spacefarer
   */
  server.after("CREATE", "Spacefarers", async (data) => {
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
  server.before("READ", "Spacefarers", (req) => {
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
  server.before("UPDATE", "Spacefarers", (req) => {
    isUser(req);
  });

  /**
   * BEFORE DELETE Spacefarer
   */
  server.before("DELETE", "Spacefarers", (req) => {
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
