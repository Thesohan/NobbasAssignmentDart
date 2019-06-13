/*
* created-By - Sohan Kathait
* created-On - 13-Jun-2019, Thu
* Email - sohan.cse16@nituk.ac.in
* PhoneNo. - 8126583671
* Location - Dehradun, Uttarakhand, India
* 
* */



// for IO and async operation
import 'dart:async';
import 'dart:io';
// to convert string into json.
import 'dart:convert';


class MyPlane {
    Plane plane; 
    List<Coordinate> hitPoints; //it will contain all the hitPoints.

    MyPlane({this.plane,this.hitPoints});// Parameterize constructor

    //initialisation using custom constructor
    MyPlane.fromJson(Map<String, dynamic> json) {
      
      plane = json['plane'] != null
              ? new Plane.fromJson(json['plane']) 
              : null;

      if (json['hitPoints'] != null) {
        hitPoints = new List<Coordinate>();
        json['hitPoints'].forEach((v) {
          hitPoints.add(new Coordinate.fromJson(v));
        });
      }
    }


    List<bool> checkOnPlane(){
        List<bool> ans=new List<bool>();
        for(int i=0;i<this.hitPoints.length;i++){
            ans.add(isOnPlane(this.hitPoints[i].x,this.hitPoints[i].y));
        }
        return ans;
    }

    bool isOnPlane(double x, double y){
      if(x>=this.plane.topLeft.x 
        && x<=this.plane.bottomRight.x 
        && y>=this.plane.topLeft.y 
        && y<=this.plane.bottomRight.y 
        )
      {
        return true;
      }

      return false;
    }

    void showOutput(List<bool> ans){
      for(int i=0;i<ans.length;i++){
        print(ans[i]);
      }
    }
}

class Plane {
  //since topLeft AND bottomRight are having the same kind of objects
  Coordinate topLeft;
  Coordinate bottomRight;

  Plane({this.topLeft, this.bottomRight});// Parameterize constructor

    //initialisation using custom constructor
  Plane.fromJson(Map<String, dynamic> json) {
    
    topLeft = json['topLeft'] != null
              ? new Coordinate.fromJson(json['topLeft'])
              : null;
    
    bottomRight = json['bottomRight'] != null
              ? new Coordinate.fromJson(json['bottomRight'])
              : null;
  }

}

class Coordinate {
  double x;
  double y;

  Coordinate({this.x, this.y});// Parameterize constructor

    //initialisation using custom constructor
  Coordinate.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

}



void main() {
  
  // Reading data from text json file fomr the same directory asynchronously.
  new File('data.json').readAsString().then((String contents) {
      var jsonResponse = json.decode(contents); //converting the string into json object
      MyPlane myPlane=MyPlane.fromJson(jsonResponse); // initialisation using custom constructor.
      List<bool> ans=myPlane.checkOnPlane(); // checking whether hitPoints are on the plane or not.
  
      myPlane.showOutput(ans);

    });

}
