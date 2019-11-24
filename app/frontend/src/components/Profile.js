import React, { Component } from 'react'
import maxi from '../maxi.png'

class Profile extends Component {
    render() {
        return (
            <div style={{ textAlign: 'center'}}>
                <div>Max Pretzlman</div>
                <img src={maxi} alt="profilePic" style={{ height: 250 }}/>
                <p>Your score: 500 Pretzl points</p>
                <a href="/prizes">Redeem your points</a>
            </div>
        )
    }
}
export default Profile;
