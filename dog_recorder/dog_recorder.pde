import processing.sound.*;

// global settings
int canvas_x = 640;
int canvas_y = 480;
int fps = 60;
String config_location = "";
// music player
String music_file = "";
// use SoundFile class
SoundFile music;
float play_speed = 1.0f;
// time logger
String trigger_file = "";
ArrayList<Double> time_log = new ArrayList<Double>();


// processing func
public void settings() {
    
    // load config
    JSONObject global_config_json = loadJSONObject("global_config.json");
    config_location = global_config_json.getString("project_config_location");
    
    // load config which is json file
    JSONObject pro_config = loadJSONObject(config_location);
    
    // get string without the file name from config_location
    String[] config_path = split(config_location, "/");
    String config_dir = "";
    for (int i = 0; i < config_path.length - 1; i++) {
        config_dir += config_path[i] + "/";
    }
    
    // absolute path + json file contentn
    music_file = config_dir + pro_config.getString("music_file");
    trigger_file = config_dir + pro_config.getString("trigger_file");
    canvas_x = pro_config.getInt("screen_width");
    canvas_y = pro_config.getInt("screen_height");
    fps = pro_config.getInt("fps");
    play_speed = pro_config.getFloat("play_speed");
    
    //init canvas size
    size(canvas_x, canvas_y, P3D);
}

void setup() {
    frameRate(fps);
    music = new SoundFile(this, music_file);
}

void draw() {
    // draw background
    background(225, 225, 225);
    
    // show play location of player left corner
    fill(25); // color is black
    // font bigger
    textSize(24);
    text("dog recorder", 10, 30);

    // font small
    textSize(16);
    text("press space key to record dog move", 10, 50);
    textSize(16);
    text("play location: " + music.position(), 10, 70);
    // show all triggers
    for (int i = 0; i < time_log.size(); i++) {
        text(time_log.get(i).toString(), 300, 90 + (time_log.size() - 1 - i) * 20);
    }

    // draw start recording button
    // using rectangles
    noFill();
    stroke(0);
    // top left
    rect(100, 100, 80, 80);
    // using text
    fill(0);
    textSize(24);
    text("start", 110, 130);

    // draw save button
    // using rectangles
    noFill();
    stroke(0);
    // top left
    rect(200, 100, 80, 80);
    // using text
    fill(0);
    textSize(24);
    text("save", 210, 130);

}

// capture space key when space key is pressed, excute only once
void keyPressed() {
    if (key == ' ') {
        // add current time to time_log
        time_log.add((double)music.position());
    }
}

// mouse clicker
void mousePressed() {
    // when mouse is pressed, excute only once
    if (mouseButton == LEFT) {
        // if start button
        if (mouseX > 100 && mouseX < 180 && mouseY > 100 && mouseY < 180) {
            // start playing music
            music = new SoundFile(this, music_file);
            music.play();
            music.rate(1.0);
        }
        // if save button
        if (mouseX > 200 && mouseX < 280 && mouseY > 100 && mouseY < 180) {
            if (time_log.size() != 0) {
                String[]str_time_log = new String[time_log.size()];
                for (int i = 0; i < time_log.size(); i++) {
                    str_time_log[i] = time_log.get(i).toString();
                }
                saveStrings(trigger_file, str_time_log);
            }

            exit();
        }
    } 
}