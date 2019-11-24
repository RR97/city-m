import React, { Component } from 'react'
import Select from 'react-select';

class Main extends Component {
    state = {
        chosenRoute: false
    };

    getMap = () => {
        return (
            <div style={{ textAlign: 'center' }}>
                <iframe title="map" style={{ border: '1px solid #000', width: 700, height: 400 }}
                    src='http://www.openstreetmap.org/export/embed.html?bbox=13.4,52.515,13.416,52.523&amp;marker=52.52,13.408&amp;layer=mapnik'>
                </iframe>
                <br />
            </div>)
    };

    handleChange = () => {
        this.setState({ chosenRoute: true });
    };

    render() {
        const { chosenRoute } = this.state;
        const Map = this.getMap();
        const options = [{ value: 'Campus Route', label: 'Campus Route' },
            { value: 'Left Isar bank highlights', label: 'Left Isar bank highlights' },
            { value: 'City Center', label: 'City Center' }];
        return (
            <div>
                { !chosenRoute &&
                <div style={{ textAlign: 'center'}}>
                    Choose a route:
                    <Select
                        onChange={this.handleChange}
                        options={options}
                    />
                </div>}
                { chosenRoute && Map }
            </div>
        )
    }
}

export default Main;
