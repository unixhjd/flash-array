# Project Name: Semiconductor Test Equipment Control Script Collection

## Preface

As semiconductor researchers, we frequently encounter scenarios that require precise control of equipment, rapid automation of testing, and efficient processing and collection of data. Through extensive operation of testing equipment from brands such as Keysight, Keithley, and Lakeshore, we have gradually developed a suite of automation scripts based on GPIB commands.

This collection of scripts aims to provide researchers with an efficient and convenient testing environment, reducing the burden of equipment control and allowing them to focus more on the scientific work itself. Through the implementation of this project, we hope to assist semiconductor researchers in improving experimental efficiency and accelerating the output of research results.

Below is the basic introduction and usage guide for this project. We welcome any form of contribution and suggestion to collectively advance the development of semiconductor test equipment control scripts.

## Project Overview

This project is a collection of scripts for controlling various semiconductor test equipment, primarily covering major testing devices from brands such as Keysight, Keithley, and Lakeshore. All scripts are written based on GPIB commands, making it easy for users to get started and use.

## Supported Devices

- Keysight series test equipment
- Keithley series test equipment
- Lakeshore VSM device

## Script Description

### 1. GPIB Commands

Most of the scripts in this collection are written using GPIB commands, providing control over various types of equipment. Users can easily adjust the testing process by modifying the relevant parameters.

### 2. WGFMU Device Control

The WGFMU device is controlled using its encapsulated C-language instructions, which are invoked through Matlab's MinGW. Details are as follows:

- **waveform folder**: Contains operations for custom waveform generation and measurement implementation. Users can modify waveform files to achieve personalized testing.
- **Invocation Method**: Calls the encapsulated functions written in C within the Matlab environment to control the WGFMU device.

### 3. Control of Other Devices

The GPIB commands for other devices have been implemented in the testtable folder and can be used directly or modified as needed.

## Usage Instructions

1. Ensure that Matlab software and the MinGW compiler are installed.
2. Clone this project to your local machine.
3. Modify the parameters in the scripts as per your requirements.
4. Run the scripts to start the test.

## Future Updates

As the number of devices I use increases, this project will continue to be updated with control scripts for additional equipment. Stay tuned.

## Feedback

If you encounter any issues while using this project, please contact the author via the following methods:

- Email: songxu689@pku.edu.cn
- GitHub: https://github.com/unixhjd

Thank you for your use and support!

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
