import nodemailer from "nodemailer";
import { mailBodyServer } from "../mail/mailService.js";
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

export default (srv) => {
  /**
   * BEFORE CREATE NEW Spacefarer
   */
  srv.before("CREATE", "Spacefarers", (req) => {
    console.log("user role: ", req.user?.roles);
    console.log("new user: ", req.data);
    const data = req.data;
    if (!req.user?.roles.admin) {
      alert("Only admin can create new spacefarers!");
      console.log("NEMNEM, nem vagy admin");
      return;
    }

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
   * BEFROE CREATE Spacefarer
   */
  srv.before("CREATE", "Spacefarers", (data) => {
    console.log("creating new spacefarer");
  });

  /**
   * AFTER CREATE Spacefarer
   */
  srv.after("CREATE", "Spacefarers", async (data) => {
    console.log("mail sending to: ", data);
    const transport = await getTransport();

    const mail = await transport.sendMail({
      from: "noreply.gsas@galactic.com",
      to: data.email,
      subject: "Welcome to the Galactic Spacefarer Adventure!",
      html: mailBodyServer(data.name),
    });

    console.log("Message sent: ", nodemailer.getTestMessageUrl(mail));
  });

  /**
   * UPDATE Spacefarer
   */
  srv.after("UPDATE", "Spacefarers", (data) => {
    console.log("UPDATE történt: ", data);
  });

  /**
   * READ Spacefarers - restrict to user's originPlanet
   */
  srv.before("READ", "Spacefarers", (req, res) => {
    console.log("READING");
    //admin can do all
    if (req.user?.roles.admin) return;

    const userPlanetName = req.user?.attr?.originPlanetName;

    if (userPlanetName && userPlanetName === "Planet-X") {
      const planetYID = "52611125-5ffd-438b-a289-60bbf9e61315";
      //req.query.where({ planet_ID: !planetYID });
      req.query.where([{ ref: ["planet_ID"] }, "!=", { val: planetYID }]);
    }
  });
};
