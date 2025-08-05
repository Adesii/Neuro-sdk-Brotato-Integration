# Brotato Neuro Integration

this repository is for the mod that allows neuro to play [Brotato](https://store.steampowered.com/app/1942280/Brotato/)
using the [neuro-game-sdk](https://github.com/VedalAI/neuro-game-sdk)

## Installation

this will be done through the Steam Workshop later.

if you want to install install the zip itself, you can download this repository and put it into a mods folder in your steamworkshop folder.
it has to be in a already subscribed mod or it won't load it

example path:
C:\Program Files (x86)\Steam\steamapps\workshop\content\1942280\3019195689
1942280 is the appid for Brotato and 3019195689 is the ImprovedTooltips mod id.
if you put the zip of this in there it will load.

## Dev

If you want to develop this mod you need to follow the [This Guide](https://steamcommunity.com/sharedfiles/filedetails/?id=2931079751) 

and for more info on the mod loader read https://wiki.godotmodding.com/#godot-3

After you have your environment setup. you can just git clone this repository into the root of the Brotato project folder, and it should work.
I would recommend also downloading the mod tool and setting that up correctly as that will help you test it easier in the actual game by quickly exporting it into a random steamworkshop mod folder.

as many things that work in the Editor may and will likely not work in the actual mod environment. Like Classes :D

## Feature goals

- Allow full playthrough of Brotato
- Coop with a human player


## Current state

If you want to follow the current state look in the Brotato integration thread on the Neuro Discord