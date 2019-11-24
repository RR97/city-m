import React, { Component } from 'react'
import Select from 'react-select';
import map from '../map.png'
import scale from "../scale.png";

class Main extends Component {
    state = {
        chosenRoute: false,
        transportation: false
    };

    getMap = () => {
        const options = [{ value: 'On foot(10Pts)', label: 'On foot(10Pts)' },
            { value: 'CityBike(8Pts)', label: 'CityBike(8Pts)' },
            { value: 'MVG(5Pts)', label: 'MVG(5Pts)' }];
        return (
            <div style={{ textAlign: 'center' }}>
                <iframe title="map" style={{ border: '1px solid #000', width: 700, height: 400 }}
                    src='http://www.openstreetmap.org/export/embed.html?bbox=13.4,52.515,13.416,52.523&amp;marker=52.52,13.408&amp;layer=mapnik'>
                </iframe>
                <br />
                <Select
                    onChange={this.handleTransportation}
                    options={options}
                    placeholder="Choose type of transportation and get points"
                />
            </div>)
    };

    handleChange = () => {
        this.setState({ chosenRoute: true });
    };
    handleTransportation = () => {
        this.setState({ transportation: true });
    };

    render() {
        const { chosenRoute, transportation } = this.state;
        const Map = this.getMap();
        const options = [{ value: 'Campus Route', label: 'Campus Route' },
            { value: 'Left Isar bank highlights', label: 'Left Isar bank highlights' },
            { value: 'City Center', label: 'City Center' }];
        return (
            <div>
                { !chosenRoute && !transportation &&
                <div style={{ textAlign: 'center'}}>
                    Choose a route:
                    <Select
                        onChange={this.handleChange}
                        options={options}
                    />
                </div>}
                { chosenRoute && !transportation && Map }
                { chosenRoute && transportation && <div style={{ textAlign: 'center' }}><img src={map} alt="map" style={{ height: 400 }}/></div>}
            </div>
        )
    }
}

export default Main;
