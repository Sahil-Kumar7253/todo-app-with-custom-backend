const app = require("./app");
const db = require("./config/mogooseConnection");
const port = 3000;

app.listen(port, () => {
  console.log(`Server is running on port : http://localhost:${port}`);
})