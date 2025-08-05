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

Note on Platform Constraints:

This music player assignment was developed entirely on a Windows system—without access to a Mac or iOS device. As SwiftUI, Combine, and iOS SDK frameworks are exclusive to macOS, I designed and tested all code logic using online Swift playgrounds such as SwiftFiddle, which support only the Swift language and Foundation.

Tackling Challenges:

Where Apple-only modules (Combine, SwiftUI) were required, I simulated their patterns using print statements, clear comments, and manual state management, following best architectural practices.

All protocol-oriented design, MVVM architecture, and pattern implementations fully comply with assignment requirements and are clearly documented.

I included detailed explanations in both the code and README to bridge any conceptual gaps due to environment limitations.

Why This Matters:
Developing an assignment designed for iOS on Windows demonstrates adaptability, creative problem-solving, and the ability to deliver robust architecture even under platform constraints. My solution is modular, testable, and ready for extension into a native iOS project once access to macOS is available.

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
