# Seismic Visualization

A web application for seismic visualization

## Introduction

For my senior project at Walla Walla University, I have been working with Professor Mark Haun to create a web-based tool for seismic visualization that runs in a browser and connects to the International Federation of Digital Seismograph Networks web services (fdsnws).

The core requirements of this project involve creating a graph that supports basic plotting of seismic data with dynamic scaling. The graph should be anti-aliased and look good as well. The data being displayed will be either real-time data or archived readings.

## Resources

The libraries I used to accomplish common JS interoperability tasks.

- [js.dart](https://pub.dev/packages/js)
- [js_util](https://pub.dev/packages/js_util)
- [dart.convert](https://pub.dev/packages/convert)
- [dart:async](https://pub.dev/packages/async)

## Project Summary

A dart page requests the user to select a station. This information is passed to a JS function in a html page which in turn utilizes functions from the seisplot.js external library to connect to the SEEDLink server and retrieve the time series of the user specified station.

This data is then parsed into a json string and returned. The JS function is then called from a dart file as an external function. The json string is at this point a promise, which is converted to a future. This json future is then parsed into a Dart class list, allowing the data to be accessible to the rest of the Dart application. This usable data is asynchronous. While the data is fetched and parsed the rest of the program must wait. This is done using the async and await keywords. The list is still a future, meaning that it has two states, completed or incomplete. This data is subject to change, and so to graph it the FutureBuilder widget is used. This widget plots the seismic data based on the latest snapshot obtained from the future.

In this project, I graph the data on a line chart within the future builder. When the incoming string is at a certain length the data is refreshed, updating the graph with fresh data.

## Future Additions

- The function to remove linear trend located in jsonParser.dart should be an optional implementation.
- A different chart library may be considered for the helicorder graph due to limitations with the current one.
- Implement an [on demand loading](https://help.syncfusion.com/flutter/cartesian-charts/on-demand-loading) function for endless scrolling through history.
- Add a form for selecting the station channel
- Fix bug that prevents current day from being displayed on helicorder

## Web View

- [Pages](https://owen-hoffman.github.io/#/)

## Source Code

- [GitHub](https://github.com/Owen-Hoffman/Seismic-Visualization)
