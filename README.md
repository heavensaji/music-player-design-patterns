# Music Player Service — Design Patterns Assignment

## Overview

This project implements a music player service demonstrating core design patterns using Swift (code written and tested in an online Swift playground). The player supports:

- Multiple music sources (Local files and mock Spotify source)
- Playback controls: play, pause, skip, previous
- Playlist queue management (add, remove, reorder tracks)
- State notifications simulated via console output
- Single player instance management (Singleton pattern)
- MVVM architecture pattern (demonstrated in code structure, comment explained)


## Features

- **Strategy Pattern:** Used for handling different music sources through a unified interface.
- **Singleton Pattern:** The music player ensures only one player instance exists.
- **Observer Pattern (simulated):** Playback state notifications using Combine in iOS, simulated here with simple console messages.
- **MVVM Architecture:** Separation of concerns demonstrated via ViewModel class handling playback logic.


## How to Run

- The code is designed for Swift environments.
- Since I am working on Windows without a macOS environment, I developed and tested the core logic using [SwiftFiddle](https://swiftfiddle.com) — an online Swift playground.
- To view or run the code, copy-paste the contents of `music_player.swift` into [SwiftFiddle](https://swiftfiddle.com) or any other online Swift compiler.


## Limitations

- No actual iOS UI or audio playback is included because running Xcode and iOS SDK requires macOS.
- The project demonstrates design patterns, architecture, and logic only.
- Playback progress and state updates are simulated using print statements.


## Design Notes

- The project uses protocols and multiple implementations to achieve extensibility in music sources.
- The player queue is managed with array operations demonstrating add, remove, and reorder.
- The Singleton ensures a single music player instance across the app lifecycle.
- MVVM is illustrated by a ViewModel class separating UI logic from business logic (commented in code).


Thank you for reviewing my assignment!
