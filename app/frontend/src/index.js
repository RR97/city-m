import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import App from './App';
import './App.css';
import Main from './components/Main'
import Prizes from './components/Prizes'

ReactDOM.render(
    <Router>
        <div>
            <Route exact path='/' component={App} />
            <Route path='/main' component={Main} />
            <Route path='/prizes' component={Prizes} />
        </div>
    </Router>,
    document.getElementById('root')
);
