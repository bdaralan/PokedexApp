# PokedexApp
iOS Pokedex App

## Another version of [PokemonApp](https://github.com/iDara09/PokemonApp)
The [PokemonApp](https://github.com/iDara09/PokemonApp) is running by a REST API from https://pokeapi.co/.  
However, the API currently only has 721 Pokemons, so I start this new one which will run locally by `json` data.

## Status:
* Still in working progress.
* Have not yet to set constains. 
    + Some are programatically calculated.
    + Storyboard is set for iPhone 6s/7.

## ToDo:
* [ ] Move from frame to NSLayoutConstraint for view that has a lot of subviews.
    + [x] ViewLauncher: pokemon weaknesses and pokedex entry
* [ ] Fix Move, Abiliy, and Item retain cycle.
* [x] Add animate opacity in AnimatableView

## Preview:
<div>
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/pokemon-info.png" alt="Pokemon Info" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/home-menu.png" alt="Home Menu" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/pokedex.png" alt="Pokedex" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/pokedex-search.png" alt="Pokedex Search" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/pokemon-weaknesses.png" alt="Pokemon Weaknesses" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/pokedex-entry.png" alt="Pokedex Entry" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/types.png" alt="Types" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/type-detail.png" alt="Types Detail" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/moves.png" alt="Moves" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/move-search.png" alt="Moves Search" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/move-detail.png" alt="Moves Detail" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/abilities.png" alt="Abilites" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/ability-detail.png" alt="Ability Detail" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/tms.png" alt="TMs" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/tm-detail.png" alt="TM Detail" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/items.png" alt="Items" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/item-detail.png" alt="Item Detail" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/berries.png" alt="Berries" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/berry-detail.png" alt="Berry Detail" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/setting.png" alt="Setting" height="360px">
<img src="https://raw.githubusercontent.com/iDara09/PokedexApp/master/Assets/preview/app-icon.png" alt="App Icon" height="360px">
</div>

## Usage:
* You can use this for studying purposes or as a reference guide. *Happy learning Swift. :)*
### Project MVC Files
* View
    + PokedexCell.swfit
    + TypeCell.swfit
    + ItemCell.swift
    + MoveCell.swift
    + AbilityCell.swift
    + MoveDetailCell.swift
    + AbilityDetailCell.swift
    + OffenseDefenseCell.swift
    + MoveDetailUITextView.swift
    + SectionUILabel.swift
    + CircleUILabel.swift
    + TypeUILabel.swift
    + AbilityUILabel.swift
    + MeasurementUILabel.swift
    + RoundUISegmentedControl.swift
    + StatsUIProgressView.swift
    + RIOUILabel.swfit
    + AnimatableView.swift
* Model
    + AppDelegate.swift
    + ViewLauncher.swift
    + Pokemon.swift
    + Ability.swift
    + Move.swift
    + Item.swift
* Controller
    + SettingTVC.swift
    + HomeMenuTVC.swift
    + GenericTVC.swift
    + PokemonInfoVC.swift
    + MoveDetailVC.swift
    + TypeDetailTVC.swift
    + AbilityDetailVC.swift
* Utilities
    + Utilities.swift
    + LoadData.swift
    + AudioPlayer.swift
* Extensions
    + UILabelExtension.swift
    + UIColorExtension.swift
    + AVAudioPlayerExtension.swift
* Constants
    + Variable.swift
    + Constants.swift
* Resources
    + data
    + sound-effect
    + pokemon-cries

## Disclaimer:
* This is for practice and learning purposes only.
* All contents, arts, assets, and data belong to their respective owners.
* If you clone this, please give them credits.

## Data Resources:
* [Bulbapedia](http://bulbapedia.bulbagarden.net)
* [PokemonDB](https://pokemondb.net/)
* [Official Pokemon Site](http://pokemon.com/us/)
* [Phasma](https://www.pokecommunity.com/showthread.php?p=9501022#post9501022)
* [Veekun](https://veekun.com/dex/downloads)