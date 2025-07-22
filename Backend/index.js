
const app = require("./app");
const connectDB = require("./config/mogooseConnection");

const startServer = async () => {
  try {

    await connectDB();
    const port = process.env.PORT || 3000;
    app.listen(port, () => {
      console.log(`Server is running on port: ${port}`);
    });
    
  } catch (error) {
    console.error("Failed to start server:", error);
    process.exit(1);
  }
};

startServer();