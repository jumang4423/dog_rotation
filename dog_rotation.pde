import processing.sound.*;

// kinda vec2
class Point {
    int x;
    int y;
    
    Point(int _x, int _y) {
        x = _x;
        y = _y;
    }
}

private Point[] gen_random_points() {
    Point[] points = new Point[4];
    points[0] = new Point(int(random(0, canvas_x / 2)), int(random(0, canvas_y / 2)));
    points[1] = new Point(int(random(canvas_x / 2, canvas_x)), int(random(0, canvas_y / 2)));
    points[2] = new Point(int(random(canvas_x / 2, canvas_x)), int(random(canvas_y / 2, canvas_y)));
    points[3] = new Point(int(random(0, canvas_x / 2)), int(random(canvas_y / 2, canvas_y)));
    return points;
}

// わんこふにゃふにゃくん
class Dog {
    Point[] points;
    Point[] goal_points;
    PImage dog_img;
    
    //constructor
    Dog(PImage _dog_img) {
        points = gen_random_points();
        goal_points = gen_random_points();
        dog_img = _dog_img;
    }
    
    void move_dog() {
        // random point
        goal_points = gen_random_points();     
    }
    
    void draw() {
        // move point to goal_points *= 0.25
        for (int i = 0; i < points.length; i++) {
            points[i].x += (goal_points[i].x - points[i].x) * (0.3 * (60/fps));
            points[i].y += (goal_points[i].y - points[i].y) * (0.3 * (60/fps));
        }
        
        // draw dog image center with points
        beginShape(QUADS);
        textureMode(NORMAL);
        texture(dog_img);
        vertex(points[0].x, points[0].y, 0, 0, 0);
        vertex(points[1].x, points[1].y, 0, 1, 0);
        vertex(points[2].x, points[2].y, 0, 1, 1);
        vertex(points[3].x, points[3].y, 0, 0, 1);
        endShape();
    }
}

// global settings
int canvas_x = 640;
int canvas_y = 480;
int fps = 60;
String config_location = "";
// わんこムーブ設定
Dog dog;
String dog_img = "";
// music player
String music_file = "";
float play_speed = 1.0;
// use SoundFile class
SoundFile music;
// トリガーの設定
String trigger_file = "";
ArrayList<Double> trigger_lines = new ArrayList<Double>();

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
    dog_img = config_dir + pro_config.getString("img_file");
    music_file = config_dir + pro_config.getString("music_file");
    trigger_file = config_dir + pro_config.getString("trigger_file");
    canvas_x = pro_config.getInt("screen_width");
    canvas_y = pro_config.getInt("screen_height");
    fps = pro_config.getInt("fps");
    play_speed = pro_config.getFloat("play_speed");
    
    //init canvas size
    size(canvas_x, canvas_y, P3D);
}

// triggers
ArrayList<Double> parse_trigger(String[] line) {
    ArrayList<Double> triggers = new ArrayList<Double>();
    for (int i = 0; i < line.length; i++) {
        triggers.add(Double.parseDouble(line[i]));
    }
    return triggers;
}

void setup() {
    frameRate(fps);
    dog = new Dog(loadImage(dog_img));
    
    // load triggers
    String[] _lines = loadStrings(trigger_file);
    trigger_lines = parse_trigger(_lines);
    
    // start playing music
    // sampleRate is 44100 / 2
    music = new SoundFile(this, music_file);
    music.play();
    music.rate(play_speed);
}

void draw() {
    // draw background
    background(225, 225, 225);
    // show dog
    dog.draw();
    
    // move dog if triggered by music
    while(true) {
        if (trigger_lines.size() != 0 && music.position() > trigger_lines.get(0) - 0.025) {
            dog.move_dog();
            // remove first trigger from trigger_lines
            trigger_lines.remove(0);
        } else {
            break;
        }
    }
}