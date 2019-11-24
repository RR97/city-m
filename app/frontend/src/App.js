import React from 'react';
import { NavLink } from 'react-router-dom'
import logo from './logo.png';
import './App.css';

function App() {

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p style={{ marginTop: -120 }}>
          <div style={{ paddingBottom: 10 }}>Username: <input type="text" name="uname"/></div>
          <div>Password: <input type="password" name="password"/></div>
        </p>

        <NavLink to="/main"><button style={{ paddingBottom: 10 }}>Log In</button></NavLink>
        <a
          className="App-link"
          href="/create"
          rel="noopener noailed to execute 'createObjectURL' on 'URL': No function was found that matched the signature provided.referrer"
        >
          If you don't have an account, please register
        </a>
      </header>
    </div>
  );
}

export default App;
