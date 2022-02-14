# dog rotation

dog rotation tool written in processing-java

> English README | 英語の説明

## setting files

### ./global_config.json 

- global config file to play dog rotation

- set "project_config_location" to the location of your project ***config file***

### each project config file

- each project config file is a json file

- set "screen_width" and "screen_height" to the size of your screen

- set "img_file" to the location of your image file

- set "music_file" to the location of your music file 

- set "trigger_file" to the location of your trigger file (which is recorded by dog_recorder)

- set "fps" to the frame rate of your screen

- set "play_speed" to the speed of your screen (which is useful when you record triggers)

## usage

### dog_rotation

- dog_rotation basically does rotate dog around the screen

- load the project via global_config.json so that u need to set the project_config_location in global_config.json

### dog_recorder

- dog_recorder is a tool to record the trigger file

- load the project via global_config.json so that u need to set the project_config_location in global_config.json

- space key to put one trigger

> Japanese README | 日本語の説明

## setting files

### ./global_config.json 

- 全体の設定を行うファイル

- "project_config_location" を設定することによって、プロジェクトの設定ファイルを指定する

### 各プロジェクトの設定ファイル

- 各プロジェクトの設定ファイルはjsonファイルである

- "screen_width" と "screen_height" には、スクリーンのサイズを指定する

- "img_file" には、画像ファイルのパスを指定する

- "music_file" には、音楽ファイルのパスを指定する

- "trigger_file" には、トリガーファイルのパスを指定する

- "fps" には、スクリーンのフレームレートを指定する

- "play_speed" には、スクリーンの再生スピードを指定する( トリガーファイルを記録する際に便利 )

## 使い方

### dog_rotation

- dog_rotation は、犬を回転させるツール

- global_config.json を使ってプロジェクトをロードすることによって、プロジェクトを指定する必要がある

### dog_recorder

- dog_recorder は、トリガーファイルを記録するツール

- global_config.json を使ってプロジェクトをロードすることによって、プロジェクトを指定する必要がある

- space キーを押すことによって、トリガーを記録する