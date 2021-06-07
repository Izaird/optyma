//All our Ticker class does is expose a tick function which takes the number 
//of ticks (seconds) we want and returns a stream which emits the remaining 
//seconds every second.

class Ticker{
  Stream<int> tick({int thicks}){
    return Stream.periodic(Duration(seconds: 1), (x) => thicks - x - 1)
      .take(thicks);
  }
}