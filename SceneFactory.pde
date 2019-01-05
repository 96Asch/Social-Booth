class SceneFactory {

  private JSONObject json;
  private DefaultStyling style;

  public SceneFactory() {
    style = new DefaultStyling();

    //Styling for the titles
    style.getTitle().setStyle(new Style() {
      public void setStyle(int x, int y, int w, int h) {
        drawTitle(x, y, w, h);
      }
    }
    );

    //Styling for the subtitles
    style.getSubtitle().setStyle(new Style() {
      public void setStyle(int x, int y, int w, int h) {
        drawSubtitle(x, y, w, h);
      }
    }
    );

    //Styling for the bodies
    style.getBody().setStyle(new Style() {
      public void setStyle(int x, int y, int w, int h) {
        drawDialog(x, y, w, h);
      }
    }
    );

    //Styling for the advance buttons
    style.getAdvButton().setStyle(new Style() {
      public void setStyle(int x, int y, int w, int h) {
        drawBox(x, y, w, h, -20);
      }
    }
    );

    //Hover styling for the advance buttons
    style.getAdvButton().setHover(new HoverEvent() {
      public void onHover(int x, int y, int w, int h) {
        drawBoxOnHover(x, y, w, h, -20);
      }
    }
    );

    Timer timer = new Timer();
    timer.setEvent(new TimerEvent(DEFAULT_SCENE) {
      public void onTimeUp() {
        SceneManager.INSTANCE.setScene(id);
      }
    }
    );
    style.setTimer(timer);
  }

  public boolean createScenesFromDescription(String desc) {
    boolean success = true;
    boolean stylingFound = false;
    String path = desc.substring(0, desc.lastIndexOf("/")+1);
    BufferedReader reader = null;
    try {
      reader = createReader(desc);
      String line;
      while ((line = reader.readLine()) != null) {
        if (line.startsWith("#") || line.isEmpty()) {
          continue;
        } else if (!stylingFound) {
          String[] split = split(line, WHITESPACE);
          parseStyling(path + split[0]);
          stylingFound = true;
        } else {
          String[] split = split(line, WHITESPACE);
          SceneManager.INSTANCE.addScene(createScene(path + split[0]));
        }
      }
    } 
    catch (IOException e) {
      e.printStackTrace();
      success = false;
    }
    finally {
      try {
        if (reader != null) {
          reader.close();
        }
      } 
      catch (IOException e) {
        e.printStackTrace();
        success = false;
      }
    }
    return success;
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////// DEFAULT STYLING //////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////

  private void parseStyling(String file) {
    if (file == null || file.isEmpty()) {
      return;
    }
    json = loadJSONObject(file);
    if (json.isNull("bg")) throw new JSONNotFoundException("{bg} field not found in styling") ;
    if (json.isNull("title")) throw new JSONNotFoundException("{title} field not found in styling") ;
    if (json.isNull("body")) throw new JSONNotFoundException("{body} field not found in styling") ;
    if (json.isNull("subtitle")) throw new JSONNotFoundException("{subtitle} field not found in styling") ;
    if (json.isNull("centerScale")) throw new JSONNotFoundException("{centerScale} field not found in styling") ;

    style.setBg(json.getString("bg"));
    parseAdvButtonStyling(json.getJSONObject("advbutton"), style.getAdvButton());
    parseTextStyling(json.getJSONObject("title"), style.getTitle());
    parseTextStyling(json.getJSONObject("body"), style.getBody());
    parseTextStyling(json.getJSONObject("subtitle"), style.getSubtitle());
    parseScaleStyling(json.getJSONObject("centerScale"), style.getScale());
    parseTimer(json.getJSONObject("mainTimer"));
    parseTimerBar(json.getJSONObject("gameTimerBar"), style.getTimerBar());
  }

  private void parseAdvButtonStyling(JSONObject json, ButtonStyling styling) {
    if (json == null) throw new JSONNotFoundException("json was null in parseAdvButtonStyling");
    if (json.isNull("width")) throw new JSONNotFoundException("{width} field not found in advButtonStyling");
    if (json.isNull("height")) throw new JSONNotFoundException("{height} field not found in advButtonStyling");
    if (json.isNull("fontsize")) throw new JSONNotFoundException("{fontsize} field not found in advButtonStyling");
    if (json.isNull("font")) throw new JSONNotFoundException("{font} field not found in advButtonStyling");
    if (json.isNull("continue")) throw new JSONNotFoundException("{continue} field not found in advButtonStyling");
    if (json.isNull("previous")) throw new JSONNotFoundException("{previous} field not found in advButtonStyling");
    styling.setWidth(convertMeasurement(json.getString("width")));
    styling.setHeight(convertMeasurement(json.getString("height")));
    styling.setFontSize(json.getInt("fontsize"));
    styling.setFont(json.getString("font"));
    parseDefaultPositionStyling(json.getJSONObject("continue"), styling.getPosition());
    parseDefaultPositionStyling(json.getJSONObject("previous"), styling.getPreviousPosition());
    if (!json.isNull("alignX"))
      styling.setAlignX(convertAlignX(json.getString("alignX")));
    if (!json.isNull("alignY"))
      styling.setAlignY(convertAlignY(json.getString("alignY")));
    if (!json.isNull("offset"))
      parseOffsetDefaultStyling(json.getJSONObject("offset"), styling);
  }

  private void parseTextStyling(JSONObject json, TextStyling styling) {
    if (json == null) throw new JSONNotFoundException("json was null in parseTextStyling");
    if (json.isNull("width")) throw new JSONNotFoundException("{width} field not found in TextStyling");
    if (json.isNull("height")) throw new JSONNotFoundException("{height} field not found in TextStyling");
    if (json.isNull("fontsize")) throw new JSONNotFoundException("{fontsize} field not found in TextStyling");
    if (json.isNull("font")) throw new JSONNotFoundException("{font} field not found in TextStyling");
    parseDefaultPositionStyling(json, styling.getPosition());
    styling.setWidth(convertMeasurement(json.getString("width")));
    styling.setHeight(convertMeasurement(json.getString("height")));
    styling.setFontSize(json.getInt("fontsize"));
    styling.setFont(json.getString("font"));
    if (!json.isNull("alignX"))
      styling.setAlignX(convertAlignX(json.getString("alignX")));
    if (!json.isNull("alignY"))
      styling.setAlignY(convertAlignY(json.getString("alignY")));
    if (!json.isNull("offset"))
      parseOffsetDefaultStyling(json.getJSONObject("offset"), styling);
  }

  private void parseScaleStyling(JSONObject json, ScaleStyling styling) {
    if (json == null) throw new JSONNotFoundException("json was null in parseTextStyling");
    if (json.isNull("width")) throw new JSONNotFoundException("{width} field not found in ScaleStyling");
    if (json.isNull("height")) throw new JSONNotFoundException("{height} field not found in ScaleStyling");
    if (json.isNull("descFontSize")) throw new JSONNotFoundException("{descFontSize} field not found in ScaleStyling");
    if (json.isNull("descFont")) throw new JSONNotFoundException("{descFont} field not found in ScaleStyling");
    if (json.isNull("barFontSize")) throw new JSONNotFoundException("{barFontSize} field not found in ScaleStyling");
    if (json.isNull("barFont")) throw new JSONNotFoundException("{barFont} field not found in ScaleStyling");
    if (json.isNull("descWidth")) throw new JSONNotFoundException("{descWidth} field not found in ScaleStyling");
    if (json.isNull("descHeight")) throw new JSONNotFoundException("{descHeight} field not found in ScaleStyling");

    parseDefaultPositionStyling(json, styling.getPosition());
    styling.setWidth(convertMeasurement(json.getString("width")));
    styling.setHeight(convertMeasurement(json.getString("height")));
    styling.setDescFontSize((json.getInt("descFontSize")));
    styling.setDescFont(json.getString("descFont"));
    styling.setBarFontSize(json.getInt("barFontSize"));
    styling.setBarFont(json.getString("barFont"));
    styling.setDescWidth(convertMeasurement(json.getString("descWidth")));
    styling.setDescHeight(convertMeasurement(json.getString("descHeight")));
  }

  private void parseTimer(JSONObject json) {
    if (json == null) throw new JSONNotFoundException("json was null in parseTimer");
    if (json.isNull("duration")) throw new JSONNotFoundException("{duration} field not found in timer");
    if (json.isNull("onTimer")) throw new JSONNotFoundException("{onTimer} field not found in timer");
    Timer timer = buildTimer(json.getString("duration"), json.getString("onTimer"));
    style.setTimer(timer);
  }

  private void parseTimerBar(JSONObject json, TimerBarStyling styling) {
    if (json == null) throw new JSONNotFoundException("json was null in parseTimerBar");
    parseDefaultPositionStyling(json, styling.getPosition());
    parseDefaultDimensionStyling(json, styling);
  }

  private void parseDefaultDimensionStyling(JSONObject json, NodeStyling styling) {
    if (json.isNull("width")) throw new JSONNotFoundException("{width} field not found in styling");
    if (json.isNull("height")) throw new JSONNotFoundException("{height} field not found in styling");
    styling.setWidth(convertMeasurement(json.getString("width")));
    styling.setHeight(convertMeasurement(json.getString("height")));
  }

  private void parseDefaultPositionStyling(JSONObject json, PositionStyling styling) {
    if (json == null) throw new JSONNotFoundException("json was null in positionStyling");
    if (json.isNull("posX")) throw new JSONNotFoundException("{posX} field not found in styling");
    if (json.isNull("posY")) throw new JSONNotFoundException("{posY} field not found in styling");
    styling.setPosX(convertMeasurement(json.getString("posX")));
    styling.setPosY(convertMeasurement(json.getString("posY")));
  }

  private void parseOffsetDefaultStyling(JSONObject json, TextStyling styling) {
    if (json == null) throw new JSONNotFoundException("json was null in setOffsetDefaultStyling");
    if (!json.isNull("offsetX"))
      styling.getOffset().setOffsetX(json.getInt("offsetX"));
    if (!json.isNull("offsetY"))
      styling.getOffset().setOffsetY(json.getInt("offsetY"));
    if (!json.isNull("offsetW"))
      styling.getOffset().setOffsetW(json.getInt("offsetW"));
    if (!json.isNull("offsetH"))
      styling.getOffset().setOffsetH(json.getInt("offsetH"));
  }

  private void parseOffsetDefaultStyling(JSONObject json, ButtonStyling styling) {
    if (json == null) throw new JSONNotFoundException("json was null in setOffsetDefaultStyling");
    if (!json.isNull("offsetX"))
      styling.getOffset().setOffsetX(json.getInt("offsetX"));
    if (!json.isNull("offsetY"))
      styling.getOffset().setOffsetY(json.getInt("offsetY"));
    if (!json.isNull("offsetW"))
      styling.getOffset().setOffsetW(json.getInt("offsetW"));
    if (!json.isNull("offsetH"))
      styling.getOffset().setOffsetH(json.getInt("offsetH"));
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////

  private void setTextToDefault(JSONObject json, TextBody text) {
    if (!json.isNull("styleid")) {
      String styleid = json.getString("styleid");
      TextStyling styling;
      switch(styleid) {
      case "title":
        styling = style.getTitle();
        break;
      case "body":
        styling = style.getBody();
        break;
      case "subtitle":
        styling = style.getSubtitle();
        break;
      default:  
        return;
      }

      text.setPosX(styling.getPosition().getPosX());
      text.setPosY(styling.getPosition().getPosY());
      text.setWidth(styling.getWidth());
      text.setHeight(styling.getHeight());
      text.setFontSize(styling.getFontSize());
      text.setFont(styling.getFont());
      text.setStyle(styling.getStyle());
      text.setAlignX(styling.getAlignX());
      text.setAlignY(styling.getAlignY());
      text.setOffset(styling.getOffset());
    }
  }

  private void setButtonToDefault(JSONObject json, Button button) {
    if (!json.isNull("styleid")) {
      String styleid = json.getString("styleid");
      ButtonStyling styling;
      switch(styleid) {
      case "advbutton":
        styling = style.getAdvButton();
        break;
      default:
        return;
      }
      button.setWidth(styling.getWidth());
      button.setHeight(styling.getHeight());
      button.setFontSize(styling.getFontSize());
      button.setFont(styling.getFont());
      button.setStyle(styling.getStyle());
      button.setOnHover(styling.getHover());
      button.setAlignX(styling.getAlignX());
      button.setAlignY(styling.getAlignY());
      button.setOffset(styling.getOffset());
      if (!json.isNull("positionid")) {
        ButtonStyling adv = style.getAdvButton();
        String positionid = json.getString("positionid");
        switch(positionid) {
        case "continue":
          button.setPosX(adv.getPosition().getPosX());
          button.setPosY(adv.getPosition().getPosY());
          break;
        case "previous":
          button.setPosX(adv.getPreviousPosition().getPosX());
          button.setPosY(adv.getPreviousPosition().getPosY());
        default:
          break;
        }
      }
    }
  }

  public void setScaleToDefault(JSONObject json, Scale scale) {
    if (!json.isNull("styleid")) {
      String styleid = json.getString("styleid");
      ScaleStyling styling;
      switch(styleid) {
      case "centerScale":
        styling = style.getScale();
        break;
      default:
        return;
      }
      scale.setPosX(styling.getPosition().getPosX());
      scale.setPosY(styling.getPosition().getPosY());
      scale.setWidth(styling.getWidth());
      scale.setHeight(styling.getHeight());
      scale.setDescFontSize(styling.getDescFontSize());
      scale.setDescFont(styling.getDescFont());
      scale.setBarFontSize(styling.getBarFontSize());
      scale.setBarFont(styling.getBarFont());
      scale.setDescWidth(styling.getDescWidth());
      scale.setDescHeight(styling.getDescHeight());
    }
  }

  private void setTimerToDefault(JSONObject json, Timer timer) {
    if (!json.isNull("styleid")) {
      String styleid = json.getString("styleid");
      Timer t;
      switch(styleid) {
      case "mainTimer":
        t = style.getTimer();
        break;
      default:
        return;
      }
      timer.setDuration(t.getDuration());
      timer.setEvent(t.getEvent());
    }
  }

  private void setTimerBarToDefault(JSONObject json, TimerBar timerbar) {
    if (!json.isNull("styleid")) {
      String styleid = json.getString("styleid");
      TimerBarStyling t;
      switch(styleid) {
      case "gameTimerBar":
        t = style.getTimerBar();
        break;
      default:
        return;
      }
      timerbar.setPosX(t.getPosition().getPosX());
      timerbar.setPosY(t.getPosition().getPosY());
      timerbar.setWidth(t.getWidth());
      timerbar.setHeight(t.getHeight());
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////// BUILDERS  ////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////

  private Scene createScene(String file) {
    if (file == null || file.isEmpty()) return null;
    json = loadJSONObject(file);
    if (json.isNull("id")) throw new JSONNotFoundException("{id} field not found in scene");
    String id = json.getString("id");
    Scene scene = new Scene(id);

    if (!json.isNull("bg")) {
      String bg = json.getString("bg");
      scene.setBg(bg);
    } else {
      scene.setBg(style.getBg());
    }

    if (!json.isNull("texts")) {
      JSONArray texts = json.getJSONArray("texts");
      for (int i = 0; i < texts.size(); ++i) {
        scene.addNode(createTextBody(texts.getJSONObject(i)));
      }
    }

    if (!json.isNull("buttons")) {
      JSONArray buttons = json.getJSONArray("buttons");
      for (int i = 0; i < buttons.size(); ++i) {
        scene.addNode(createButton(buttons.getJSONObject(i)));
      }
    }

    if (!json.isNull("shapes")) {
      JSONArray shapes = json.getJSONArray("shapes");
      for (int i = 0; i < shapes.size(); ++i) {
        scene.addNode(createShape(shapes.getJSONObject(i)));
      }
    }

    if (!json.isNull("scales")) {
      JSONArray scales = json.getJSONArray("scales");
      for (int i = 0; i < scales.size(); ++i) {
        scene.addNode(createScale(scales.getJSONObject(i)));
      }
    }


    if (!json.isNull("timer")) {
      scene.setTimer(createTimer(json.getJSONObject("timer")));
    }

    if (!json.isNull("timerBar")) {
      TimerBar tBar = createTimerBar(json.getJSONObject("timerBar"));
      tBar.setTimer(scene.getTimer());
      scene.addNode(tBar);
    }

    if (!json.isNull("topicGame")) {
      JSONArray topics = json.getJSONArray("topicGame");
      for (int i = 0; i < topics.size(); ++i) {
        scene.addNode(createTopicGame(topics.getJSONObject(i)));
      }
    }

    if (!json.isNull("onclick")) {
      String next = json.getString("onclick");
      scene.setOnClick(new ClickEvent(next) {
        public void onClick() {
          data.setShouldPrepare(true);
          SceneManager.INSTANCE.setScene(id);
        }
      }
      );
    }
    return scene;
  }

  private TextBody createTextBody(JSONObject json) {
    if (json == null) throw new JSONNotFoundException("json was null in createTextBody");
    if (json.isNull("text")) throw new JSONNotFoundException("{text} field not found in textbody!");
    String text = json.getString("text");
    TextBody textBody = new TextBody(text, 0, 0, 0, 0, 0);
    setTextToDefault(json, textBody);

    if (!json.isNull("posX"))
      textBody.setPosX(convertMeasurement(json.getString("posX")));
    if (!json.isNull("posY"))
      textBody.setPosY(convertMeasurement(json.getString("posY")));
    if (!json.isNull("width"))
      textBody.setWidth(convertMeasurement(json.getString("width")));
    if (!json.isNull("height"))
      textBody.setHeight(convertMeasurement(json.getString("height")));
    if (!json.isNull("fontsize"))
      textBody.setFontSize(json.getInt("fontsize"));
    if (!json.isNull("font"))
      textBody.setFont(json.getString("font"));
    if (!json.isNull("alignX"))
      textBody.setAlignX(convertAlignX(json.getString("alignX")));
    if (!json.isNull("alignY"))
      textBody.setAlignX(convertAlignY(json.getString("alignY")));
    if (!json.isNull("offset"))
      setOffset(json.getJSONObject("offset"), textBody);

    return textBody;
  }


  private Button createButton(JSONObject json) {
    if (json == null) throw new JSONNotFoundException("json was null in createButton");

    ClickEvent click = createClickEvent(json);
    Button button = new Button(0, 0, 0, 0, click);
    setButtonToDefault(json, button);

    if (!json.isNull("posX"))
      button.setPosX(convertMeasurement(json.getString("posX")));
    if (!json.isNull("posY"))
      button.setPosY(convertMeasurement(json.getString("posY")));
    if (!json.isNull("text"))
      button.setText(json.getString("text"));
    if (!json.isNull("width"))
      button.setWidth(convertMeasurement(json.getString("width")));
    if (!json.isNull("height"))
      button.setHeight(convertMeasurement(json.getString("height")));
    if (!json.isNull("font"))
      button.setFont(json.getString("font"));
    if (!json.isNull("fontsize"))
      button.setFontSize(json.getInt("fontsize"));
    if (!json.isNull("alignX"))
      button.setAlignX(convertAlignX(json.getString("alignX")));
    if (!json.isNull("alignY"))
      button.setAlignX(convertAlignY(json.getString("alignY")));
    if (!json.isNull("offset"))
      setOffset(json.getJSONObject("offset"), button);
    return button;
  }

  private Shape createShape(JSONObject json) {
    if (json == null) throw new JSONNotFoundException("json was null in createShape");
    if (json.isNull("source")) throw new JSONNotFoundException("{source} field not found in ShapeStyling");
    if (json.isNull("posX")) throw new JSONNotFoundException("{posX} field not found in ShapeStyling");
    if (json.isNull("posY")) throw new JSONNotFoundException("{posY} field not found in ShapeStyling");
    if (json.isNull("width")) throw new JSONNotFoundException("{width} field not found in ShapeStyling");
    if (json.isNull("height")) throw new JSONNotFoundException("{height} field not found in ShapeStyling");
    int x = convertMeasurement(json.getString("posX"));
    int y = convertMeasurement(json.getString("posY"));
    int w = convertMeasurement(json.getString("width"));
    int h = convertMeasurement(json.getString("height"));
    Shape shape = new Shape(json.getString("source"), x, y, w, h);
    return shape;
  }

  private Scale createScale(JSONObject json) {
    if (json == null) throw new JSONNotFoundException("json was null in createScale");
    if (json.isNull("number")) throw new JSONNotFoundException("{number} field not found in ScaleStyling"); 
    Scale scale = new Scale(json.getInt("number"), 0, 0, 0, 0);
    setScaleToDefault(json, scale);

    if (!json.isNull("posX"))
      scale.setPosX(convertMeasurement(json.getString("posX")));
    if (!json.isNull("posY"))
      scale.setPosY(convertMeasurement(json.getString("posY")));
    if (!json.isNull("descript"))
      scale.setDescription(json.getString("descript"));
    if (!json.isNull("width"))
      scale.setWidth(convertMeasurement(json.getString("width")));
    if (!json.isNull("height"))
      scale.setHeight(convertMeasurement(json.getString("height")));
    if (!json.isNull("descWidth"))
      scale.setDescWidth(convertMeasurement(json.getString("descWidth")));
    if (!json.isNull("descHeight"))
      scale.setDescHeight(convertMeasurement(json.getString("descHeight")));

    return scale;
  }

  private Timer createTimer(JSONObject json) {
    if (json == null) throw new JSONNotFoundException("json was null in createTimer");
    Timer timer = new Timer();
    setTimerToDefault(json, timer);
    if (!json.isNull("duration")) {
      timer.setDuration(convertTimeToMillis(json.getString("duration")));
    }
    if (!json.isNull("onTimer"))
      timer.setEvent(createTimerEvent(json.getString("onTimer")));
    return timer;
  }

  private TimerBar createTimerBar(JSONObject json) {
    if (json == null) throw new JSONNotFoundException("json was null in createTimer");
    TimerBar timerbar = new TimerBar(0, 0, 0, 0);
    setTimerBarToDefault(json, timerbar);
    if (!json.isNull("posX"))
      timerbar.setPosX(convertMeasurement(json.getString("posX")));
    if (!json.isNull("posY"))
      timerbar.setPosY(convertMeasurement(json.getString("posY")));
    if (!json.isNull("width"))
      timerbar.setWidth(convertMeasurement(json.getString("width")));
    if (!json.isNull("height"))
      timerbar.setHeight(convertMeasurement(json.getString("height")));
    return timerbar;
  }

  private TopicGame createTopicGame(JSONObject json) {
    if (json == null) throw new JSONNotFoundException("json was null in createTopicGame");
    if (json.isNull("posX")) throw new JSONNotFoundException("{posX} field not found in styling");
    if (json.isNull("posY")) throw new JSONNotFoundException("{posY} field not found in styling");
    if (json.isNull("width")) throw new JSONNotFoundException("{width} field not found in styling");
    if (json.isNull("height")) throw new JSONNotFoundException("{height} field not found in styling");
    if (json.isNull("bg")) throw new JSONNotFoundException("{bg} field not found in styling");
    if (json.isNull("file")) throw new JSONNotFoundException("{file} field not found in styling");
    TopicGame t = new TopicGame(0, 0, 0, 0);
    t.setPosX(convertMeasurement(json.getString("posX")));   
    t.setPosY(convertMeasurement(json.getString("posY")));   
    t.setWidth(convertMeasurement(json.getString("width")));   
    t.setHeight(convertMeasurement(json.getString("height")));  
    t.setBg(json.getString("bg"));
    t.setTopicsFile(json.getString("file"));
    setOffset(json.getJSONObject("offset"), t);
    if (!json.isNull("fontsize"))
      t.setFontSize(json.getInt("fontsize"));
    if (!json.isNull("font")) {
      t.setFont(json.getString("font"));
    }
    return t;
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////// HELPER FUNCTIONS  ////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////


  private void setOffset(JSONObject json, Button button) {
    if (json == null) throw new JSONNotFoundException("json was null in setOffset");
    if (!json.isNull("offsetX"))
      button.getOffset().setOffsetX(json.getInt("offsetX"));
    if (!json.isNull("offsetY"))
      button.getOffset().setOffsetY(json.getInt("offsetY"));
    if (!json.isNull("offsetW"))
      button.getOffset().setOffsetW(json.getInt("offsetW"));
    if (!json.isNull("offsetH"))
      button.getOffset().setOffsetH(json.getInt("offsetH"));
  }

  private void setOffset(JSONObject json, TopicGame game) {
    if (json == null) throw new JSONNotFoundException("json was null in setOffset");
    if (!json.isNull("offsetX"))
      game.getOffset().setOffsetX(json.getInt("offsetX"));
    if (!json.isNull("offsetY"))
      game.getOffset().setOffsetY(json.getInt("offsetY"));
    if (!json.isNull("offsetW"))
      game.getOffset().setOffsetW(json.getInt("offsetW"));
    if (!json.isNull("offsetH"))
      game.getOffset().setOffsetH(json.getInt("offsetH"));
  }

  private void setOffset(JSONObject json, TextBody text) {
    if (json == null) throw new JSONNotFoundException("json was null in setOffset");
    if (!json.isNull("offsetX"))
      text.getOffset().setOffsetX(json.getInt("offsetX"));
    if (!json.isNull("offsetY"))
      text.getOffset().setOffsetY(json.getInt("offsetY"));
    if (!json.isNull("offsetW"))
      text.getOffset().setOffsetW(json.getInt("offsetW"));
    if (!json.isNull("offsetH"))
      text.getOffset().setOffsetH(json.getInt("offsetH"));
  }

  private ClickEvent createClickEvent(JSONObject json) {
    if (json.isNull("onclick")) throw new JSONNotFoundException("{onclick} field not found in button");
    String onclick = json.getString("onclick");
    String[] split = onclick.split("-");
    if (split.length == 1) {
      switch(onclick) {
      default:
        return new ClickEvent(onclick) {
          public void onClick() {
            SceneManager.INSTANCE.setScene(id);
          }
        };
      }
    } else if (split.length == 2) {
      switch(split[0]) {
      case "scaleGather" :
        return new ClickEvent(split[1]) {
          public void onClick() {
            data.setShouldGather(true);
            SceneManager.INSTANCE.setScene(id);
          }
        };
      default:
        return new ClickEvent(split[1]) {
          public void onClick() {
            SceneManager.INSTANCE.setScene(id);
          }
        };
      }
    }
    return null;
  }

  private int convertMeasurement(String measurement) {
    measurement.replaceAll("\\s+", "");
    String[] split = measurement.split("(?=[/*+-])|(?<=[/*+-])"); 
    float result = strToFloat(split[0]);
    for (int i = 1; i < split.length; i += 2) {
      String operator = split[i];
      float operand = strToFloat(split[i+1]);
      switch(operator) {
      case "*":
        result *= operand;
        break;
      case "/":
        result /= operand;
        break;
      case "+":
        result += operand;
        break;
      case "-":
        result -= operand;
        break;
      default:
        continue;
      }
    }
    return int(result);
  }

  private float strToFloat(String str) {
    switch(str) {
    case "height":
      return height;
    case "width":
      return width;
    default:
      return Float.parseFloat(str);
    }
  }


  private int convertAlignX(String alignment) {
    switch(alignment) {
    case "center":
      return CENTER;
    case "right":
      return RIGHT;
    default:
      return LEFT;
    }
  }

  private int convertAlignY(String alignment) {
    switch(alignment) {
    case "center":
      return CENTER;
    case "top":
      return TOP;
    case "bottom":
      return BOTTOM;
    default:
      return BASELINE;
    }
  }
}

private Timer buildTimer(String duration, String onTimer) {
  TimerEvent event = createTimerEvent(onTimer);
  Timer timer = new Timer();
  timer.setEvent(event);
  timer.setDuration(convertTimeToMillis(duration));
  return timer;
}

private TimerEvent createTimerEvent(String onTimer) {
  switch(onTimer) {
  default:
    return new TimerEvent(onTimer) {
      public void onTimeUp() {
        SceneManager.INSTANCE.setScene(id);
      }
    };
  }
}

private int convertTimeToMillis(String time) {
  String[] split = time.split(":."); 
  int mult[] = {1000, 60000, 360000};
  int result = 0;
  if (split.length <= 3) {
    for (int i = 0; i < split.length; ++i) {
      result += Integer.parseInt(split[(split.length - 1) - i]) * mult[i];
    }
    return result;
  }
  return -1;
}

public class JSONNotFoundException extends RuntimeException {
  public JSONNotFoundException(String msg) {
    super("JSONNotFoundException: " + msg);
  }
}
