import { withRouter } from 'react-router-dom'
import React, { Component } from 'react'

class LogIn extends Component {
    state = {
      username: null,
      password: null,
    };

    routeChange() {
        let path = '/main';
        this.props.history.push(path);
    }
    logIn = () => {
        const username = this.refs.username.value;
        const password = this.refs.password.value;
        if (username === 'admin' && password === '1234') {
            this.routeChange();
        }
    };

    render() {
        return (
            <div>
                <p style={{ marginTop: -120 }}>
                    <div style={{ paddingBottom: 10 }}>Username: <input type="text" ref="username" name="uname"/></div>
                    <div>Password: <input type="password" ref="password" name="password"/></div>
                </p>
                <button style={{ paddingBottom: 10 }} onClick={() => {this.logIn()}}>Log In</button>
            </div>
        )
    }
}

export default withRouter(LogIn);
