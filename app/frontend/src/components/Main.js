import Scan from './Show'
import Profile from './Profile'
import Route from './Route'
import React, { Component } from 'react'

class Main extends Component {
    state = {
        step: '1'
    };

    setStep = (step) => {
        console.log(step);
        if (step !== this.state.step) {
            this.setState({ step });
        }
    };

    render() {
        const { step } = this.state;
        console.log(step);
        return (
            <div>
                <div>
                    <button onClick={() => {this.setStep('1')}}>Scan Code</button>
                    <button onClick={() => {this.setStep('2')}} style={{ paddingLeft: 30 }}>Search Routes</button>
                    <button style={{ float: 'right' }} onClick={() => {this.setStep('3')}}>Your Profile</button>
                </div>
                <br />
                <div>
                    { step === '1' && <Scan /> }
                    { step === '2' && <Route /> }
                    { step === '3' && <Profile /> }
                </div>
            </div>
        )
    }
}

export default Main;
