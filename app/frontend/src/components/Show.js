import React, { Component } from 'react'
import QrReader from "react-qr-reader";

class Show extends Component {
    state = {
        result: 'No result'
    };

    handleScan = data => {
        if (data) {
            this.setState({
                result: '<iframe src="' + data + '" width="540" height="450"></iframe>'
            })
        }
    };

    handleError = err => {
        console.error(err)
    };

    render() {
        const { res } = this.state.result;
        return (
            <div>
                <QrReader
                    delay={300}
                    onError={this.handleError}
                    onScan={this.handleScan}
                    style={{ width: '100%' }}
                    facingMode='environment'
                />
                <div dangerouslySetInnerHTML={{ __html: res }} />
            </div>
        )
    }
}

export default Show;
