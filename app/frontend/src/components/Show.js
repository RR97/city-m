import React, { Component } from 'react'
const Instascan = require('instascan');

class Show extends Component {
    state = {
        result: 'No result'
    };

    componentDidMount() {
        let scanner = new Instascan.Scanner({ video: this.refs.camera, scanPeriod: 5 });
        console.log(this.refs.camera);
        scanner.addListener('scan', function (content) {
            if (content) {
                this.setState({
                    result: '<iframe src="' + content + '" width="540" height="450"></iframe>'
                })
            }
        });

        Instascan.Camera.getCameras().then(function (cameras) {
            if (cameras.length > 0) {
                scanner.start(cameras[0]);
            } else {
                console.error('No cameras found.');
            }
        }).catch(function (e) {
            console.error(e);
        });

        this.setState({ scanner });
    }

    render() {
        const { res } = this.state.result;
        return (
            <div>
                <video id="camera" ref="camera" style={{ transform: 'scaleX(-1)', width: '300px',
                    height: '300px', outline: '1px solid red' }} autoPlay />
                {res && <div dangerouslySetInnerHTML={{ __html: res }} />}
            </div>
        )
    }
}

export default Show;
