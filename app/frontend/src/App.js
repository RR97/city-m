import React from 'react';
import logo from './logo.png';
import './App.css';
import LogIn from './components/LogIn'

function App() {

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <LogIn />
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
