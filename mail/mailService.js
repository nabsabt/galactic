/**
 *
 * @param {*} newUsername : the name of user we send the mail to
 * @returns the structured HTML mail body
 */
export function mailBodyServer(newUsername) {
  return `<h1>Dear ${newUsername}, welcome to the Galactic Spacefarer Adventure System!</h1>
    <br>
    <p>We are excited to have you on board! If you have any questions, feel free to reach out to us!</p>
    <br>
    <strong>Please, do not reply to this email!</strong>
    <br>
    <em>Wish you the benst!</em>`;
}
