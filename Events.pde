abstract class ClickEvent {
  String id;

  public ClickEvent(String _id) {
    id = _id;
  }

  public abstract void onClick();
}

abstract class TimerEvent {
  String id;

  public TimerEvent(String _id) {
    id = _id;
  }

  public abstract void onTimeUp();
}

abstract class Style {
  public abstract void setStyle(int x, int y, int w, int h);
}

abstract class HoverEvent {
  public abstract void onHover(int x, int y, int w, int h);
}

public interface Initializable {
  public abstract void onInit(); 
}

public class Timer {

  private int currentT;
  private int end, duration;
  private TimerEvent event;
  private boolean sounded;
  private boolean active;

  public Timer() {
    sounded = false;
    event = null;
    end = -1;
  }

  public void update() {
    if (!active) return;
    currentT = millis();
    if (currentT >= end && !sounded) {
      if (event != null) {
        event.onTimeUp();
        stop();
      }
      sounded = true;
    }
  }

  public TimerEvent getEvent() {
    return event;
  }

  public void setEvent(TimerEvent _event) {
    event = _event;
  }
  
  public int getCurrentT() {
    return currentT;  
  }
  
  public int getEndT() {
    return end;  
  }

  public int getDuration() {
    return duration;
  }

  public void setDuration(int _duration) {
    duration = _duration;
  }

  public void start() {
    if (duration > 0) {
      active = true; 
      end = (millis() + duration);
      sounded = false;
    }
  }

  public void stop() {
    active = false;
  }

  public void setSounded(boolean _sounded) {
    sounded = _sounded;
  }
}
