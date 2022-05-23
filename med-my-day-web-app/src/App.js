import logo from './logo.svg';
import './App.css';
/* new import */ 
import React from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom'
import Admin from './components/Admin';
import LoginPage from './components/LoginPage';

function App() {
  return (
    <div className="wrapper">
      <Router>
          <Routes>
          <Route exact path="/" element={<LoginPage/>}/> 
          <Route exact path="/admin" element={<Admin/>}/>
          </Routes>
      </Router>
    </div>
    
  );
}

export default App;
