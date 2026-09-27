# Garden Trading Hub

A dynamic garden trading hub system for FiveM servers.

## Features

- Plant growth system with configurable growth time and maximum plants
- Booth claiming system with configurable booth price and auto-claim delay

## Requirements

- FiveM server
- ESX Framework
- MySQL database

## Installation

1. Download the script files.
2. Place them in your FiveM server's resources folder.
3. Add `start garden_trading_hub` to your server.cfg file.
4. Import the database.sql file into your MySQL database.

## Usage

### Commands

- `/plant [plantType]` - Plant a plant in your garden.
- `/checkgarden` - Check the status of your garden.
- `/claimbooth` - Claim a booth in the trading hub.

### Configuration

- `Config.Garden.GrowthTime` - Time it takes for a plant to grow (in milliseconds).
- `Config.Garden.MaxPlants` - Maximum number of plants that can be planted.
- `Config.Market.BoothPrice` - Price to claim a booth (in-game currency).
- `Config.Market.AutoClaimDelay` - Delay between auto-claiming booths (in milliseconds).

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=garden-trading-hub&utm_content=bottom) — describe it in one sentence and get the full source code.