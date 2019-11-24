import React, { Component } from 'react'

class Prizes extends Component {
    render() {
        return (
            <div>
                <button><a href="/main">Back to profile!</a></button>
                <br />
                <div style={{ textAlign: 'center'}}>
                    <div style={{ color: 'blue', fontWeight: 'bold' }}>Redeem you Prezel-Points</div>
                    <br />
                    <div style={{ textAlign: 'justify'}}>
                        <p> Hugs from Nature:                   0 Prezels</p>
                        <p> Fun:                                0 Prezels</p>
                        <p> Great experience and memories:      0 Prezels</p>
                    </div>
                </div>
            </div>
        )
    }
}
export default Prizes;
