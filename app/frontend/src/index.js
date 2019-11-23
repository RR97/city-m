import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import App from './App';
import './App.css';
import Create from './components/Create';
import Show from './components/Show'

ReactDOM.render(
    <Router>
        <div>
            <Route exact path='/' component={App} />
            <Route path='/create' component={Create} />
            <Route path='/show' component={Show} />
        </div>
    </Router>,
    document.getElementById('root')
);
