import React, { Component } from 'react'
import maxi from '../maxi.png'

class Profile extends Component {
    render() {
        return (
            <div style={{ textAlign: 'center'}}>
                <div>Mr. Max Pretzlman</div>
                <img src={maxi} alt="profilePic" style={{ height: 250 }}/>
            </div>
        )
    }
}
export default Profile;
