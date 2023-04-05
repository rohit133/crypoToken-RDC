import React from "react";
import Header from "./Header";
import Faucet from "./Faucet";
import Balance from "./Balance";
import Transfer from "./Transfer";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Navbar from "./Navbar";
import About from "./About";
import Contact from "./Contact";
import Profile from "./Profile";
function App() {

  return (
    <div id="screen">
      <BrowserRouter>
        <Navbar />
        <Routes>
          <Route path="/about" element ={<About/>} />
          <Route path="/contact" element ={<Contact/>} />
          <Route path="/profile" element ={<Profile/>} />
        </Routes>
      </BrowserRouter>
      <Header />
      <Faucet />
      <Balance />
      <Transfer />
    </div>
  );
}

export default App;
